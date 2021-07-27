/*
********************************************************************************************
* Name          ContentVersionService 
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   01/28/2020
* UsedBy        The ContentVersionApiController is responsible for calling 
                ContentVersionQueueable Class.
*********************************************************************************************
*/
public with sharing class ContentVersionService{
    /*
    * @This method is called from ContentVersionTriggerHandler and used to get document id and case ids and send to queuable job
    * @Name:sendRequest
    * @Created Date: 28th January 2020
    * @Author : Deepak Kumar Reddy Regatte(Enforcers)
    * @Description Jira user story PRCDM2-1386   
    */
    public static void sendRequest(Map<Id, sObject> mapFiles){
        Set<id> setContentDocumentIds = new Set<id>();
        Set<id> setContentDocumentLinkEntityIDs = new Set<id>();
        Map<Id,ContentVersion> mapFileIdvsFileRecords= new Map<Id,ContentVersion>();
        for(SObject c: mapFiles.Values()){
            ContentVersion cV = (ContentVersion)c; 
            setContentDocumentIds.add(cV.ContentDocumentId);
            //TO CREATE CONTENTDOCUMENTLINK RECORDS FOR UNZIPPED FILES.
            //User Story 2433
            if(cV.CaseId__c != null && cV.CaseId__c.startsWith(staticVariableClass.GET_CASEID)){
                mapFileIdvsFileRecords.put(cV.Id,cV); 
            }    
        }if(mapFileIdvsFileRecords!=null && !mapFileIdvsFileRecords.IsEmpty() ){
            LGZipUtility.createContentDocLinkUnzippedFiles(mapFileIdvsFileRecords);
        }
        Map<id,List<id>> mapEntityIdWithCDlink = new Map<id,List<id>>();
        Map<Id, List<ContentDocumentLink>> mapEntityIdContentDocument = new Map<Id, List<ContentDocumentLink>>(); //map to store contentlink for zipped files
        Id caseRecordTypeID = Utility.sObjectRecordTypeID(staticVariableClass.STRING_CASE, staticVariableClass.CASE_RFP_INTAKE_RECORDTYPE_NAME );
        List<ID> listContentVersionIDs = new List<ID>();
        List<ContentVersion> listContentVersionToShare = new List<ContentVersion>();
        for(ContentDocumentLink c: [SELECT ContentDocumentId,Id,LinkedEntityId, LinkedEntity.type, LinkedEntity.recordtypeId, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink where ContentDocumentId IN: setContentDocumentIds]){
            ContentVersion objectContentVersion = (ContentVersion)mapFiles.get(c.ContentDocument.LatestPublishedVersionId);
            
            if((c.LinkedEntity.type==staticVariableClass.STRING_CASE 
                && c.LinkedEntity.recordtypeId == caseRecordTypeID)  
                || c.LinkedEntity.type==staticVariableClass.EMAIL_MESSAGE 
                || Test.isRunningTest()) {
                    
                if(objectContentVersion.FileType.equalsIgnoreCase(staticVariableClass.FILE_FORMAT_ZIPFILE) && Trigger.isInsert) { //zip content
                    LGZipUtility.identifyZippedContent(mapEntityIdContentDocument, c);
                }
                    
                else if(objectContentVersion.FileType.touppercase() == staticVariableClass.FILE_FORMAT_XLS.touppercase()
                || objectContentVersion.FileType.touppercase() == staticVariableClass.FILE_FORMAT_XLSX.touppercase()
                || objectContentVersion.FileType.touppercase() == staticVariableClass.FILE_FORMAT_PDF.touppercase()){
                    listContentVersionToShare.add(objectContentVersion);
                    identifyNLPContent(mapEntityIdWithCDlink, c); 
                }else {
                    
                   listContentVersionIDs.add(objectContentVersion.ID);
                    
                }                      
            } 
            
        }
        //TO SHARE THE MANUALLY UPLOADED FILES.
       //User Story 2433
       
       if(!listContentVersionToShare.isEmpty()){
           LGZipUtility.shareFilesToServiceInternalUser(listContentVersionToShare);
       }
        
        if(!listContentVersionIDs.isEmpty()){
            List<ContentVersion> listContentVersionUpdate = [select id, Response_Status__c, Error_Message__c from ContentVersion where ID IN:listContentVersionIDs];
            for(ContentVersion objectContentVersion: listContentVersionUpdate){
                objectContentVersion.Response_Status__c = staticVariableClass.ERROR_CODE_400; 
                objectContentVersion.Error_Message__c = staticVariableClass.ERROR_MESSAGE_400;        
            } 
            Update listContentVersionUpdate;
        }

        for(EmailMessage eM: [SELECT id, parentID from EmailMessage where (Id IN: mapEntityIdWithCDlink.keyset() OR Id IN: mapEntityIdContentDocument.keyset()) and parent.recordtypeid =:caseRecordTypeID]){
            if(mapEntityIdWithCDlink.containsKey(eM.Id)) { //check if email belongs to NLP content 
                if(mapEntityIdWithCDlink.containskey(eM.parentID)){
                    List<Id> listCDLinkId = mapEntityIdWithCDlink.get(eM.parentID);
                    listCDLinkId.addAll(mapEntityIdWithCDlink.get(eM.Id));
                    mapEntityIdWithCDlink.put(eM.parentID, listCDLinkId);
                }
                else{  
                    mapEntityIdWithCDlink.put(eM.parentID, mapEntityIdWithCDlink.get(eM.Id));
                }
                mapEntityIdWithCDlink.remove(eM.Id);
            } 
            if (mapEntityIdContentDocument.containsKey(eM.Id)) { //check if email belongs to zip content
                LGZipUtility.identifyEmailZippedContent(mapEntityIdContentDocument, mapEntityIdContentDocument.get(eM.Id), eM );
                mapEntityIdContentDocument.remove(eM.Id);
            }                         
        }
        if(!mapEntityIdWithCDlink.isEmpty()){
            system.enqueueJob(new ContentVersionQueueable(mapEntityIdWithCDlink,setContentDocumentIds)); 
        }
        if(!mapEntityIdContentDocument.isEmpty()) {       //handle all zip content         
            LGZipUtility.createZipContent(mapEntityIdContentDocument);
        }
     }

       /*
     * @This method is called from ContentVersionService to identify content for NLP
     * @Name:identifyNLPContent
     * @Created Date: 17th February 2020
     * @Author : Deloitte Consulting
     * @Description Jira user story PRCDM2-1497   
     */
    private static void identifyNLPContent(Map<Id, List<Id>> mapEntityIdContentDocument, ContentDocumentLink objectDocumentLink) {
        List<Id> listContentDocumentId;
        if(mapEntityIdContentDocument.containsKey(objectDocumentLink.LinkedEntityId)) {
            listContentDocumentId = mapEntityIdContentDocument.get(objectDocumentLink.LinkedEntityId);                    
        } else {
            listContentDocumentId = new List<Id>();                    
        }            
        listContentDocumentId.add(objectDocumentLink.ContentDocumentId);
        mapEntityIdContentDocument.put(objectDocumentLink.LinkedEntityId, listContentDocumentId);
    }
     /*
     * @This method is used to Persist the data into request tracking object once Http responce is received.
     * @Name:persistResponce
     * @Created Date: 10th February 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1356   
     */
     public static void persistResponce(HttpResponse response, ID caseID, String requestID, Set<ID> setContentVersionIds){
        Map<Integer, String> mapErrorCodesMessages =  new Map<Integer, String>();
        mapErrorCodesMessages.put(staticVariableClass.ERROR_CODE_1001, staticVariableClass.ERROR_MESSAGE_1001);
        mapErrorCodesMessages.put(staticVariableClass.ERROR_CODE_1002, staticVariableClass.ERROR_MESSAGE_1002);
        mapErrorCodesMessages.put(staticVariableClass.ERROR_CODE_3002, staticVariableClass.ERROR_MESSAGE_3002);
        mapErrorCodesMessages.put(staticVariableClass.ERROR_CODE_3005, staticVariableClass.ERROR_MESSAGE_3005);
        mapErrorCodesMessages.put(staticVariableClass.ERROR_CODE_3006, staticVariableClass.ERROR_MESSAGE_3006);
        mapErrorCodesMessages.put(staticVariableClass.ERROR_CODE_3104, staticVariableClass.ERROR_MESSAGE_3104);
        Integer iResponseCode = response.getstatuscode();
        String sErrorMessage;
        if(mapErrorCodesMessages.containskey(iResponseCode)){
            
            sErrorMessage = mapErrorCodesMessages.get(iResponseCode);        
        }
        else {
            if(iResponseCode!=staticVariableClass.ERROR_CODE_200 
               && iResponseCode!=staticVariableClass.ERROR_CODE_203 
               && iResponseCode!=staticVariableClass.ERROR_CODE_204){
                   
                sErrorMessage = staticVariableClass.ERROR_MESSAGE_DEFAULT;   
            }
        }
        Request_Tracking__c rT = new Request_Tracking__c();
        rT.CaseID__c= caseID;
        rT.RequestID__c = requestID;
        rT.Status__c = String.valueof(iResponseCode);
        rT.Error_Message__c = sErrorMessage;
        insert rT;  
        List<ContentVersion> listContentVersion = new  List<ContentVersion>();
        if(setContentVersionIds != null && !setContentVersionIds.isEmpty()){
          for(ID cVID: setContentVersionIds){
              ContentVersion oCV = new ContentVersion();
                oCV.ID = cVID;
                oCV.Request_Tracking_ID__c = rT.ID;
                listContentVersion.add(oCV);
            }
         }
        if(!listContentVersion.isEmpty()){
            update listContentVersion;
        }
    }    
}
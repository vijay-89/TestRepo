/*
*******************************************************************************************
* Name          LGZipUtility 
* Author        Deloitte Consulting
* ModifiedBy    Deloitte Consulting
* CreatedDate   11 Feb 2020
* UsedBy        ContentVersionNLPService to handle zip files and create zipContent record
*********************************************************************************************
*/
public with sharing class LGZipUtility {

        /*
     * @This method is called from ContentVersionService to identify content which are added to email/case
     * @Name:identifyZippedContent
     * @Created Date: 7th February 2020
     * @Author : Deloitte Consulting
     * @Description Jira user story PRCDM2-1497   
     */
    public static void identifyZippedContent(Map<Id, List<ContentDocumentLink>> mapEntityIdContentDocument, ContentDocumentLink objectDocumentLink) {
        List<ContentDocumentLink> listContentLink;
        if(mapEntityIdContentDocument.containsKey(objectDocumentLink.LinkedEntityId)) {
            listContentLink = mapEntityIdContentDocument.get(objectDocumentLink.LinkedEntityId);                    
        } else {
            listContentLink = new List<ContentDocumentLink>();                    
        }            
        listContentLink.add(objectDocumentLink);
        mapEntityIdContentDocument.put(objectDocumentLink.LinkedEntityId, listContentLink);
    }

    /* 
     * @This method is called from ContentVersionService to identify content which are added to email and find its parent case
     * @Name:identifyEmailZippedContent
     * @Created Date: 7th February 2020
     * @Author : Deloitte Consulting
     * @Description Jira user story PRCDM2-1497   
     */
    public static void identifyEmailZippedContent(Map<Id, List<ContentDocumentLink>> mapEntityIdContentDocument, List<ContentDocumentLink> listContentDocument, EmailMessage objectEmailMessage) {
        if(mapEntityIdContentDocument.containskey(objectEmailMessage.parentId)){
            List<ContentDocumentLink> listContentLink = mapEntityIdContentDocument.get(objectEmailMessage.parentId);
            listContentLink.addAll(listContentDocument);
            mapEntityIdContentDocument.put(objectEmailMessage.parentID, listContentLink);
        }
        else{  
            mapEntityIdContentDocument.put(objectEmailMessage.parentID, listContentDocument);
        }
    } 
    
        /*
     * @This method is called from ContentVersionService and used to create zipContent records
     * @Name:createZipContent
     * @Created Date: 11 Feb 2020
     * @Author : Deloitte Consulting
     * @Description Jira user story PRCDM2-1497   
     */
    public static void createZipContent(Map<Id, List<ContentDocumentLink>> mapCaseIdContentDocument) {    
        FINAL String CLASS_NAME = LGZipUtility.class.getName();
        String sBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        try {
                if(sBaseURL.startsWith('http:')){
                    sBaseURL = sBaseURL.replaceFirst('http:', 'https:');
                }
            List<ZipContent__c> listZipContent = new List<ZipContent__c>();
            for(Id oCaseId : mapCaseIdContentDocument.keySet()) {
                for(ContentDocumentLink oDocumentLink : mapCaseIdContentDocument.get(oCaseId)) {
                    listZipContent.add(new ZipContent__c(RelatedObjectId__c = oCaseId, ContentDocumentId__c = oDocumentLink.contentDocumentId, ContentVersion__c = oDocumentLink.ContentDocument.LatestPublishedVersionId, Status__c = 'New', 
                    BasePath__c = sBaseURL + String.format(Label.contentVersionURL, new List<String>{oDocumentLink.ContentDocument.LatestPublishedVersionId})));
                }                
            }
            if(!listZipContent.isEmpty()) {
                Database.insert(listZipContent);
            }
            
        }
        catch(Exception excn){
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.Entity,
            CLASS_NAME, staticVariableClass.GET_CREATEZIP_METHOD, null, LoggingLevel.ERROR);
        }   
    }
     /*
     * @This method is called from ContentVersionService and used to create Linking of unzipped Records
     * @Name:createContentDocLinkUnzippedFiles
     * @Created Date: 02 Mar 2020
     * @Author : Deloitte Consulting
     * @Description : User Story PRDCRM2-2433
     */
    public static void createContentDocLinkUnzippedFiles(Map<Id, ContentVersion> mapFiles){
        FINAL String CLASS_NAME = LGZipUtility.class.getName();
        try{
            Map<Id,ContentDocument> mapContentDocIdvsContentDoc = new Map<Id,ContentDocument>();
            //Fetching the Content Document that got created while unzipped files were inserted.
            for(ContentDocument oContentDoc : [Select Id,LatestPublishedVersionId 
                                               FROM ContentDocument
                                               WHERE LatestPublishedVersionId
                                               IN :mapFiles.keyset()]){
                mapContentDocIdvsContentDoc.put(oContentDoc.LatestPublishedVersionId,oContentDoc);
            }
            List<ContentDocumentLink> listContentDocumentInsert= new List<ContentDocumentLink>();
            List<ContentDocumentLink> listContentDocumentFetch= new List<ContentDocumentLink>();
            //Creating ContentDocumentLink Records to map unzipped Files with cases.
            for(ContentVersion oConVersion: mapFiles.Values()){
                  if(mapFiles.containsKey(oConVersion.Id) && mapContentDocIdvsContentDoc.containsKey(oConVersion.Id)){
                    listContentDocumentFetch = createDocLinksUnzippedFiles(mapFiles.get(oConVersion.Id).CaseId__c, mapContentDocIdvsContentDoc.get(oConVersion.Id).Id);
                    listContentDocumentInsert.addAll(listContentDocumentFetch );
                    listContentDocumentFetch.clear();
                }
            }
            
            if(!listContentDocumentInsert.isEmpty() && Schema.sObjectType.ContentDocumentLink.isCreateable()){
                Database.insert(listContentDocumentInsert);
            }
             
        }catch(Exception excn){
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.Entity,
            CLASS_NAME, staticVariableClass.GET_CONTENTDOCLINK_METHOD, null, LoggingLevel.ERROR);
        }  
    }
    /*
     * @This method is called from createDocLinksUnzippedFiles and used to create ContentLink Doc
     * @Name: createDocLinks
     * @Created Date: 05 Mar 2020
     * @Author : Deloitte Consulting
     * @Description :  User Story PRDCRM2-2433
     */
        private static List<ContentDocumentLink>  createDocLinksUnzippedFiles(Id caseId,Id docId){
            List<ContentDocumentLink> listContentDocumentToInsert= new List<ContentDocumentLink>();
            if (caseId!= null && docId != null){
                ContentDocumentLink oContentDocLink = new ContentDocumentLink();
                oContentDocLink.ContentDocumentId = docId ;
                oContentDocLink.LinkedEntityId = caseId;
                listContentDocumentToInsert.add(oContentDocLink);
            }
            return listContentDocumentToInsert;
        }
     /*
     * @This method is called from ShareManuallyUploadedFiles to IntegrationUser
     * @Name: shareFilesToServiceInternalUser
     * @Created Date: 05 Mar 2020
     * @Author : Deloitte Consulting
     * @Description : User Story PRDCRM2-2433
     */
        public static void shareFilesToServiceInternalUser(List<ContentVersion> listConVersion){
            List<ContentDocumentLink> listContentDocLink = new List<ContentDocumentLink>();
            Id serviceUserId  = fetchServiceInternalUserId();
            if(serviceUserId != null){
                for(ContentVersion oConVersion: listConVersion){
                    if(oConVersion.CaseId__c == null && oConVersion.ContentDocumentId != null){
                        ContentDocumentLink oDocLink = new ContentDocumentLink();
                        oDocLink.ContentDocumentId = oConVersion.ContentDocumentId;
                        oDocLink.LinkedEntityId = serviceUserId;
                        oDocLink.ShareType = System.Label.ContentVersionAccess;
                        listContentDocLink .add(oDocLink);
                    }
                }
            }if(Schema.sObjectType.ContentDocumentLink.isCreateable() && !listContentDocLink.isEmpty() ){   
                Database.Insert(listContentDocLink);
            }
        }
      /*
    * @This method is used to get Service Integration Internal User Id .
    * @Name:fetchServiceInternalUserId  
    * @Created Date: 03/08/2020
    * @Author : Deloitte (Harmony)
    * @Description : User Story PRDCRM2-2433
    */
    @testVisible
    private static Id fetchServiceInternalUserId (){
        FINAL String CLASS_NAME = LGZipUtility.class.getName();
        Id serviceUserId ;
        try{
            User oUser  = [Select Id FROM USER 
                                     WHERE Profile.Name=:staticVariableClass.SERVICE_INTEGRATION_PROFILE 
                                     AND IsActive = true LIMIT 1];
            serviceUserId = oUser.Id;
       }catch(Exception excn){
           UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.Entity,
           CLASS_NAME, staticVariableClass.GET_CONTENTDOCLINK_METHOD, null, LoggingLevel.ERROR);
           return null;
       }
        return serviceUserId;
    }
}
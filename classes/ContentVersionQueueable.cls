/*
*******************************************************************************************
* Name          ContentversionQueueable
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   01/29/2020
* UsedBy        The ContentversionQuable is called from ContentVersionNLPService and is responsible to build JSON Structure and
                call the Http callout class.
*********************************************************************************************
*/
public with sharing class ContentVersionQueueable implements Queueable,Database.AllowsCallouts{
    String sClassName = ContentVersionQueueable.class.getName();
    String sApigeeCalloutMethod  =  staticVariableClass.CONTENT_VERSION_QUEUEABLE_APIGEE_CALLOUT;
    public Map<id,List<id>> mapCaseIdsWithCDLinkId{get;set;}
    public Set<id> setDocumentIds{get;set;}
    /*
     * @This Constructor is called from ContentVersionNLPService and  used Intializing and assigning class variables
     * @Name:ContentVersionQueueable
     * @Created Date: 29th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1386   
    */
    public ContentVersionQueueable(Map<id,List<id>> mapCaseIdsWithCDLinkId,Set<id> setDocumentIds){ 
        this.mapCaseIdsWithCDLinkId = new Map<id,List<id>>();
        this.mapCaseIdsWithCDLinkId = mapCaseIdsWithCDLinkId;
        this.setDocumentIds = new Set<id>();
        this.setDocumentIds = setDocumentIds;
    }
    /*
     * @This is the implementation method
     * @Name:execute
     * @Created Date: 29th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1386   
    */
    public void execute(QueueableContext context){
        List<ContentVersion> listFiles = [select id,ContentDocumentId,FileType,VersionData from  ContentVersion where ContentDocumentId=: setDocumentIds and IsLatest=true];
        Map<id,contentversion> mapDocIdToContentVersion = new Map<id,contentversion>();
        for(contentversion cv : listFiles){
            mapDocIdToContentVersion.put(cv.ContentDocumentId,cv);   
        }

        List<case> listCases =[SELECT id,Account.Anthem_Entity__c,createdDate,casenumber from Case where id =:mapCaseIdsWithCDLinkId.keyset()];
        if(!listcases.isEmpty()){
            for(case objcase: listCases){
                NlpServiceRequestWrapper.MetaData nSrwMetaData = new NlpServiceRequestWrapper.MetaData();
                nSrwMetaData.topicName = label.Topic;
                NlpServiceRequestWrapper.Events nSrwEvents = new NlpServiceRequestWrapper.Events();
				nSrwEvents.requestId = string.valueof(system.hashcode(objcase.casenumber+system.now()));
                nSrwEvents.channel =  label.channel ; 
                nSrwEvents.lobType = objcase.Account.Anthem_Entity__c!=null?objcase.Account.Anthem_Entity__c:label.lobType;
                nSrwEvents.requestStartDate = string.valueof(system.now());
                nSrwEvents.businessContextId = objcase.id; 
                List<NlpServiceRequestWrapper.Document> listDc = new List<NlpServiceRequestWrapper.Document>();
                Set<ID> setContentVersionIds = new Set<ID>();
                for(id  c: mapCaseIdsWithCDLinkId.get(objcase.id)){  
                    if(mapDocIdToContentVersion.containskey(c)){ 
                        NlpServiceRequestWrapper.Document dC = new NlpServiceRequestWrapper.Document();
                        dC.documentLocation =  System.URL.getSalesforceBaseURL().toExternalForm()+'/'+'services/data'+'/'+label.Version_Number+'/'+'sobjects/ContentVersion'+'/'+mapDocIdToContentVersion.get(c).Id+'/'+'VersionData';
                        dC.documentId = mapDocIdToContentVersion.get(c).Id;
                        dC.documentType = mapDocIdToContentVersion.get(c).FileType;
                        listDc.add(dC);
                        setContentVersionIds.add(mapDocIdToContentVersion.get(c).Id);
                    }
                }
                nSrwEvents.document = listDc;
                List<NlpServiceRequestWrapper.Events> listEvents = new List<NlpServiceRequestWrapper.Events>();
                listEvents.add(nSrwEvents);
                
                NlpServiceRequestWrapper  nSrw = new NlpServiceRequestWrapper(); 
                nSrw.metadata  = nSrwMetaData;
                nSrw.events= listEvents;
                String requestJSON = System.json.serialize(nSrw);
                if(!Test.isRunningTest()){
                    apigeeCallout(requestJSON, objcase.id, string.valueof(system.hashcode(objcase.casenumber+system.now())), setContentVersionIds);  
                }   
            }
       }
    }
    /*
     * @This method is used to construct Json and call HTTPCallout class.
     * @Name:apigeeCallout
     * @Created Date: 29th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1386 
    */
    public void apigeeCallout(String requestJSON, ID caseID, String requestID, Set<ID> setContentVersionIds){
        Map<string,string> authParameter = new Map<string,string>();
        IntegrationTokenDetails tokenDetail = new IntegrationTokenDetails();
        tokenDetail = new IntegrationUtility().AccessToken();
        Integration_EndPoint_Setting_Details__mdt endPointInfo = Utility.getCustomMetaDataType();
        String endpoint = endPointInfo.End_Point_URL__c;
        String authorization = 'Bearer ' + tokenDetail.access_token;
        String apiKey = endPointInfo.ApiKey__c;
        authParameter.put('authorization',authorization);
        authParameter.put('endpoint',endpoint);
        authParameter.put('apiKey',apiKey);
        try{
            HttpResponse response =  HttpRequestCalloutsUtility.HttpRequestCallouts(requestJSON,authParameter,null,null);
            parseResponse(response, caseID, requestID, setContentVersionIds);
        }
        catch(exception e){
            UTIL_LoggingService.logHandledException(e, ANA_UTIL03_Constants.ORGID, ANA_UTIL03_Constants.APPNAME,
            sClassName, sApigeeCalloutMethod, null, LoggingLevel.ERROR);
        }        
     }
     /*
     * @This method is used to parse the HttpResponse Json and pass the Values to ContentVersionService.persistResponce 
       class,Method to insert a Request tracking record .
     * @Name:parseResponse
     * @Created Date: 10th February 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1356  
     */
     public void parseResponse(HttpResponse response, ID caseID, String requestID, Set<ID> setContentVersionIds ){
        ContentVersionService.persistResponce(response, caseID, requestID, setContentVersionIds);
     }
      

}
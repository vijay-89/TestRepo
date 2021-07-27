/*
*******************************************************************************************
* Name          NLPFileResponse_WS 
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   01/29/2020
* UsedBy        This is the rest service class which will be Invoked from NLP application 
                to post the benefits and census file data to salesforce.
********************************************************************************************/

@RestResource(urlMapping='/processNLPResponse')
global with sharing class NLPFileResponse_WS{

    public class DocumentResponse{
        public String requestId {get;set;}
        public String businessContextId {get;set;}
        public String transactionStatus {get;set;}
        public DocumentInformation[] document {get;set;}
    }

    public class DocumentInformation{
        public String Id {get;set;}
        public String context {get;set;}
        public DocumentErrorInformation[] errors {get;set;}
        public BenefitData data {get;set;}
    }

    //Added to check If data node is coming from NLP to handle partial success scenario for census, no need to parse the data node here as it will be parsed in BenefitUtitlity or CensusUtility class
    public class BenefitData{
	}
    
    public class DocumentErrorInformation{
        public String code {get;set;}	
        public String description {get;set;}
    }

    /*
    _________________________________________________________________________________________
    
    *@description: This method will be Invoked when NLP performs post request to rest resource URL to parse and persist NLP response data into benefits and census objects.
    _________________________________________________________________________________________
    
    *@return: Void
    _________________________________________________________________________________________
    */
    @HttpPost
    global static void parseAndPersistNLPResponse(){
        try{
            RestRequest restRequest = RestContext.request;
            if(restRequest != null){
                Blob blobRequestBody = restRequest.requestBody;
                String sNLPFileResponse = blobRequestBody.toString();

                if(!String.isEmpty(sNLPFileResponse))
                    categorizeBenefitsAndCensusData(sNLPFileResponse);
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.NLP_WS_CLASS_NAME,StaticVariableClass.PARSE_AND_PERSIST_METHOD, null, LoggingLevel.ERROR);
        }
    }

    /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to categorize benefits and census data 
    based on context parameter coming from NLP response JSON.
    _______________________________________________________________________________________

    *@param: sNLPFileResponse - holds the NLP file response body - String
    ____________________________________________________________________________________
    
    *@return: Void
    _________________________________________________________________________________________
    */
    public static void categorizeBenefitsAndCensusData(String sNLPFileResponse){
       try{
           //Deserialize NLP file response into wrapper class to find document context and errors Information
           DocumentResponse oDocumentResponse = (DocumentResponse) JSON.deserialize(sNLPFileResponse, DocumentResponse.class);
           
            if(oDocumentResponse != null){
                //Checking If document Information is coming from NLP
                if(oDocumentResponse.document != null && !oDocumentResponse.document.isEmpty()){
                    DocumentInformation oDocumentInformation = oDocumentResponse.document[0];

                    //Checking If document has any errors
                    Boolean bHasAnyDocumentErrors = ((oDocumentInformation.errors != null && !oDocumentInformation.errors.isEmpty()) ? true : false);
                    
                    //If document context is Benefit
                    if(oDocumentInformation.context != null && oDocumentInformation.context.trim() == staticVariableClass.BENEFIT && !bHasAnyDocumentErrors){
                        //Calling utility class method to parse benefit data from NLP response JSON
                        BenefitUtility.parseJSONResponse(sNLPFileResponse);
                    }
                    //If document context is Census
                    else if(oDocumentInformation.context != null && oDocumentInformation.context.trim() == staticVariableClass.CENSUS && oDocumentInformation.data != null){
                        CensusUtility.parseJSONResponse(sNLPFileResponse);
                    } 

                    //Method called to update response status in content version record
                    updateResponseInformationOnFile(oDocumentResponse);
                }
            }
       }
       catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.NLP_WS_CLASS_NAME,StaticVariableClass.CATEGORIZE_BENEFITS_CENSUS_METHOD, null, LoggingLevel.ERROR);
       }
    }

     /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to update response Information in content version record.
    _______________________________________________________________________________________

    *@param: oDocumentResponse - holds the document response received from NLP - DocumentResponse
    *@param: bHasAnyDocumentErrors - Which Indicates whether document has errors or not  - Boolean
    ____________________________________________________________________________________
    
    *@return: void
    _________________________________________________________________________________________
    */
    private static void updateResponseInformationOnFile(DocumentResponse oDocumentResponse){
        try{
            //Checking if content version Id is present to update response Information
            if(oDocumentResponse.document[0].id != null) {
                //Querying content version to get content document Id
                List<ContentVersion> listContentVersion = [Select ContentDocumentId
                                                           From ContentVersion
                                                           Where Id =:oDocumentResponse.document[0].id.trim()];
                if(!listContentVersion.isEmpty()){
                    //Querying latest content version of content document to update response Information
                    List<ContentDocument> listContentDocument = [Select Id,(Select Id from 
                                                                ContentVersions where IsLatest = true) 
                                                                from ContentDocument 
                                                                where Id =: listContentVersion[0].ContentDocumentId];

                   if(!listContentDocument.isEmpty() && !listContentDocument[0].ContentVersions.isEmpty()){
                       ContentVersion oContentVersion = listContentDocument[0].ContentVersions[0];
                       oContentVersion.Response_Status__c = (oDocumentResponse.transactionStatus != null ? oDocumentResponse.transactionStatus : '');
                       oContentVersion.Error_Message__c = '';
                       
                        //Checking If document has any errors
                        if(oDocumentResponse.document[0].errors != null && !oDocumentResponse.document[0].errors.isEmpty() &&   oDocumentResponse.document[0].data == null){
                            oContentVersion.Response_Status__c = oDocumentResponse.document[0].errors[0].code != null ? oDocumentResponse.document[0].errors[0].code : '';
                            oContentVersion.Error_Message__c = oDocumentResponse.document[0].errors[0].description != null ? oDocumentResponse.document[0].errors[0].description : '';
                        }
                        update oContentVersion;
                   } 
                }                                   
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.NLP_WS_CLASS_NAME,StaticVariableClass.UPDATE_CONTENT_VERSION_METHOD, null, LoggingLevel.ERROR);
        }
    }
}
/*
*******************************************************************************************
* Name          CensusUtility 
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   07/02/2020
* UsedBy        This will be a utility class for census object data operations
*******************************************************************************************
*/

public with sharing class CensusUtility{
    /*
  _________________________________________________________________________________________
  
  *@description: This method will be used to parse NLP census response
  _______________________________________________________________________________________
  
  *@param: sNLPFileResponse - holds the census file response body - String
  ____________________________________________________________________________________
  
  *@return: Void
  _________________________________________________________________________________________
     */    
      public static void parseJSONResponse(String sNLPFileResponse){
          try{
              //Deserializing benefit data into wrapper class
              CensusMemberResponseWrapper oCensusResponse = (CensusMemberResponseWrapper) JSON.deserialize(sNLPFileResponse, CensusMemberResponseWrapper.class);
              ContentVersion oConversion = fetchContentVersionRec(oCensusResponse.document[0].Id);
                 if(oConversion != null && oConversion.Request_Tracking_ID__r != null){
                  //Calling utility class method to perist deserialized Census response into Census object
                  persistdata(oCensusResponse,  oConversion.Request_Tracking_ID__r.CaseID__c , oConversion.Request_Tracking_ID__r.CaseID__r.Opportunity__c);   
              }
                
          }
                   
          catch(Exception excn){
              //Logging exception in ExceptionLog__c object
              UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                      staticVariableClass.CENSUS_UTILITY,StaticVariableClass.PARSE_CENSUS_JSON_METHOD, null, LoggingLevel.ERROR); 
          }
      } 
      
     /*
  _________________________________________________________________________________________
  
  *@description:This method will be used to fetch ContentVersion Record
  _______________________________________________________________________________________
  
  *@param: sID - holds the DocumentID
  
  ____________________________________________________________________________________
  
  *@return: ContentVersion
  _________________________________________________________________________________________
     */  
     private  static ContentVersion fetchContentVersionRec(string sID){
          ContentVersion oCoVersion;
          if(sID !=null){
          string strimmedFileID=sID.trim();
          oCoVersion = [SELECT Id, Request_Tracking_ID__r.CaseID__c,Request_Tracking_ID__r.CaseID__r.Opportunity__c 
                       FROM ContentVersion 
                       WHERE  Id=: strimmedFileID];
          }
          return oCoVersion;
      }
      
      
       
      /*
  _________________________________________________________________________________________
  
  *@description: This method will be used to persist NLP Census file response into census object
  _______________________________________________________________________________________
  
  *@param: oCensusMemberResponse - holds the deserialized census file response 
  sCaseId               - holds case ID
  
  ____________________________________________________________________________________
  
  *@return: Void
  ____________________________________________________________________________________
     */
      public static void persistData(CensusMemberResponseWrapper oCensusMemberResponse, string sCaseId, string sOppId){
          try{
              //creating census record under census object
              Census__c oCensusRecord = new Census__c();
              oCensusRecord.CaseID__c = sCaseId;
              oCensusRecord.Document_link__c = (oCensusMemberResponse.document[0].id!=null?URL.getSalesforceBaseUrl().toExternalForm() + '/' +oCensusMemberResponse.document[0].id:'');
              oCensusRecord.Active_In_Active_Flag__c= true;
              oCensusRecord.OpportunityID__c = sOppId;
              String sCensusNLPResponse = System.JSON.serialize(oCensusMemberResponse);
              Integer iResponseFieldLength = Census__c.Census_JSON_Response__c.getDescribe().getLength();
              // NLP_Processing_Failure__c Field added as part of PRDCRM2-2536 to Include Error codes/Description on Census Page in case of Partial Success.   
              if(oCensusMemberResponse.document[0].errors != null && oCensusMemberResponse.document[0].errors.size() > 0){
                  for(CensusMemberResponseWrapper.ErrorInformation errorInfo : oCensusMemberResponse.document[0].errors){
                      oCensusRecord.NLP_Processing_Failure__c = oCensusRecord.NLP_Processing_Failure__c != null ? 
                      oCensusRecord.NLP_Processing_Failure__c + '<br>' + errorInfo.code + ': ' + errorInfo.description: 
                      errorInfo.code + ': ' + errorInfo.description;    
                  } 
              }
              //Updated code to handle large response for census files
              oCensusRecord.Census_JSON_Response__c = (sCensusNLPResponse.length() > iResponseFieldLength ? sCensusNLPResponse.subString(0, iResponseFieldLength) : sCensusNLPResponse);
              oCensusRecord.Census_JSON_Response1__c = (sCensusNLPResponse.length() > 2 * iResponseFieldLength ? sCensusNLPResponse.subString(iResponseFieldLength,2*iResponseFieldLength) : (sCensusNLPResponse.length() > iResponseFieldLength ? sCensusNLPResponse.subString(iResponseFieldLength) : ''));
              insert oCensusRecord;
              
              //checking if any data is coming from Nlp Response and creating census member record under census member object
              if(!oCensusMemberResponse.document.isEmpty() && oCensusMemberResponse.document.size() >0 && oCensusMemberResponse.document[0].data != null && !oCensusMemberResponse.document[0].data.person.isEmpty() && oCensusMemberResponse.document[0].data.person.size()>0){
                  List <Census_Members__c> listnewCensusMember = new List <Census_Members__c>();
                  for(CensusMemberResponseWrapper.CensusMemberPerson omemberperson: oCensusMemberResponse.document[0].data.person ){
                      Census_Members__c  censusmember = new Census_Members__c(Age__c=omemberperson.age, CensusID__c=oCensusRecord.Id, First_Name__c=omemberperson.firstName, Last_Name__c =omemberperson.lastName, 
                                                                              Plan_Name__c=omemberperson.planName, Gender__c = omemberperson.gender,Status__c = omemberperson.status,
                                                                              Zip__c = omemberperson.zipcode ,Plan_Product_Family__c= omemberperson.planProductFamily,
                                                                              Plan_Type__c= omemberperson.planType , Coverage_Level__c= omemberperson.coverageLevel, Type__c =omemberperson.type );
                      listnewCensusMember.add(censusmember);
                  }
                  if(listnewCensusMember.size()>0){
                      insert listnewCensusMember;
                  }
              }
             
          }
          catch(Exception excn){
              //Logging exception in ExceptionLog__c object
              UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                      staticVariableClass.CENSUS_UTILITY,StaticVariableClass.PERSIST_CENSUS_DATA_METHOD, null, LoggingLevel.ERROR);          
          }
      }
  }
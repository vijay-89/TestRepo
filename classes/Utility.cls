/*
********************************************************************************************
* Name          Utility 
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/24/2020
* UsedBy        The Utility is Used for retrive Values.
*********************************************************************************************
*/
public with sharing class Utility {
    
    /*
    *@This method is called from ContentVersionService to get recordtypeID based on sObject.
    * @Name: 			sObjectRecordTypeID
    * @Created Date:	02/24/2020
    * @Author : 		Deepak Kumar Reddy Regatte(Enforcers)
    * @Description 		Jira user story PRCDM2-2085   
    */
    public static Id sObjectRecordTypeID(String sObjectName, String sObjectRecordTypeName){        
      return Schema.getGlobalDescribe().get(sObjectName).getDescribe().getRecordTypeInfosByName().get(sObjectRecordTypeName).getRecordTypeId();  
    }

    /*
    * @This method is called from ContentVersionQueueable and IntegrationUtility and used to get custommetadatatype for any external integration.
    * @Name:getCustomMetaDataType
    * @Created Date: 03/04/2020
    * @Author : Deepak Kumar Reddy Regatte(Enforcers)
    * @Description Jira user story PRDCRM2-1904-NLP   
    */
    public static Integration_EndPoint_Setting_Details__mdt getCustomMetaDataType(){
        
      Organization org = [Select IsSandbox, InstanceName From Organization];
         Integration_EndPoint_Setting_Details__mdt endPointInfo;         
           if (org.IsSandbox == true) {               
              endPointInfo = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix,
                               Label, QualifiedApiName, Access_Token__c, ApiKey__c, Client_Secret__c,
                               Call_Timeout__c, Module__c, End_Point_URL__c, Application_Password__c,
                               Application_Username__c, ClientID__c, TokenRefreshTime__c,
                               IsSandbox__c,Host__c FROM Integration_EndPoint_Setting_Details__mdt where IsSandbox__c = true Limit 1]; 
           }else {
               endPointInfo = [SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix,
                               Label, QualifiedApiName, Access_Token__c, ApiKey__c, Client_Secret__c,
                               Call_Timeout__c, Module__c, End_Point_URL__c, Application_Password__c,
                               Application_Username__c, ClientID__c, TokenRefreshTime__c,
                               IsSandbox__c,Host__c FROM Integration_EndPoint_Setting_Details__mdt where IsSandbox__c = false Limit 1]; 
            }        
        return endPointInfo;
    }
}
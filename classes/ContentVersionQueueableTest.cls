/*
*******************************************************************************************
* Name          ContentVersionQueueableTest
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/19/2020
* UsedBy        The ContentVersionQueueableTest apex class is responsible for apex code coverage for class
                ContentVersionQueueable.
*********************************************************************************************
*/
@isTest
public with sharing class ContentVersionQueueableTest{
    @testSetup static void createCommonTestData() {
            Integer  iRecordCount = staticVariableClass.RECORD_COUNT; 
            String sName = staticVariableClass.NAME;
            String sStreet = staticVariableClass.STREET;
            String sCity = staticVariableClass.CITY; 
            String sState = staticVariableClass.ACCOUNTSTATE;
            String sZip = staticVariableClass.ZIP;
            String sCountry = staticVariableClass.COUNTRY;
            String sStateCode = staticVariableClass.STATECODE;
            List<Account> listAcc = TestDataFactory.createAccountSICList(iRecordCount  ,sName, sStreet, sCity, sState, sZip, sCountry, sStateCode);
            insert listAcc;  
            List<case> listCase = TestDataFactory.createCaseList(iRecordCount, listAcc[0]);
            insert listCase;
            List<EmailMessage> listEmailMessage = TestDataFactory.createEmailMessageList(iRecordCount, listCase[0]);
            insert   listEmailMessage;
    }
    
    /*
    * This Method is used for testclass to trigger contentversion
    * @name:createContentVersion
    * Created Date: 19th Feb 2020
    * @Author : Deepak Kumar Reddy Regatte(Enforcers)
    * @description Jira user story PRCDM2-1386   
    */ 
    public static testMethod  void createContentVersion(){
        Test.startTest();
        List<Case> listCase = [select id,Account.name, origin from case];
        system.assertEquals(listCase.size(), 5);
        system.assertEquals(listCase[0].origin, 'Email');
        system.assertNotEquals(listCase[0].Account.name, 'Apple123');
        List<ContentVersion> listContentVersion = TestDataFactory.createContentVersionList(5);
        insert listContentVersion;
        List<ContentVersion> lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];
        system.assertEquals(lContentVersion[0].Title, 'ABC');
        List<ContentDocumentLink> listContentDocumentLink = TestDataFactory.createContentDocumentLinkList(listCase[0].ID, lContentVersion);
        List<Database.SaveResult> listDatabaseResults = Database.Insert(listContentDocumentLink, false);
        set<id> setContentDocumentIds = new set<id>();
        for(ContentVersion cv: listContentVersion){
            cv.title='test'; 
            setContentDocumentIds.add(cv.ContentDocumentId);
        }
        Update listContentVersion;
        map<id,List<id>> mapCaseIdWithCDlink =new map<id,List<id>>();
        mapCaseIdWithCDlink.put(listCase[0].id,new List<id>(setContentDocumentIds));
        system.enqueueJob(new ContentVersionQueueable(mapCaseIdWithCDlink,setContentDocumentIds));
        Test.stopTest();
    }
    
}
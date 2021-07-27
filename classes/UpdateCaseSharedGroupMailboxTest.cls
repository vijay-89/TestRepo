/*
@Author : VenkataKoyyalamudi
@name : UpdateCaseSharedGroupMailboxTest
@CreateDate : 02/27/2020
@Last Modified :03/12/2020
@Description : This class is used to test  UpdateCaseSharedGroupMailbox, UpdateBrokerageAccntOnCase, UpdateStateFieldonCase functionality.
*/
@IsTest
public class UpdateCaseSharedGroupMailboxTest {
    @isTest
    public static void testupdateSharedEmailBoxonCaseToAddress(){
        //createTestData();
        Case caseObj=TestDataFactory.createCase(true);        
        TestDataFactory.createEmailMessage(true,caseObj.Id);  
        Test.startTest();
        UpdateCaseSharedGroupMailbox.updateSharedEmailBoxonCase(new List<String>{caseObj.Id});
        System.assertEquals('test2@anthem.com', [select Shared_Group_Mailbox__c from case where id=:caseObj.Id].Shared_Group_Mailbox__c);
        
        Test.stopTest();
        
        
    }
    @isTest
    public static void testupdateSharedEmailBoxonCaseCCAddress(){
        //createTestData();
        Case caseObj=TestDataFactory.createCase(true);        
        EmailMessage emObj= TestDataFactory.createEmailMessage(false,caseObj.Id);
        emObj.ToAddress=null;
        emObj.CcAddress='test2@anthem.com';
        insert emObj;
        Test.startTest();
        UpdateCaseSharedGroupMailbox.updateSharedEmailBoxonCase(new List<String>{caseObj.Id});
        System.assertEquals('test2@anthem.com', [select Shared_Group_Mailbox__c from case where id=:caseObj.Id].Shared_Group_Mailbox__c);
        
        Test.stopTest();
        
        
    }
    @isTest
    public static void testupdateSharedEmailBoxonCaseTOCCAddress(){
        //createTestData();
        Case caseObj=TestDataFactory.createCase(true);        
        EmailMessage emObj= TestDataFactory.createEmailMessage(false,caseObj.Id);
        emObj.ToAddress='test3@anthem.com';
        emObj.CcAddress='test2@anthem.com';
        insert emObj;
        Test.startTest();
        UpdateCaseSharedGroupMailbox.updateSharedEmailBoxonCase(new List<String>{caseObj.Id});   
        System.assertEquals(null, [select Shared_group_mailbox__c from case where id=:caseObj.Id].Shared_group_mailbox__c);
        
        Test.stopTest();
        
        
    }
    @isTest
    public static void testupdateSharedEmailBoxonCaseToAddressBulk(){
        List<Id> caseIdList= new List<Id>();
        List<Case> caseObjList=TestDataFactory.createCases(true,200);        
        List<EmailMessage> emList=TestDataFactory.createEmailMessages(true,caseObjList,200); 
        
        for(Case caseObj:caseObjList){
            caseIdList.add(caseObj.Id);  
        }
        Test.startTest();
        UpdateCaseSharedGroupMailbox.updateSharedEmailBoxonCase(caseIdList);  
        for(case caseObj:[select Shared_Group_Mailbox__c from case where id in:caseIdList limit 200]){
           System.assertEquals('test2@anthem.com', caseObj.Shared_Group_Mailbox__c);  
        }
        
       
        
        Test.stopTest();
        
        
    }
    @isTest
    public static void testUpdateBrokerageAccount(){
        contact conObj = TestDataFactory.createContactList(1)[0];
        Account accObj = TestDataFactory.createAccountSICList(1, 'Name', 'Street', 'City', 'State', '123123', 'country', '123')[0];
        insert accObj;
        conObj.AccountId=accObj.Id;
        insert conObj;
        Case caseObj=TestDataFactory.createCase(false); 
        caseObj.contactId=conObj.Id;
        insert caseObj;
        TestDataFactory.createEmailMessage(true,caseObj.Id);  
        Test.startTest();
        UpdateBrokerageAccntOnCase.updateBrokerageAccount(new List<String>{caseObj.Id});
        System.assertEquals(accObj.Id, [select State__c,AccountId from case where id=:caseObj.Id].AccountId);
        Test.stopTest();
    }
    @isTest
    public static void testupdateBrokerageAccountBulk(){
        contact conObj = TestDataFactory.createContactList(1)[0];
        Account accObj = TestDataFactory.createAccountSICList(1, 'Name', 'Street', 'City', 'State', '123123', 'country', '123')[0];
        insert accObj;
        conObj.AccountId=accObj.Id;
        insert conObj;
        List<Id> caseIdList= new List<Id>();
        List<Case> caseObjList=TestDataFactory.createCases(false,200);      
        for(Case caseObj:caseObjList){
            caseObj.ContactId = conObj.Id;
        }
        insert caseObjList;
        //List<EmailMessage> emList=TestDataFactory.createEmailMessages(true,caseObjList,10); 
        
        for(Case caseObj:caseObjList){
            caseIdList.add(caseObj.Id);  
        }
        Test.startTest();
        UpdateBrokerageAccntOnCase.updateBrokerageAccount(caseIdList);
        System.assertEquals(accObj.Id, [select AccountId from case limit 1].AccountId); 
        Test.stopTest();
        
        
    }
    @isTest
    public static void testupdateStateField(){
        Case caseObj=TestDataFactory.createCase(false);
        Group groupObj = TestDataFactory.createQueue(); 
        caseObj.ownerId = groupObj.id;
        insert caseObj;
        TestDataFactory.createEmailMessage(true,caseObj.Id);  
        Test.startTest();
        UpdateStateFieldonCase.updateStateField(new List<String>{caseObj.Id});
        System.assertEquals('California', [select State__c from case where id=:caseObj.Id].State__c);
        
        Test.stopTest();
        
        
    }
    @isTest
    public static void testupdateStateFieldonCaseBulk(){
        List<Id> caseIdList= new List<Id>();
        Group groupObj = TestDataFactory.createQueue(); 
        List<Case> caseObjList=TestDataFactory.createCases(false,200); 
        for(Case caseObj:caseObjList){
            caseObj.ownerId = groupObj.id;
        }
        insert caseObjList;
        List<EmailMessage> emList=TestDataFactory.createEmailMessages(true,caseObjList,200); 
        
        for(Case caseObj:caseObjList){
            caseIdList.add(caseObj.Id);  
        }
        Test.startTest();
        UpdateStateFieldonCase.updateStateField(caseIdList);
        for(Case caseObj:[select State__c from case where id in:caseIdList limit 200]){
          System.assertEquals('California', caseObj.State__c);  
        }
        
        Test.stopTest();
            
    }
}
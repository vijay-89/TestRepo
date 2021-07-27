@isTest
public class CaseTriggerTest{
    @isTest
    public static void testMethod1(){
        List<Case> caseListInsert = new List<Case>();
        List<Case> caseListInsert1 = new List<Case>();
        List<Mailbox_Origin_Emails__c> mailboxEmailList = new List<Mailbox_Origin_Emails__c>();
        for(Integer i=0; i<200; i++){
            caseListInsert.add(new Case(Status = 'New', Origin = 'Email', Mailbox_Origin__c = 'test' + i + '@gmail.com;test123' + i + '@gmail.com'));
            mailboxEmailList.add(new Mailbox_Origin_Emails__c(Name = 'test' + i + '@gmail.com', Mailbox_origin_Name__c = 'test' + i + '@gmail.com',Mailbox_Value__c='test' + i + '@gmail.com'));
        }
        caseListInsert.add(new Case(Status = 'New', Origin = 'Email', Mailbox_Origin__c = ''));

        case cs0 = new case();
        cs0.status = 'New';
        cs0.Origin = 'Email';
        cs0.Mailbox_Origin__c = 'test@gmail.com;test123@gmail.com';
        caseListInsert.add(cs0);
        
        Mailbox_Origin_Emails__c moe = new Mailbox_Origin_Emails__c();
        moe.Name = 'test@gmail.com';
        moe.Mailbox_origin_Name__c = 'test@gmail.com';
        mailboxEmailList.add(moe);
        
        Test.startTest();
        insert mailboxEmailList;
        insert caseListInsert;
        case cs = new case();
        cs.status = 'New';
        cs.Origin = 'Email';
        cs.Mailbox_Origin__c = 'test@gmail.com;test123@gmail.com';
        caseListInsert1.add(cs);
        
        case cs1 = new case();
        cs1.status = 'New';
        cs1.Origin = 'Email';
        cs1.Mailbox_Origin__c = '';
        caseListInsert1.add(cs1);
        
        insert caseListInsert1;
        system.debug('caseListInsert1'+caseListInsert1);
        Test.stopTest();
        List<Case> caseRetrieve = new List<Case>([SELECT Id, Mailbox__c FROM Case]);
        system.debug('caseRetrieve'+caseRetrieve[0].Mailbox__c);
        system.assertEquals(caseListInsert1.size(), 2);
        system.assertEquals(caseRetrieve.size(), 204);
        
    }
    
    @isTest
    public static void testMethodRemoveAccount(){
        Account acc = new Account();
        acc.Name = 'Anthem Associates';
        insert acc;
        
        case cs = new case();
        cs.status = 'New';
        cs.Origin = 'Email';
        cs.AccountId = acc.id;
        insert cs;
        system.debug('cs '+cs);
    }    
/*
* @This is a positive test method for PotentialDuplicateCheck
* @Name:testpositivePotentialDuplicateCheck
* @Created Date: 4th March 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    @isTest
    public static void testpositivePotentialDuplicateCheck(){
        
        List<Account> listAccounts = TestDataFactory.createAccountSICList(1,'Test Account','200 Main Street','Denver','CO','10065','USA','10065');
        listAccounts[0].recordtypeid=Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('LG Customer').getRecordTypeId();
        listAccounts[0].Mailing_Address_Same_as_Physical_Address__c = true;
        listAccounts[0].Physical_County__c = 'NEW YORK';
        listAccounts[0].Anthem_Entity__c = 'Local/Large Group';
        listAccounts[0].Region__c = 'West';
        
        insert listAccounts;
        
        List<Contact> listContacts = TestDataFactory.createContactList(1);
        
        insert listContacts;
        
        List<Case> listNewCases = new List<Case>();
        List<Case> listCases = TestDataFactory.createCaseList(50, listAccounts[0]);
        for(Case c : listCases){
        c.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        c.Prospect_Customer__c = listAccounts[0].id;
        c.ContactId = listContacts[0].id;
        c.Requested_Effective_Date__c = Date.today().adddays(-1);
        listNewCases.add(c);
         }
        insert listNewCases;
        
        Test.startTest();
        system.assertEquals(listNewCases.size(), 50);
        CaseTriggerHelper cth = new CaseTriggerHelper();
        cth.potentialDuplicateCheck(listNewCases);
        Case c = [select Potential_Duplicate__c,Duplicate_Cases__c from Case][0];
        system.assertEquals(c.Potential_Duplicate__c, false);
        system.assertEquals(c.Duplicate_Cases__c, null);
        Test.stopTest();
    }
    
/*
* @This is a negative test method for PotentialDuplicateCheck
* @Name:testpositivePotentialDuplicateCheck
* @Created Date: 4th March 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    
    @isTest
    public static void testnegativePotentialDuplicateCheck(){
        
        List<Account> listAccounts = TestDataFactory.createAccountSICList(1,'Test Account','200 Main Street','Denver','CO','10065','USA','10065');
        listAccounts[0].recordtypeid=Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('LG Customer').getRecordTypeId();
        listAccounts[0].Mailing_Address_Same_as_Physical_Address__c = true;
        listAccounts[0].Physical_County__c = 'NEW YORK';
        listAccounts[0].Anthem_Entity__c = 'Local/Large Group';
        listAccounts[0].Region__c = 'West';
        
        insert listAccounts;
        
        List<Contact> listContacts = TestDataFactory.createContactList(1);
        
        insert listContacts;
        
        List<Case> listNewCases = new List<Case>();
        List<Case> listCases = TestDataFactory.createCaseList(2, listAccounts[0]);
        for(Case c : listCases){
        c.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        c.Prospect_Customer__c = listAccounts[0].id;
        c.ContactId = listContacts[0].id;
        c.Requested_Effective_Date__c = null ;
        listNewCases.add(c);
         }
        insert listNewCases;
        
        Test.startTest();
        system.assertEquals(listNewCases.size(), 2);
        CaseTriggerHelper cth = new CaseTriggerHelper();
        cth.potentialDuplicateCheck(listNewCases);
        Case c = [select Potential_Duplicate__c,Duplicate_Cases__c from Case][0];
        system.assertEquals(c.Potential_Duplicate__c, false);
        system.assertEquals(c.Duplicate_Cases__c, null);
        Test.stopTest();
    }
/*
* @This is a positive test method for UncheckPotentialDuplicates
* @Name:testpositivePotentialDuplicateCheck
* @Created Date: 4th March 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    
    @isTest
    public static void testpositiveUncheckPotentialDuplicates(){
        
        List<Account> listAccounts = TestDataFactory.createAccountSICList(1,'Test Account','200 Main Street','Denver','CO','10065','USA','10065');
        listAccounts[0].recordtypeid=Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('LG Customer').getRecordTypeId();
        listAccounts[0].Mailing_Address_Same_as_Physical_Address__c = true;
        listAccounts[0].Physical_County__c = 'NEW YORK';
        listAccounts[0].Anthem_Entity__c = 'Local/Large Group';
        listAccounts[0].Region__c = 'West';
        
        insert listAccounts;
        
        List<Contact> listContacts = TestDataFactory.createContactList(1);
        
        insert listContacts;
        
        List<Case> listNewCases = new List<Case>();
        List<Case> listCases = TestDataFactory.createCaseList(10 , listAccounts[0]);
        for(Case c : listCases){
        c.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        c.Prospect_Customer__c = listAccounts[0].id;
        c.ContactId = listContacts[0].id;
        c.Potential_Duplicate__c = true;
        c.Duplicate_Cases__c = '00654,145195';
        c.Requested_Effective_Date__c = Date.today().adddays(-1);
        listNewCases.add(c);
         }
        
        case cs1 = new case();
        cs1.status = 'Merged';
        cs1.Origin = 'Email';
        cs1.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        cs1.Prospect_Customer__c = listAccounts[0].id;
        cs1.ContactId = listContacts[0].id;
        cs1.Potential_Duplicate__c = true;
        cs1.Duplicate_Cases__c = '00654,145195';
        cs1.Requested_Effective_Date__c = Date.today().adddays(-1);
        listNewCases.add(cs1);
        
        insert listNewCases;
        Test.startTest();
        system.assertEquals(listNewCases.size(), 11);
        CaseTriggerHelper cth = new CaseTriggerHelper();
        cth.uncheckPotentialDuplicates(listNewCases);
        Case c = [select Potential_Duplicate__c,Duplicate_Cases__c from Case LIMIT 1];
        system.assertEquals(c.Potential_Duplicate__c, true);
        system.assertNotEquals(c.Duplicate_Cases__c, null );
        Test.stopTest();
    }
/*
* @This is a negative test method for UncheckPotentialDuplicates
* @Name:testpositivePotentialDuplicateCheck
* @Created Date: 4th March 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    
    @isTest
    public static void testnegativeUncheckPotentialDuplicates(){
        
        List<Account> listAccounts = TestDataFactory.createAccountSICList(1,'Test Account','200 Main Street','Denver','CO','10065','USA','10065');
        listAccounts[0].recordtypeid=Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('LG Customer').getRecordTypeId();
        listAccounts[0].Mailing_Address_Same_as_Physical_Address__c = true;
        listAccounts[0].Physical_County__c = 'NEW YORK';
        listAccounts[0].Anthem_Entity__c = 'Local/Large Group';
        listAccounts[0].Region__c = 'West';
        
        insert listAccounts;
        
        List<Contact> listContacts = TestDataFactory.createContactList(1);
        
        insert listContacts;
        
        List<Case> listNewCases = new List<Case>();
        List<Case> listCases = TestDataFactory.createCaseList(2 , listAccounts[0]);
        for(Case c : listCases){
        c.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        c.Prospect_Customer__c = listAccounts[0].id;
        c.ContactId = listContacts[0].id;
        c.Requested_Effective_Date__c = null ;
        listNewCases.add(c);
         }
        
        case cs1 = new case();
        cs1.status = 'In Progress';
        cs1.Origin = 'Email';
        cs1.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        cs1.Prospect_Customer__c = listAccounts[0].id;
        cs1.ContactId = listContacts[0].id;
        cs1.Requested_Effective_Date__c = Date.today().adddays(-1);
        listNewCases.add(cs1);
        
        insert listNewCases;
        Test.startTest();
        system.assertEquals(listNewCases.size(), 3);
        CaseTriggerHelper cth = new CaseTriggerHelper();
        cth.uncheckPotentialDuplicates(listNewCases);
        Case c = [select Potential_Duplicate__c,Duplicate_Cases__c from Case][0];
        system.assertEquals(c.Potential_Duplicate__c, false);
        system.assertEquals(c.Duplicate_Cases__c, null);
        Test.stopTest();
    }
    
    /*
    * @This is a negative test method for testTaggingofBenefitCensusPositive
    * @Name:testTaggingofBenefitCensusPositive
    * @Created Date: 18th March 2020
    * @Author : Rahul Gupta (Harmony)
    * @Description Jira user story PRCDM2-2018   
    */
    
    @isTest
    public static void testTaggingofBenefitCensusPositive(){
        
        List<Account> listAccounts = TestDataFactory.createAccountSICList(1,'Test Account','200 Main Street','Denver','CO','10065','USA','10065');
        listAccounts[0].recordtypeid=Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('LG Customer').getRecordTypeId();
        listAccounts[0].Mailing_Address_Same_as_Physical_Address__c = true;
        listAccounts[0].Physical_County__c = 'NEW YORK';
        listAccounts[0].Anthem_Entity__c = 'Local/Large Group';
        listAccounts[0].Region__c = 'West';
        
        insert listAccounts;
        
        List<Contact> lstcontacts = TestDataFactory.createContactList(1);
         
        insert lstcontacts;
        
        List<Opportunity> opptyList = new List<Opportunity>(TestDataFactory.createOpportunityList(1, staticVariableClass.OpportunityName,listAccounts[0]));
        insert opptyList;
        
        List<Case> lstnewCases = new List<Case>();
        List<Case> lstcases = TestDataFactory.createCaseList(2 , listAccounts[0]);
        for(Case oCas : lstcases){
        oCas.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        oCas.Prospect_Customer__c = listAccounts[0].id;
        oCas.ContactId = lstcontacts[0].id;
        oCas.Requested_Effective_Date__c = null ;
        lstnewCases.add(oCas);
         }
         insert lstnewCases;
        
        Map<Id,Case> mapIdCase = new Map<Id,Case>();
        For(Case objcase: lstnewCases){
            mapIdCase.put(objcase.Id,objcase);
        }
        Case oCase = [Select Id,recordTypeId ,Opportunity__c FROM Case LIMIT 1];
       
        List<Benefit__c> lstBenefits = TestDataFactory.createBenefitList(10,oCase);
        insert lstBenefits;
       
        List<Census__c> lstnewCensus = new List<Census__c>();
        List<Census__c> lstCensus = TestDataFactory.createCensus(10);
        for(Census__c oCensus : lstCensus){
            oCensus.CaseID__c = oCase.Id;
            lstnewCensus.add(oCensus);
        }
        insert lstnewCensus;
        
        
         Test.startTest();
        List<Case> listCasesUpdates = new List<Case>();
        List<Case> listCases = [Select Id,Opportunity__c,recordTypeId  FROM CASE limit 1];
        
        For (Case objcase: listCases){
            objcase.Opportunity__c= opptyList[0].Id;
            listCasesUpdates .add(objcase);
        }
        update listCasesUpdates;
        CaseTriggerHelper cth = new CaseTriggerHelper();
        cth.opptyStampingBenefitCensus(listCasesUpdates,mapIdCase);
        Test.stopTest();
        
        Case objCase = [Select Id,Opportunity__c FROM Case LIMIT 1];
        Census__c oCen = [Select Id,OpportunityID__c FROM Census__c LIMIT 1];
        Benefit__c oBen = [Select Id, Opportunity__c FROM Benefit__c  LIMIT 1];
        System.assertEquals(oCen.OpportunityId__c, objCase.Opportunity__c,staticVariableClass.assertEquals);
        System.assertEquals(oBen.Opportunity__c , objCase.Opportunity__c,staticVariableClass.assertEquals);
    
    }
     /*
    * @This is a negative test method for testTaggingofBenefitCensusNegative
    * @Name: testTaggingofBenefitCensusNegative
    * @Created Date: 18th March 2020
    * @Author : Rahul Gupta (Harmony)
    * @Description Jira user story PRCDM2-2018   
    */
    @isTest
    public static void testTaggingofBenefitCensusNegative(){
        
        List<Account> lstaccounts = TestDataFactory.createAccountSICList(1,'Test Account','200 Main Street','Denver','CO','10065','USA','10065');
        lstaccounts[0].recordtypeid=Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('LG Customer').getRecordTypeId();
        lstaccounts[0].Mailing_Address_Same_as_Physical_Address__c = true;
        lstaccounts[0].Physical_County__c = 'NEW YORK';
        lstaccounts[0].Anthem_Entity__c = 'Local/Large Group';
        lstaccounts[0].Region__c = 'West';
        
        insert lstaccounts;
        
        List<Contact> lstcontacts = TestDataFactory.createContactList(1);
         
        insert lstcontacts;
        
        List<Opportunity> opptyList = new List<Opportunity>(TestDataFactory.createOpportunityList(1, staticVariableClass.OpportunityName,lstaccounts[0]));
        insert opptyList;
        
        List<Case> lstnewCases = new List<Case>();
        List<Case> lstcases = TestDataFactory.createCaseList(2 , lstaccounts[0]);
        for(Case oCas : lstcases){
        oCas.recordtypeid = Schema.getGlobalDescribe().get('Case').getDescribe().getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
        oCas.Prospect_Customer__c = lstaccounts[0].id;
        oCas.ContactId = lstcontacts[0].id;
        oCas.Requested_Effective_Date__c = null ;
        lstnewCases.add(oCas);
         }
         insert lstnewCases;
        
        Map<Id,Case> mapIdCase = new Map<Id,Case>();
        For(Case objcase: lstnewCases){
            mapIdCase.put(objcase.Id,objcase);
        }
        Opportunity objOpp = [Select Id FROM Opportunity LIMIT 1 ];
        Case oCase = [Select Id,recordTypeId ,Opportunity__c FROM Case LIMIT 1];
        List<Benefit__c> lstNewBenefits = new List<Benefit__c>();
        List<Benefit__c> lstBenefits = TestDataFactory.createBenefitList(10,oCase);
        for (Benefit__c oBen : lstBenefits ){
            oBen.Opportunity__c  =  objOpp.Id;
            lstNewBenefits.add(oBen);
        }
        insert lstNewBenefits ;
       
        List<Census__c> lstnewCensus = new List<Census__c>();
        List<Census__c> lstCensus = TestDataFactory.createCensus(10);
        for(Census__c oCensus : lstCensus){
            oCensus.CaseID__c = oCase.Id;
            oCensus.OpportunityId__c = objOpp.Id;
            lstnewCensus.add(oCensus);
        }
        insert lstnewCensus;
        
        
         Test.startTest();
        
        List<Case> listCases = [Select Id,Opportunity__c,recordTypeId  FROM CASE limit 1];
        
        CaseTriggerHelper cth = new CaseTriggerHelper();
        cth.opptyStampingBenefitCensus(listCases,mapIdCase);
        Test.stopTest();
        
        Case objCase = [Select Id,Opportunity__c FROM Case LIMIT 1];
        Census__c oCen = [Select Id,OpportunityID__c FROM Census__c LIMIT 1];
        Benefit__c oBen = [Select Id, Opportunity__c FROM Benefit__c  LIMIT 1];
        
         System.assert(oBen.Opportunity__c != objCase.Opportunity__c,staticVariableClass.assertNotEquals );
    }
}
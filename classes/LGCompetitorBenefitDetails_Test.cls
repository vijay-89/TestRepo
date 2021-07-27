/*
*******************************************************************************************
* Name:          LGCompetitorBenefitDetails_Test
* Author:        Deloitte offshore
* ModifiedBy:    Deloitte offshore
* CreatedDate:   02/24/2020
* Used By:       
*******************************************************************************************
* Description:Test class for LGCompetitorBenefitDetails

*******************************************************************************************
* Changes By: Deloitte offshore
* Date:02/26/2020
*******************************************************************************************
*/

@isTest 
public with sharing class LGCompetitorBenefitDetails_Test {
    @testSetup
    static void createData(){
        test.startTest();
        
        Vision_Benefit_Creation__c setting = new Vision_Benefit_Creation__c();
        //  setting.Allow_Vision_Benefit_Creation__c = false;
        insert setting;
        
        List<Account> listAccount = TestDataFactory.createAccountSICList(1,'AccountTest',  'Streetdata',  'Citydata',  'Statedata',  'ZIPdata',  'countrydata',  'stateCodedata');
        insert listAccount;
        
        List<Opportunity> strOppId = TestDataFactory.createOpportunityList(1, '2020 New Business Local-AccountTest 0', listAccount[0]);
        insert strOppId;
        
        List<Case>  listCase= TestDataFactory.createCaseList(1, listAccount[0]);
        string srecTypeID = Schema.SobjectType.Case.getRecordTypeInfosByDeveloperName().get('RFP_Intake_Case').getRecordTypeId();
        listCase[0].RecordTypeid= srecTypeID;
        insert listCase;
        
        List<Benefit__c> listBenefit = TestDataFactory.createBenefitList(1,listCase[0]);
        listBenefit[0].Opportunity__c=strOppId[0].id;
        insert listBenefit;
        
        test.stopTest();
        
    }
    @isTest static void testBenefitCheck(){
        
        List<Opportunity> listOpp=[select id,Accountid from Opportunity where Name='2020 New Business Local-AccountTest 0' limit 1];
        
        BenefitWrapper benwrap=LGCompetitorBenefitDetails.getBenefitRecords(listOpp[0].id,'Medical','Benefit__c');
        
        System.assertEquals(listOpp.size(),benwrap.lstWrap.size());
        
        Account acc=new Account();
        acc.id=listOpp[0].Accountid;
        
        //inserting the opportunity with account
        List<Opportunity> strOppId1= TestDataFactory.createOpportunityList(1, 'TestOpportunity', acc);
        insert strOppId1;
        
        BenefitWrapper benwrap1=LGCompetitorBenefitDetails.getBenefitRecords(strOppId1[0].id,'Medical','Benefit__c');
        //check whether the opportunity has benefits are not
        System.assertEquals(0,benwrap1.lstWrap.size());
    }
    
    @isTest static void testBenefitCheckException(){        
        BenefitWrapper benwrap1=LGCompetitorBenefitDetails.getBenefitRecords('','','');
        System.assertEquals(0,benwrap1.lstWrap.size());
    }
}
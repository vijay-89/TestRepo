/*
     * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
     * Name              LGHWProgressIndicatorControllerTest 
     * Author            Deloitte offshore (Gladiators)
     * ModifiedBy        Deloitte offshore (Gladiators)
     * Version           v1.0
     * CreatedDate       26th November 2019
     * User Story        H&W Job Indicator
     * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
     * @Description      
     * This is a test class for LGHWProgressIndicatorController and it tests negative and positive scenarios.
     * 
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------------
     * FUNCTIONAL TEST LOGIC
     * ----------------------------------------------------------------------------------------------------------------------------------------------------------------
     * 1 - lgHwProgressIndicatorDataSetup() 
     *          > TestSetup Method to create the required Test Data
     * 
     * 2 - getApexJobsStatusNegativeTest ()
     *          > Checks if the code handles negative scenario.
     * 
     * 3 - getApexJobsStatusTest()
     *          > Checks the Status is getting populated or Not.
     * 
     * 4 - getExceptionLogDetailsTest()
     *          > Checks if the exceptions are handling properly.
     * 
     * Additional information
     * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
     * Changes
     * vX.X(Version)            Name
     * Date                     Explanation
     * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
    */
@isTest
public class LGHWProgressIndicatorControllerTest {
    
    @testSetup 
    static void lgHwProgressIndicatorDataSetup() {
        List<Account> listAccount = new List<Account>(TestDataFactory.createAccountSICList(1, staticVariableClass.AccountName, 
                                                            staticVariableClass.testAccBillingStreet, staticVariableClass.testAccBillingCity, 
                                                            staticVariableClass.testAccBillingState, staticVariableClass.testAccBillingPostalCode, 
                                                            staticVariableClass.testAccBillingCountry, staticVariableClass.AK));
        listAccount[0].Situs_State__c =  staticVariableClass.California;
        listAccount[0].RecordTypeId = Schema.getGlobalDescribe().get(staticVariableClass.Account).getDescribe().getRecordTypeInfosByName().get(staticVariableClass.LGProspect).getRecordTypeId();
        listAccount[0].Anthem_Entity__c = staticVariableClass.Entity;
        listAccount[0].Mailing_Address_Same_as_Physical_Address__c = true;
        listAccount[0].Physical_County__c =staticVariableClass.GroupNum;
        listAccount[0].Group_Size__c = staticVariableClass.GROUP_SIZE_0_50;
        insert listAccount; 
        
        List<Opportunity> listOppty = new List<Opportunity>(TestDataFactory.createOpportunityList(1, staticVariableClass.OpportunityName,listAccount[0]));
        insert listOppty;
        
        Group__c oGrp=TestDataFactory.createGroup(listAccount[0].id,false);
        oGrp.ClaimSystem__c = '';
        insert oGrp;
               
        List<Quote> listQuote=new List<Quote>(TestDataFactory.Quote(staticVariableClass.DNCStrPath,1,listOppty[0]));
        listQuote[0].GroupNumber__c = oGrp.id;
        insert listQuote; 
        
     }
    
    @isTest 
    static void getApexJobsStatusNegativeTest (){ 
        Quote oQte = [select id from Quote Limit 1];
        Test.startTest();
          AsyncApexJob oJobOutput =  LGHWProgressIndicatorController.getApexJobsStatus(oQte.Id);
        Test.stopTest();
         System.assertEquals(null, oJobOutput,staticVariableClass.assertEquals);
    }
    
      @isTest 
    static void getApexJobsStatusTest (){ 
        Quote oQte = [select id from Quote Limit 1];
        Id jobId = System.enqueueJob(new LGHWAssociatePackageToPlansQueueable(null));
        Test.startTest();
            oQte.ApexAsyncJobId__c = jobId;
            update oQte;
            AsyncApexJob oJobOutput =  LGHWProgressIndicatorController.getApexJobsStatus(oQte.Id);
        Test.stopTest();
        System.assertEquals(jobId, oJobOutput.Id,staticVariableClass.assertEquals);
    }    
    
    @isTest 
    static void getExceptionLogDetailsTest(){ 
        Quote oQte = [select id, ApexAsyncJobId__c from Quote Limit 1];
        Id jobId = System.enqueueJob(new LGHWAssociatePackageToPlansQueueable(null));
        Test.startTest();  
          Integer expectionLength = LGHWProgressIndicatorController.getExceptionLogDetails(jobId);
        Test.stopTest();        
         System.assertEquals(0, expectionLength,staticVariableClass.assertEquals);
    }
 }
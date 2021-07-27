@isTest
private class DupCaseViewerControllerTest {
    @testSetup
    static void setup()
    {
        List<Case> cases = TestDataFactory.createcases(true, 2);
        for(Case item :cases) {
            item.Potential_Duplicate__c = true;
        }
        update cases;
        
        List<Account> accounts = TestDataFactory.createAccountSICList(1, 'Test Account', '1 Main St.', 'Big City', 'GA', '30000', 'US', '11');
        insert accounts;
    }

    @isTest
    static void positiveTest()
    {
        List<Case> cases = [SELECT Id, CaseNumber, Duplicate_Cases__c FROM Case WHERE Potential_Duplicate__c = TRUE];
        cases[0].Duplicate_Cases__c = cases[1].CaseNumber;
        update cases;
        
        Test.startTest();
        // NOTE: no bulk testing as the LWC and Apex controller is designed to handle one case record per transaction
        Case caseRecord = DupCaseViewerController.getCaseRecord(cases[0].Id);
        List<Case> dupRecords = DupCaseViewerController.getDupRecords(cases[0].Id);
        Test.stopTest();
        
        System.assertNotEquals(null, caseRecord);
        System.assertNotEquals(null, dupRecords);
    }

    @isTest
    static void negativeTest()
    {
        List<Account> accounts = [SELECT Id FROM Account];

        Test.startTest();
        Exception exp1 = null;
        try {
            // passing an Account Id instead of Case Id to cause an error condition
            // as the controller is designed to accept only single Case Id
            Case item = DupCaseViewerController.getCaseRecord(accounts[0].Id);
        } catch (Exception e) {
            exp1 = e;
        }

        Exception exp2 = null;
        try {
            // passing an Account Id instead of Case Id to cause an error condition
            // as the controller is designed to accept only single Case Id
            List<Case> dupItems = DupCaseViewerController.getDupRecords(accounts[0].Id);
        } catch (Exception e) {
            exp2 = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, exp1);
        System.assertEquals(true, exp1.getMessage().contains('Script-thrown exception'));
        System.assertNotEquals(null, exp2);
        System.assertEquals(true, exp2.getMessage().contains('Script-thrown exception'));
    }
}
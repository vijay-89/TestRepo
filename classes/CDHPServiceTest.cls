//Ranjit
@isTest
public class CDHPServiceTest {
    @testSetup
    static void setupTestData() {
        
        // Create the custom settings data
        /*CS001_RecordTypeBusinessTrack__c csData = new CS001_RecordTypeBusinessTrack__c();
csData.Name = 'Account_Large Group/National Account';
csData.BusinessTrackName__c = 'LGANA';
insert csData;*/
        //fetch the record type
        List<RecordType> lstRcdType = [Select Id From RecordType Where Name =: 'Standard Account' Limit 1];
        
        Account acc = new Account(Name = 'Test Account', RecordTypeId = lstRcdType[0].Id);
        Insert acc;      
    }
   /* 
    static testMethod void testMethod1(){
        Test.startTest();
        //String s = CDHPService.doPost('{"ORGName":"COM2"}');
        //String s = CDHPService.doPost('"CDHPFields":{"CDHP_Questionnaire_Name":"CDHP-001924","StatusDetails":["CDHPParentId":"006S000000CuA7CIAV", "QuoteId":"0Q0S0000000IbuwKAC", "Status:Alegeus Completed", "StatusMessage":"Alegeus Completed"]}');
        String s = CDHPService.doPost('[{"StatusDetails":{"StatusMessage":"CDHPTest2","Status":"CDHPTest1","QuoteId":"0Q0S0000000IbuwKAC","CDHPParentId":"006S000000CuA7CIAV"},"oppDetails":null,"grpDetails":null,"docSignDetails":null,"CDHP_Questionnaire_Name":"CDHPTest"}]');
        Test.stopTest();        
    }*/
    //*************** testMethod1 *********************//
    static testMethod void testMethod1() {
        List<RecordType> lstRcdType = [Select Id From RecordType Where Name =: 'Prospect' Limit 1];
        Account acc = new Account(Name = 'Test Account', RecordTypeId = lstRcdType[0].Id);
        Insert acc;
        Opportunity opp = new Opportunity(Name = 'Test Opp', AccountId = acc.id, StageName = 'Prospecting', CloseDate = system.today().toStartOfMonth());
        insert opp;
        Quote q=new quote(Name='Test', OpportunityId = opp.Id);
        insert q;
        
        opp.Name = 'Test Opp2';
        update opp;
        
        CDHPService.CDHPFields  cdhpFields = new CDHPService.CDHPFields();
        CDHPService.StatusDetails cdhpStatusDetails = new CDHPService.StatusDetails ();
        CDHPService.OpportunityDetails cdhpOpportunityDetails = new CDHPService.OpportunityDetails();
        CDHPService.GroupDetails cdhpGroupDetails = new CDHPService.GroupDetails();
        CDHPService.DocuSignDetails cdhpDocuSignDetails = new CDHPService.DocuSignDetails();
        //cdhpStatusDetails.QuoteId = '0Q0S0000000IbuwKAC';
        cdhpStatusDetails.QuoteId = q.id;
        cdhpStatusDetails.CDHPParentId = '006S000000CuA7CIAV';
        cdhpStatusDetails.Status = 'CDHPTest1';
        cdhpStatusDetails.StatusMessage = 'CDHPTest2';
        
        cdhpOpportunityDetails.GroupNumber = 'grp1';
        cdhpOpportunityDetails.OpportunityOwner = 'Avinash';
        cdhpOpportunityDetails.OptyEffectiveDate = System.today();
        cdhpOpportunityDetails.OptyName = 'TestOpp';
        cdhpOpportunityDetails.OptyRecordType = 'test';
        //cdhpOpportunityDetails.SFORGOpportunityId = '006S000000CuA7CIAV';
        cdhpOpportunityDetails.SFORGOpportunityId = opp.id;
        cdhpOpportunityDetails.StageName = 'Prospecting';
        
        cdhpGroupDetails.EmployerIdCaseNumber = '12345';
        cdhpGroupDetails.EmployerName = 'Avinash';
        
        cdhpDocuSignDetails.CDHP_Questionnaire_Name_Status = 'Test';
        cdhpDocuSignDetails.DocuSignCreatedBy = 'Avi';
        cdhpDocuSignDetails.dsfs_Case = 'TestCase';
        cdhpDocuSignDetails.dsfs_Company = 'TestCompany';
        cdhpDocuSignDetails.dsfs_Envelope_Name = 'Avinash';
        cdhpDocuSignDetails.dsfs_Envelope_Status = 'Test';
        cdhpDocuSignDetails.dsfs_Opportunity = 'TestOpp';
        cdhpDocuSignDetails.dsfs_Sent_Age = 12;
        cdhpDocuSignDetails.dsfs_Sent_Date_Time = System.today();
        cdhpDocuSignDetails.OpportunityName = 'TestOpportunity';
        
        cdhpFields.StatusDetails = cdhpStatusDetails;
        cdhpFields.docSignDetails = cdhpDocuSignDetails;
        cdhpFields.oppDetails = cdhpOpportunityDetails;
        cdhpFields.grpDetails =cdhpGroupDetails;
        cdhpFields.CDHP_Questionnaire_Name = 'CDHPTest' ;
        List<CDHPService.CDHPFields> wr = new List<CDHPService.CDHPFields>();
        wr.add(cdhpFields);
        Test.startTest();
        //String s = CDHPService.doPost('{"Status":"TestStatus","StatusMessage":"TestStatusMessage","CDHPParentId":"TestCdhpParentId"}');
        //String s = CDHPService.doPost('[{"StatusDetails":{"StatusMessage":"CDHPTest2","Status":"CDHPTest1","QuoteId":"0Q0S0000000IbuwKAC","CDHPParentId":"006S000000CuA7CIAV"},"oppDetails":null,"grpDetails":null,"docSignDetails":null,"CDHP_Questionnaire_Name":"CDHPTest"}]');
        String s1 = System.JSON.serialize(wr, true);
        String s = CDHPService.doPost(s1);
        
        Test.stopTest();        
    }
}
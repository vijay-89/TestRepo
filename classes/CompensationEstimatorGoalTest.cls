/*
@Author : Suman Manjunatha(Avengers)
@CreateDate : 23rd March 2020
@description : Test Class for Compensation Estimator Goal Object 
created as part of PRDCRM-53813
*/
@isTest
public class CompensationEstimatorGoalTest {
    @IsTest 
    static void testinsertOrUpdateCEG() {
        
        Id qliId;
        User testUser;
        Integer recordCount=1;
        
        //Insert User
        List<User> userList = new List<User>();
        String userprofile = 'Local Implementations';
        String federationid = '';
        userList = TestDataFactory.createUserData(recordCount,userprofile,federationid);
        Database.insert(userList);
        
        //Insert account
        List<Account> accounts = new List<Account>();
        String accName='newaccount';
        String street='CA street';
        String city='CA';
        String state='CA State';
        String zip='12345';
        String country='US';
        String stateCode='CAA';
        accounts =TestDataFactory.createAccountSICList(recordCount,accName,street,city,state,zip,country,stateCode);
        Database.insert(accounts); 
        
        //Insert Opportunity 
        List<Opportunity> opportunities = new List<Opportunity>();
        String optyName = 'test Opty';
        String stageName='Prospecting';
        Date closeDate=System.Today();
        opportunities=TestDataFactory.createOpportunityList(recordCount,optyName,accounts[0]);
        opportunities[0].Is_Pharmacy_Carved_out__c = 'Yes';
        //opportunities[0].Account_Manager__c = UserInfo.getUserId();
        opportunities[0].Account_Executive__c = userList[0].Id;
        opportunities[0].RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('New Business Local').getRecordTypeId();
        
        Database.insert(opportunities);
        System.debug('Opp Acc Manager'+opportunities[0].Account_Executive__c);
        
        //Opportunity opp = [Select Id,Account_Manager__c,Account_Executive__c,RecordTypeId from Opportunity where id=:opportunities[0].Id Limit 1];
        
        
        List<OpportunityTeamMember> otmList = new List<OpportunityTeamMember>();
        OpportunityTeamMember otm = new OpportunityTeamMember();
        otm.TeamMemberRole = 'Account Executive';
        otm.OpportunityId = opportunities[0].Id;
        otm.OpportunityAccessLevel = 'Read';
        otm.UserId = userList[0].Id;
        otmList.add(otm);
        
        /*OpportunityTeamMember otm2= new OpportunityTeamMember();
        otm2.TeamMemberRole= 'Account Manager';
        otm2.OpportunityId = opp.id;
        otm2.OpportunityAccessLevel = 'Read';
        otm2.UserId = UserInfo.getUserId();
        otmList.add(otm2);*/
        
        Database.insert(otmList);
        
        //Insert Product
        String prodName='Laptop X200';
        List<Product2> prodlist= new List<Product2>();
        prodlist=TestDataFactory.createProduct(prodName,2);
        Database.insert(prodlist);
        prodlist[0].LOB__c='Medical';
        prodlist[0].Contract_Code__c='5ABB';
        prodList[1].LOB__c = 'Life';
        Database.update(prodlist);
        
        //Insert PricebookEntry
        List<PricebookEntry> pricebookentrylist= new List<PricebookEntry>();
        pricebookentrylist=TestDataFactory.PricebookEntry(recordCount,prodlist[0]);
        Database.insert(pricebookentrylist);
        
        
        //Insert Group
        Group__c groupRecord = new Group__c();
        boolean doinsert = false;
        groupRecord = TestDataFactory.createGroup(accounts[0].id,doinsert);
        groupRecord.ClaimSystem__c ='';
        groupRecord.IsActive__c = true;
        Database.insert(groupRecord);
        //Insert Quote
        List<Quote> quotelist= new List<Quote>();
        String quoteName='Test Quote';
        quotelist=TestDataFactory.Quote(quoteName,recordCount,opportunities[0]);
        quotelist[0].Imp_Completed_Date__c = System.Today();
        quotelist[0].OpportunityId = opportunities[0].Id;
        Database.insert(quotelist);
        
        //Quote q = [Select Id,Imp_Completed_Date__c,OpportunityId from Quote where Id=:quotelist[0].id];
        
        //Insert Implementation case
        List<Order> orderlist = new List<Order>();
        orderlist = TestDataFactory.createOrder(recordCount,groupRecord.id,accounts[0].id,userlist[0].id,quoteList[0].id);
        orderlist[0].Opportunity=opportunities[0];
        Database.insert(orderlist);
        
        //Insert QuoteLineItem
        List<QuoteLineItem> quotelineitemlist= new List<QuoteLineItem>();
        for(Integer i=0;i<20;i++){
            QuoteLineItem qli = new QuoteLineItem();
            qli.QuoteId = quoteList[0].Id;
            qli.Quantity = 1;
            qli.product2id = prodlist[0].id;
            qli.Funding__c = 'FI';
            qli.Financing__c = 'Fully Insured';
            qli.Involvement_Type__c='Slice';
            qli.Line_of_Business__c = 'Medical';
            qli.Members__c = 200;
            qli.Estimated_Annualized_Premium__c = 50000;
            qli.PricebookEntryId = pricebookentrylist[0].Id;
            qli.UnitPrice = (i+1)*10;
            qli.Subscribers__c = i+10;
            qli.Network__c = 'Dental Net';
            qli.ProductStage__c = 'Sold';
            quotelineitemlist.add(qli);
        }
        for(Integer i=20;i<40;i++){
            QuoteLineItem qli = new QuoteLineItem();
            qli.QuoteId = quoteList[0].Id;
            qli.Quantity = 1;
            qli.product2id = prodlist[1].id;
            qli.Funding__c = 'FI';
            qli.Financing__c = 'Fully Insured';
            qli.Involvement_Type__c='Slice';
            qli.Line_of_Business__c = 'Life';
            //qli.Members__c = 200;
            qli.Estimated_Annualized_Premium__c = 50000;
            qli.PricebookEntryId = pricebookentrylist[0].Id;
            qli.UnitPrice = (i+1)*10;
            qli.Subscribers__c = i+10;
            qli.Network__c = 'Dental Net';
            qli.ProductStage__c = 'Sold';
            quotelineitemlist.add(qli);
        }
        Database.insert(quotelineitemlist);
        Set<Id> qliIDSet = new Set<Id>();
        for(QuoteLineItem qli:quotelineitemlist){
            qliIDSet.add(qli.id);
        }
        System.debug('QLI List'+quotelineitemlist[0].Id);
        quotelineitemlist = [Select Id,Comp_Estimator_Member_Eligible_Goal_LOB__c,Comp_Estimator_Opportunity_Team_Members__c,Implementation_Complete_Year__c,Comp_Estimator_Premium_Eligible_Goal_LOB__c,Quote.Opportunity.Account_Executive__c,Quote.Opportunity.Account_Manager__c from QuoteLineItem where Id in:qliIDSet];
        System.debug('Opp Team member'+quotelineitemlist);
        
        Test.startTest();
        List<Compensation_Estimator__c> ceList = new List<Compensation_Estimator__c>();
        Compensation_Estimator__c ce = new Compensation_Estimator__c();
        ce.Name = 'Test CE';
        ce.Medical_Included__c = true;
        ce.OwnerId = userList[0].Id;
        ceList.add(ce);    
        insert ceList;
        	
        List<Compensation_Estimator_Goal__c> cegList = new List<Compensation_Estimator_Goal__c>();
        Compensation_Estimator_Goal__c ceg = new Compensation_Estimator_Goal__c();
        ceg.Estimation_Summary__c = ce.id;
        ceg.Line_of_Business__c = 'Medical';
        ceg.YTD_Members__c = 0;
        ceg.YTD_Premiums__c = 0;
        cegList.add(ceg);
        
        Compensation_Estimator_Goal__c ceg1 = new Compensation_Estimator_Goal__c();
        ceg1.Estimation_Summary__c = ce.id;
        ceg1.Line_of_Business__c = 'Life';
        ceg1.YTD_Members__c = 0;
        ceg1.YTD_Premiums__c = 0;
        cegList.add(ceg1);
        
        insert cegList;
        Compensation_Estimator_Goal__c ceg2 = [Select Id,YTD_Members__c,YTD_Premiums__c from Compensation_Estimator_Goal__c where Id=:cegList[0].Id];
        System.assertEquals(20*200, ceg2.YTD_Members__c);
        System.assertEquals(0, ceg2.YTD_Premiums__c);
        cegList[1].Refresh__c = true;
        update cegList;
        Test.stopTest();
    }
}
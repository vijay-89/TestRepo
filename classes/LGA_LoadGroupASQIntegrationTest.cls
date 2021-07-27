/*******************************************************************************************
@class Name  : LGA_LoadGroupASQIntegrationTest
@created By  : IDC Offshore
@createdDate : 1/10/2020
@description : This test class is for LGA_LoadGroupASQIntegration
********************************************************************************************/
@isTest
public class LGA_LoadGroupASQIntegrationTest {
    @testSetup static void setup() {
                
        //Account creation
        List<Id> accountRecordTypeIdList = new List<Id>();
        Id prospectAccRecordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('LG Prospect').getRecordTypeId();
        accountRecordTypeIdList.add(prospectAccRecordType);
        List<Account> accountObjList = Anthem_TestDataFactory.generateAccount(accountRecordTypeIdList);        
        insert accountObjList;
        
        // Create common test Opportunities
        List<Id> opportunityRecordTypeIdList = new List<Id>();
        Id newBusinsLocalOppRecordType = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('New Business Local').getRecordTypeId();
        OpportunityRecordTypeIdList.add(newBusinsLocalOppRecordType);
        List<Opportunity> oppObjList = Anthem_TestDataFactory.generateOpportunity(opportunityRecordTypeIdList, accountObjList.get(0).Id);
        insert oppObjList;
        
        //Create Products
        Product2 product1 = Anthem_TestDataFactory.createProduct('Medical Product','Medical','Plan','1234',true);
        Product2 product3 = Anthem_TestDataFactory.createProduct('Dental Product','Dental','Plan','12345',true);
        Product2 product4 = Anthem_TestDataFactory.createProduct('Vision Product','Vision','Plan','123456',true);
        List<Product2> productList = new List<Product2>{product1,product3,product4}; 
        insert productList;
        
        //Create pricebook
        Id pricebookId = Anthem_TestDataFactory.generatePricebookId();  
        
        // Create common test PricebookEntry        
        PricebookEntry pricebookEntryObj = Anthem_TestDataFactory.generatePricebookEntry(productList[0].Id, pricebookId);
        insert pricebookEntryObj;
        
        // Create common test Group
        Group__c grpList = Anthem_TestDataFactory.createGroup(accountObjList[0].Id);
        grpList.Billing__c = 'Customized Billing Arrangement';
        database.insert(grpList);
        
        // Create common test Quotes        
        List<Quote>quoteObjList = Anthem_TestDataFactory.createQuote(pricebookId, oppObjList.get(0).Id);
        insert quoteObjList;
        
        
        //Quote line item creation
        List<Id> quoteLineItem = new List<Id>();
        List<QuoteLineItem> quoteLineItemTest = Anthem_TestDataFactory.generateQuoteLineItemByProductList(quoteObjList[0].Id, productList, pricebookEntryObj.Id);      
        for(QuoteLineItem qli : quoteLineItemTest)
        {
            qli.ProductStage__c = 'Sold';        
        } 
        insert quoteLineItemTest; 
        
        //Order creation
        List<Id>orderList = new List<Id>();
        List<Order>orderObjList = Anthem_TestDataFactory.groupPlanImplementationCase(accountObjList.get(0).Id,quoteObjList.get(0).Id,
                                                                                     oppObjList.get(0).Id,grpList.Id,quoteLineItemTest[0].Id);
        
        insert orderObjList;   
        
    }
    @isTest
    public static  void  invokeLoadGroupTestMethod(){                       
        Order implCase = [SELECT id,Impacted_Products_Id__c from Order LIMIT 1];                                          
        Test.startTest();
        LGA_LoadGroupASQIntegration invokedLoadGroupInt = new LGA_LoadGroupASQIntegration();
        Map <String, Object> inputJson = new Map<String,Object>();
        Map <String, Object> outJson = new Map <String,Object>();
        Map <String, Object> optnsJson = new Map <String,Object>();
        optnsJson.put('implCaseId', implCase.Id);
        Boolean result = invokedLoadGroupInt.invokeMethod('loadGroupInt', inputJson, outJson, optnsJson);
                
        
        Test.stopTest();               
    }
        
     @isTest
    public static  void  invokeAsqTestMethod(){                       
        Order implCase = [SELECT id,Impacted_Products_Id__c from Order LIMIT 1];                                          
        Test.startTest();
        LGA_LoadGroupASQIntegration invokedAsqInt = new LGA_LoadGroupASQIntegration();
        Map <String, Object> inputJson = new Map<String,Object>();
        Map <String, Object> outJson = new Map <String,Object>();
        Map <String, Object> optnsJson = new Map <String,Object>();
        optnsJson.put('implCaseId', implCase.Id);
        Boolean result = invokedAsqInt.invokeMethod('accountStructureInt', inputJson, outJson, optnsJson);
                
        
        Test.stopTest();               
    }
 
}
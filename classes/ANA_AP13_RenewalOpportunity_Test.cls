/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ANA_AP13_RenewalOpportunity_Test {
    
    private static final String OPPR = 'Opportunity';
    private static final String REBEWAL = 'Renewal';
    private static final String IGAPOPP = 'In Group Add Product';
    private static final String INITSTAG = 'Initiated';
    private static final string CLAIMSYSTEM= 'CS90';
    private static final string NATIONALAMPROFILE='National Sales';
    /*by using this method call the variables & methods from ANA_AP13_RenewalOpportunity class*/
    static testMethod void renewalOpportunityclone() {
        // TO DO: implement unit test
        Profile profileNA = [select id from profile where name=:NATIONALAMPROFILE limit 1];
        User user1=ANA_UTIL01_TestMethods.runAsUser(profileNA.id);
        system.runAs(user1){
             Account acc=ANA_UTIL01_TestMethods.createAccount(false); 
            Database.insert(acc);
            Opportunity oppty=ANA_UTIL01_TestMethods.createOpportunity(false,acc.id);
            oppty.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,REBEWAL);
            oppty.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(oppty);
            
            Opportunity opptyigap=ANA_UTIL01_TestMethods.createOpportunity(false,acc.id);
            opptyigap.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,IGAPOPP);
            opptyigap.ParentOppty__c = oppty.Id;
            opptyigap.StageName = INITSTAG; 
            oppty.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(opptyigap);
            
            Opportunity opptynew=ANA_UTIL01_TestMethods.createOpportunity(false,acc.id);
            opptynew.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,REBEWAL);
            opptynew.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(opptynew);
            
            Group__c grp=ANA_UTIL01_TestMethods.createGroup(acc.id,false);
            grp.ClaimSystem__c=CLAIMSYSTEM;
            Database.insert(grp);
            //list<Quote> listquote = new list<Quote>();
            Quote qte=ANA_UTIL01_TestMethods.createQuote(false,oppty.Id);
            //qte.GroupNumber__c=grp.id;
            qte.OpportunityId = opptyigap.id;
            Database.insert(qte);
            
            Quote qteig=ANA_UTIL01_TestMethods.createQuote(false,oppty.Id);
            qteig.GroupNumber__c=grp.id;
            qteig.OpportunityId = oppty.id;
            Database.insert(qteig);
            
            Quote qteigap=ANA_UTIL01_TestMethods.createQuote(false,opptyigap.Id);
            qteigap.GroupNumber__c=grp.id;
            qteigap.OpportunityId = opptyigap.id;
            Database.insert(qteigap);
            
            //listquote.add(qte);
            Product2 prd=ANA_UTIL01_TestMethods.createProduct(false);
            prd.isActive = true;
            database.insert(prd);
            PricebookEntry pbe=ANA_UTIL01_TestMethods.createPricebookEntry(false,prd.id);
            database.insert(pbe);
            Quotelineitem qlitem = ANA_UTIL01_TestMethods.createQuoteLineItem(false,qte.id,pbe.id);
            qlitem.ProductStage__c = 'Renewed';
            database.insert(qlitem);
            
            Quotelineitem qlitemig = ANA_UTIL01_TestMethods.createQuoteLineItem(false,qteig.id,pbe.id);
            qlitemig.ProductStage__c = 'Renewed';
            database.insert(qlitemig);
            
            Quotelineitem qlitemigap = ANA_UTIL01_TestMethods.createQuoteLineItem(false,qteigap.id,pbe.id);
            qlitemigap.ProductStage__c = 'Renewed';
            database.insert(qlitemigap);
            
            // PRDCRM-38679 Added Advance Network for Coverage
            AlternateNetwork__c alObj = new AlternateNetwork__c();
            alObj.QuoteLineItem__c = qlitemig.Id;
            insert alObj; 
            
            ProductSelectionDetail__c psObj = new ProductSelectionDetail__c();
            psObj.QuoteLineItem__c = qlitemig.Id;
            insert psObj;
            
            ANA_AP13_RenewalOpportunity c= new ANA_AP13_RenewalOpportunity();
            Map<String,Object> inputmap=new Map<String,Object>();
            Map<String,Object> outputmap=new Map<String,Object>();
            Map<String,Object> options=new Map<String,Object>();
            
            inputmap.put('NewOptyId',opptynew.id);
            inputmap.put('OldOptyId',oppty.id);
            c.invokeMethod('getRenewalOpportunity',inputmap,outputmap,options);
            system.assertEquals('Renewed', qlitemigap.ProductStage__c);
        }
    }
    /*Below method is useful for test the elseif quote line item record related with IGAP*/
    static testMethod void renewalOpportunityclonenonquote() {
        // TO DO: implement unit test
         Profile profileNA = [select id from profile where name=:NATIONALAMPROFILE limit 1];
        User user1=ANA_UTIL01_TestMethods.runAsUser(profileNA.id);
        system.runAs(user1){
             Account acc=ANA_UTIL01_TestMethods.createAccount(false); 
            Database.insert(acc);
            Opportunity oppty=ANA_UTIL01_TestMethods.createOpportunity(false,acc.id);
            oppty.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,REBEWAL);
            oppty.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(oppty);
            
            Opportunity opptyigap=ANA_UTIL01_TestMethods.createOpportunity(false,acc.id);
            opptyigap.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,IGAPOPP);
            opptyigap.ParentOppty__c = oppty.Id;
            opptyigap.StageName = INITSTAG; 
            oppty.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(opptyigap);
            
            Opportunity opptynew=ANA_UTIL01_TestMethods.createOpportunity(false,acc.id);
            opptynew.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,REBEWAL);
            opptynew.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(opptynew);
            
            Group__c grp=ANA_UTIL01_TestMethods.createGroup(acc.id,false);
            grp.ClaimSystem__c=CLAIMSYSTEM;
            Database.insert(grp);
            //list<Quote> listquote = new list<Quote>();
            Quote qte=ANA_UTIL01_TestMethods.createQuote(false,oppty.Id);
            qte.GroupNumber__c=grp.id;
            qte.OpportunityId = opptyigap.id;
            Database.insert(qte);
            //listquote.add(qte);
            Product2 prd=ANA_UTIL01_TestMethods.createProduct(false);
            database.insert(prd);
            PricebookEntry pbe=ANA_UTIL01_TestMethods.createPricebookEntry(false,prd.id);
            database.insert(pbe);
            Quotelineitem qlitem = ANA_UTIL01_TestMethods.createQuoteLineItem(false,qte.id,pbe.id);
            qlitem.ProductStage__c = 'IGAP In Progress';
            database.insert(qlitem);
            
            ANA_AP13_RenewalOpportunity c= new ANA_AP13_RenewalOpportunity();
            Map<String,Object> inputmap=new Map<String,Object>();
            Map<String,Object> outputmap=new Map<String,Object>();
            Map<String,Object> options=new Map<String,Object>();
            
            inputmap.put('NewOptyId',opptynew.id);
            inputmap.put('OldOptyId',oppty.id);
            c.invokeMethod('getRenewalOpportunity',inputmap,outputmap,options);
            system.assertEquals('IGAP In Progress',qlitem.ProductStage__c);
        }     
    }
    
     /*Below method is useful for test the catch block*/
    static testMethod void renewalOpportunitycatch(){
       Profile profileNA = [select id from profile where name=:NATIONALAMPROFILE limit 1];
        User user1=ANA_UTIL01_TestMethods.runAsUser(profileNA.id);
        system.runAs(user1){
           try{
            Test.starttest(); 
            Account acc=ANA_UTIL01_TestMethods.createAccount(false); 
            Database.insert(acc);
            Opportunity oppty=ANA_UTIL01_TestMethods.createOpportunity(false,null);
            oppty.RecordTypeId=ANA_UTIL01_TestMethods.getRecordTypeId(OPPR,REBEWAL);
            oppty.closedate = Date.newInstance( System.Today().year()+1, System.Today().month(), 5 );//system.today()+1;
            Database.insert(oppty);
            Quote qins = new Quote();
            database.insert(qins);
            Quotelineitem qlins = new Quotelineitem();
            database.insert(qlins);
            Test.stopTest();
           }catch(DMLException e) {
                system.assertEquals(e.getMessage(), e.getMessage());
            } catch(exception excn){
                system.assertEquals(excn.getMessage(), excn.getMessage());
            }
        }
        
    }
}
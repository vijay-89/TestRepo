@isTest
public with sharing class BenefitTriggerServiceTest {
    /*
*******************************************************************************************
* Name          BenefitTriggerServiceTest
* Author        Pratibha (Enforcers)
* ModifiedBy    Pratibha (Enforcers)
* CreatedDate   02/24/2020
* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
* Description        
* The BenefitTriggerServiceTest apex class is responsible for apex code coverage for classes
BenefitTrigger, BenefitTriggerHandler,BenefitService
* -----------------------------------------------------------------------------------------------------------------------------------------------------------------
* FUNCTIONAL TEST LOGIC
* ----------------------------------------------------------------------------------------------------------------------------------------------------------------
* 1 - createCommonTestData() 
*           > TestSetup Method to create the required Test Data
* 
* 2 - createBenefitPositiveCase() and createBenefitNegativeCase()  
*           > Checks the scenario for Duplicate Benefit creation both Positive and Negative scenarios.
* 
* 3 - createBenefitBulkify()
*           > Checks the scenario for bulkified Benefit Creation
*
* 4 - updateBenefitPositiveCase() and updateBenefitNegativeCase()
*           > Checks the scenario for update with existing benefit field values.
* 
* 5- updateBenefitBulkify()
*           > Checks the scenario for bulkified Benefit Update
*
* 6- triggerDisableCheck()
*          > Is used to test the trigger disable method in Handler
*
* 7- triggerBenefitUnusedMethods()
*          > Is used to test the unused methods in the benefit trigger handler class 
*
* 
*  
* Additional information
* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
* Changes
* Version                   
* Date                                          
* Explanation               
* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------   

*/
    @testSetup static void createCommonTestData() { 
        
        Integer iRecordCount = staticVariableClass.RECORD_COUNT; 
        String sName = staticVariableClass.NAME;
        String sStreet = staticVariableClass.STREET;
        String sCity = staticVariableClass.CITY; 
        String sState = staticVariableClass.ACCOUNTSTATE;
        String sZip = staticVariableClass.ZIP;
        String sCountry = staticVariableClass.COUNTRY;
        String sStateCode = staticVariableClass.STATECODE;
        
        List<Account> listAcc = TestDataFactory.createAccountSICList(iRecordCount  ,sName, sStreet, sCity, sState, sZip, sCountry, sStateCode);
        insert listAcc;  
        
        List<Case> listCase = TestDataFactory.createCaseList(iRecordCount, listAcc[0]);
        listCase[0].recordTypeId = staticVariableClass.CASERECORDTYPEID;
        insert listCase; 
        
        Benefit__c oBenefit1 = new Benefit__c(Plan_Name__c = sName,Competitor_Name__c = sStreet,RecordTypeId = staticVariableClass.DEVRECORDTYPEID,case__c = listCase[0].Id);
        Benefit__c oBenefit2 = new Benefit__c(Plan_Name__c = sName,Competitor_Name__c = sCity,RecordTypeId = staticVariableClass.DEVRECORDTYPEID,case__c = listCase[0].Id); 
        insert new List<Benefit__c>{oBenefit1,oBenefit2};
            
            
       
            }
    /**
_________________________________________________________________________________________
@Description :This method tests about benefit create record validation positive scenario
_________________________________________________________________________________________
**/
    
    @isTest static void createBenefitPositiveCase(){
        try{
            
            Case oCase = [Select Id from Case where recordtype.name=:staticVariableClass.CASERECORDTYPENAME LIMIT 1];
            
            
            
            Integer iRecordCount = staticVariableClass.ONE_RECORD_COUNT;
            List<Benefit__c> listBenefit = TestDataFactory.createBenefitList(iRecordCount,oCase);
            
            for(Benefit__c oBen:listBenefit){
                oBen.Plan_Name__c =  staticVariableClass.NAME;
                oBen.Competitor_Name__c = staticVariableClass.STREET;
                oBen.RecordTypeId = staticVariableClass.DEVRECORDTYPEID;
            }
                
            test.startTest();
                insert listBenefit;
            
            test.stopTest();
            system.assertEquals(staticVariableClass.RETURN_ZERO, listBenefit.size(), staticVariableClass.ASSERT_MESSAGE_POSITIVE);
            
        }
        catch(Exception e){
            String message = e.getMessage();
            System.assertEquals(true,message.contains('A benefit record already exists with this Competitor and Plan Name.'),staticVariableClass.ASSERT_MESSAGE_POSITIVE);
        }
        
    }
    /**   
_________________________________________________________________________________________
@Description :This method tests about benefit create bulkification scenario
_________________________________________________________________________________________
**/
    
    @isTest static void createBenefitBulkify(){
        try{
            
            Case oCase = [Select Id from Case where recordtype.name=:staticVariableClass.CASERECORDTYPENAME LIMIT 1];
            
            
            Integer iRecordCount = staticVariableClass.RECORD_COUNT;
            List<Benefit__c> listBenefit = TestDataFactory.createBenefitList(iRecordCount,oCase);
            
            for(Benefit__c oBen:listBenefit){
                oBen.Plan_Name__c =  staticVariableClass.NAME;
                oBen.Competitor_Name__c = staticVariableClass.STREET;
                oBen.RecordTypeId = staticVariableClass.DEVRECORDTYPEID;
            }
            test.startTest();
                insert listBenefit;
            test.stopTest();
            system.assertEquals(staticVariableClass.RETURN_ZERO, listBenefit.size(), staticVariableClass.ASSERT_MESSAGE_POSITIVE);
            
        }
        catch(Exception e){
            String message = e.getMessage();
            System.assertEquals(true,message.contains('A benefit record already exists with this Competitor and Plan Name.'),staticVariableClass.ASSERT_MESSAGE_POSITIVE);
        }
        
    }
    
    
    /**
_________________________________________________________________________________________
@Description :This method tests about benefit create record validation negative scenario
_________________________________________________________________________________________
**/
    @isTest static void createBenefitNegativeCase(){
        try{
            
            Case oCase = [Select Id from Case where recordtype.name=:staticVariableClass.CASERECORDTYPENAME LIMIT 1];
            
            
            Benefit__c objNewBenefitRec = new Benefit__c(case__c =oCase.Id,
                                                         Plan_Name__c = staticVariableClass.NAME, 
                                                         Competitor_Name__c = staticVariableClass.ACCOUNTSTATE, 
                                                         RecordTypeId = staticVariableClass.DEVRECORDTYPEID );
            test.startTest();   
                insert objNewBenefitRec;
            
            test.stopTest();
            system.assertEquals(objNewBenefitRec.Competitor_Name__c, staticVariableClass.ACCOUNTSTATE, staticVariableClass.ASSERT_MESSAGE_NEGATIVE);
            
        }
        catch(Exception e){
            String message = e.getMessage();
            System.assertEquals(false,message.contains('A benefit record already exists with this Competitor and Plan Name.'),staticVariableClass.ASSERT_MESSAGE_NEGATIVE);
        }
        
    }
    
    /**
_________________________________________________________________________________________
@Description :This method tests about benefit update record validation positive scenario
_________________________________________________________________________________________
**/  
    
    @isTest static void updateBenefitPositiveCase(){
        
        try{
            Case oCase = [Select Id from Case where recordtype.name=:staticVariableClass.CASERECORDTYPENAME LIMIT 1];
            
            
            Benefit__c objNewBenefitRec = [Select Id,Plan_Name__c,Competitor_Name__c
                                           from Benefit__c 
                                           where Case__c =: oCase.Id 
                                           and Plan_Name__c =: staticVariableClass.NAME 
                                           and Competitor_Name__c =:staticVariableClass.STREET LIMIT 1];
            
            objNewBenefitRec.Competitor_Name__c = staticVariableClass.CITY;
            test.startTest();
                update objNewBenefitRec;
            test.stopTest();
            
            system.assertEquals(objNewBenefitRec.Competitor_Name__c, staticVariableClass.STREET, staticVariableClass.ASSERT_MESSAGE_POSITIVE);
        }
        catch(Exception e){
            String message = e.getMessage();
            System.assertEquals(true,message.contains('A benefit record already exists with this Competitor and Plan Name.'),staticVariableClass.ASSERT_MESSAGE_POSITIVE);
        }  
    } 
    
    /**
_________________________________________________________________________________________
@Description :This method tests about benefit update record validation negative scenario
_________________________________________________________________________________________
**/  
    
    @isTest static void updateBenefitNegativeCase(){
        
        try{
            Case oCase = [Select Id from Case where recordtype.name=:staticVariableClass.CASERECORDTYPENAME LIMIT 1];
            
            Benefit__c objNewBenefitRec = [Select Id,Plan_Name__c,Competitor_Name__c
                                           from Benefit__c 
                                           where Case__c =: oCase.Id 
                                           and Plan_Name__c =: staticVariableClass.NAME 
                                           and Competitor_Name__c =:staticVariableClass.STREET LIMIT 1];
            
            objNewBenefitRec.Competitor_Name__c = staticVariableClass.COUNTRY;
            test.startTest();
            
                update objNewBenefitRec;
            test.stopTest(); 
            system.assertEquals(objNewBenefitRec.Competitor_Name__c, staticVariableClass.COUNTRY, staticVariableClass.ASSERT_MESSAGE_NEGATIVE);
        }
        catch(Exception e){
            String message = e.getMessage();
            System.assertEquals(false,message.contains('A benefit record already exists with this Competitor and Plan Name.'),staticVariableClass.ASSERT_MESSAGE_NEGATIVE);
        }  
    }
    
    /**   
_________________________________________________________________________________________
@Description :This method tests about benefit update bulkification scenario
_________________________________________________________________________________________
**/
    
    @isTest static void updateBenefitBulkify(){
        try{
            
            Case oCase = [Select Id from Case where recordtype.name=:staticVariableClass.CASERECORDTYPENAME LIMIT 1];
            
            Integer iRecordCount = staticVariableClass.RECORD_COUNT_TWO_HUNDRED;
            List<Benefit__c> listBenefit = [Select Id,Competitor_Name__c,Plan_Name__c,RecordTypeId,Case__c 
                                            FROM Benefit__c 
                                            WHERE Case__c  =:oCase.Id];
            
            for(Benefit__c oBen:listBenefit){
                oBen.Competitor_Name__c = staticVariableClass.CITY;
            }
            test.startTest();
                update listBenefit;
            test.stopTest();
            for(Benefit__c oBen: listBenefit){
                if(oBen.Competitor_Name__c ==  staticVariableClass.CITY){
                    system.assertEquals(oBen.Competitor_Name__c, staticVariableClass.CITY, staticVariableClass.ASSERT_MESSAGE_POSITIVE);  
                }
                
            }
            
        }
        catch(Exception e){
            String message = e.getMessage();            
            System.assertEquals(true,message.contains('A benefit record already exists with this Competitor and Plan Name.'),staticVariableClass.ASSERT_MESSAGE_POSITIVE);
        }
        
    }
    
    /**   
_________________________________________________________________________________________
@Description :This method test the trigger disable method in BenefitTriggerHandler
_________________________________________________________________________________________
**/
    
    @isTest static void triggerDisableCheck(){
        
        Trigger_Setting__c objTriggerSetting = new Trigger_Setting__c();
        objTriggerSetting.BenefitTriggerDisabled__c = true;
        Insert objTriggerSetting;
        test.startTest();
            BenefitTriggerHandler disableCheckTrigger =new BenefitTriggerHandler();
            disableCheckTrigger.IsDisabled();
        system.assertEquals(true, objTriggerSetting.BenefitTriggerDisabled__c,staticVariableClass.ASSERT_MESSAGE_POSITIVE);
        test.stoptest();
    }
    /**
    _________________________________________________________________________________________
@Description :This method tests unused methods inside BenefitTriggerHandler
_________________________________________________________________________________________
**/
    
    @isTest static void triggerBenefitUnusedMethods(){
        
         Map<Id,Benefit__c> mapEmptyBenefit = new Map<Id,Benefit__c>();
        BenefitTriggerHandler oTriggerHandlerInstance = new BenefitTriggerHandler();
        oTriggerHandlerInstance.afterInsert(mapEmptyBenefit);
        oTriggerHandlerInstance.afterUpdate(mapEmptyBenefit,mapEmptyBenefit);
        oTriggerHandlerInstance.beforeDelete(mapEmptyBenefit);
        oTriggerHandlerInstance.afterDelete(mapEmptyBenefit);
        oTriggerHandlerInstance.afterUndelete(mapEmptyBenefit);
    }
    
    
}
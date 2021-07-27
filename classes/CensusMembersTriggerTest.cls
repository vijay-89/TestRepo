/*
*******************************************************************************************
* Name          CensusMembersTriggerTest
* Author        Anshul Nagraj (Deloitte)
* CreatedDate   11th FEB 2020
* UsedBy        The CensusMembersTriggerTest apex class is responsible for apex code coverage for classes
                CensusMembersService, CensusMembersTriggerHandler, CensusMembersTrigger.
*********************************************************************************************
*/
@isTest
public class CensusMembersTriggerTest{
            
    /*
    * @description: This Method is used for test CensusMembersTrigger by creating the Census Member records
    * @name: testCensusMembersTrigger
    * Created Date: 11th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545   
    */ 
    public static testMethod void testCensusMembersTrigger(){
        
        List<Census__c> listToCreateCensus = new List<Census__c>();
        listToCreateCensus = TestDataFactory.createCensus(5);
        Insert listToCreateCensus;      
        
        Test.startTest();
        
        system.assertEquals(listToCreateCensus.size(), 5);
        
        // Insert Test
        List<Census_Members__c> listToCreateCensusMembers = new List<Census_Members__c>();
        listToCreateCensusMembers = TestDataFactory.createCensusMembers(5, listToCreateCensus[0].id);
        Insert listToCreateCensusMembers;
        Census__c updatedCensusAfterInsert = [SELECT Id, Avg_Age__c, Plan_Count__c FROM Census__c WHERE id =: listToCreateCensus[0].id];
        system.assertNotEquals(listToCreateCensus[0].Avg_Age__c, updatedCensusAfterInsert.Avg_Age__c);
        system.assertEquals(updatedCensusAfterInsert.Plan_Count__c, 1); 
        
        // Update Test
        listToCreateCensusMembers[1].Age__c = 41;
        Update listToCreateCensusMembers;
        Census__c updatedCensusAfterUpdate = [SELECT Id, Avg_Age__c, Plan_Count__c FROM Census__c WHERE id =: listToCreateCensus[0].id];
        system.assertNotEquals(listToCreateCensus[0].Avg_Age__c, updatedCensusAfterUpdate.Avg_Age__c);           
        
        // Test Coverage for unused methods inside CensusMembersTriggerHandler
        Map<id,Census_Members__c> emptyCensusMembersMap = new Map<id,Census_Members__c>();
        List<Census_Members__c> emptyCensusMembersList = new List<Census_Members__c>(); 
        CensusMembersTriggerHandler triggerHandlerInstance = new CensusMembersTriggerHandler();
        triggerHandlerInstance.beforeInsert(emptyCensusMembersList);
        triggerHandlerInstance.beforeUpdate(emptyCensusMembersMap,emptyCensusMembersMap);
        triggerHandlerInstance.beforeDelete(emptyCensusMembersMap);
        triggerHandlerInstance.afterDelete(emptyCensusMembersMap);
        triggerHandlerInstance.afterUndelete(emptyCensusMembersMap);
        
        // Trigger Disable Test
        triggerDisableCheck(listToCreateCensusMembers);
        
        Test.stopTest();
    }
    
    /*
    * @description: This Method is used to test trigger disable method in Handler
    * @name: triggerDisableCheck
    * Created Date: 11th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545   
    */
    public static void triggerDisableCheck(List<Census_Members__c> listCensusMembers){
        
        Trigger_Setting__c objTriggerSetting = new Trigger_Setting__c();
        objTriggerSetting.CensusMembersTriggerDisabled__c = true;
        Insert objTriggerSetting;
        
        listCensusMembers[1].Age__c = 52;
        Update listCensusMembers;
    }
}
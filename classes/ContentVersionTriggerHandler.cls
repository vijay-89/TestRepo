/*
*******************************************************************************************
* Name          ContentVersionTriggerHandler
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   01/28/2020
* UsedBy        This is a handler class from where we need to call all service method.
*********************************************************************************************
*/
 
public with sharing class ContentVersionTriggerHandler implements ITriggerHandler {
     public static Boolean triggerDisabled = false;
     public static boolean run = true;     
     /*
     * @This method will be used to Active/Deactivate the trigger from custom settings value
     * @Name:IsDisabled
     * @Change, Added Custom Setting with a field and a record.
     * @Created Date: 28th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1386   
     */
     public Boolean IsDisabled() {
         Trigger_Setting__c objTriggerSetting = Trigger_Setting__c.getinstance();
         if (objTriggerSetting.ContentVersionTriggerDisabled__c == true){
             return true;
         }
         else{
             return triggerDisabled;
         }         
     }
    /*
     * @This method will be used to prevent the trigger from running recursively
     * @Name:runOnce
     * @Created Date: 30th January 2020
     * @Author : Deloitte
     * @Description Jira user story PRCDM2-1386   
     */
    
      public Boolean checkRecursion(){
          if(run){
              run=false;
              return true;
          }else{
              return run;
          }              
      }     
     /*
     * @This method afterinser context to call service class
     * @Name:afterInsert
     * @Change, Added Custom Setting with a field and a record.
     * @Created Date: 28th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1386   
     */   
     public void afterInsert(map<Id, sObject> newItems) {
         ContentVersionService.sendRequest(newItems);  
     } 

     public void afterUpdate(Map<Id, sObject> newItems, Map<Id, sObject> oldItems) {
         
     }
    
     public void beforeInsert(List<sObject> newItems) {
            
     }
  
     public void beforeUpdate(Map<Id, sObject> newItems, Map<Id, sObject> oldItems) {
     
     }
     
     public void beforeDelete(Map<Id, sObject> oldItems) {
     
     }
     
     public void afterDelete(Map<Id, sObject> oldItems) {
     
     }
  
     public void afterUndelete(Map<Id, sObject> oldItems) {
     
     }
}
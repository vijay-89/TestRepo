/*
*******************************************************************************************
* Name          BenefitTriggerHandler 
* Author        Pratibha (Enforcers)
* ModifiedBy    Pratibha (Enforcers)
* CreatedDate   02/24/2020
* UsedBy        This is a handler class from where we need to call all service methods for Benefit Trigger.
* Jira US       Jira user story PRCDM2-1855
*********************************************************************************************
*/


public with sharing class BenefitTriggerHandler implements ITriggerHandler {
    public static Boolean triggerDisabled = false;
    public static Boolean run = true; 
    /*
     * @This method will be used to Active/Deactivate the trigger from custom settings value
     * @Name:IsDisabled
     * @Created Date: 02/24/2020
     * @Author : Pratibha (Enforcers)
     * @Jira user story : PRCDM2-1855   
     */
    public Boolean IsDisabled() {
        Trigger_Setting__c objTriggerSetting = Trigger_Setting__c.getinstance();
        if (objTriggerSetting.BenefitTriggerDisabled__c == true){
            return true;
        }
        else{
            return triggerDisabled;
        }         
    }
    /*
     * @This method will be used to prevent the trigger from running recursively
     * @Name:checkRecursion
     * @Created Date: 02/24/2020
     * @Author : Pratibha (Enforcers)
     * @Jira user story: PRCDM2-1855   
     */
    public Boolean checkRecursion(){
        if(run){
            run=false;
            return true;
        }else{
            return run;
        }              
    } 
    public void afterInsert(map<Id, sObject> newItems) {
         // For Future Use
        
    } 
    
    public void afterUpdate(Map<Id, sObject> newItems, Map<Id, sObject> oldItems) {
        // For Future Use 
    }
    /*
     * @This method is used in beforeInsert context to call service class
     * @Name:beforeInsert
     * @Created Date: 02/24/2020
     * @Author : Pratibha (Enforcers)
     * @Jira user story : PRCDM2-1855  
     */  
    public void beforeInsert(List<sObject> listNewItems) {
     
        BenefitService.duplicateBenefitCheckbeforeInsert(listNewItems); 
    
    }
     /*
     * @This method is used in beforeupdate context to call service class
     * @Name:beforeUpdate
     * @Created Date: 02/24/2020
     * @Author : Pratibha (Enforcers)
     * @Jira user story: PRCDM2-1855  
     */
    public void beforeUpdate(Map<Id, sObject> mapNewItems, Map<Id, sObject> mapOldItems) {
       
            BenefitService.duplicateBenefitCheckbeforeUpdate(mapNewItems, mapOldItems);
    }
    
    // For Future Use
    public void beforeDelete(Map<Id, sObject> oldItems) {}
    
    
    public void afterDelete(Map<Id, sObject> oldItems) {}
         // For Future Use
    //}
    
    public void afterUndelete(Map<Id, sObject> oldItems) {}
         // For Future Use
    //}
}
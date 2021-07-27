/*
*******************************************************************************************
* Name          CensusMembersTriggerHandler
* Author        Anshul Nagraj (Deloitte)
* CreatedDate   10th FEB 2020
* UsedBy        This is a handler class from where we need to call all service method.
*********************************************************************************************
*/
public class CensusMembersTriggerHandler implements ITriggerHandler {
    
    public static Boolean triggerDisabled = false;   
    public static Boolean run = true;      
    
    /*
    * @Description: This method will be used to Active/Deactivate the trigger from custom settings value
    * @Name: IsDisabled
    * @Created Date: 10th FEB 2020
    * @Author: Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545   
    */
    public Boolean IsDisabled() {
        Trigger_Setting__c objTriggerSetting = Trigger_Setting__c.getinstance();
        
        if (objTriggerSetting.CensusMembersTriggerDisabled__c == true){
            return true;
        }
        else{
            return triggerDisabled;
        }         
    }
    
    /*
    * @Description: This method will be used to prevent the trigger from running recursively
    * @Name:checkRecursion
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545   
    */
    public Boolean checkRecursion() {
        if(run){
            run=false;
            return true;
        }
        else{
            return run;
        }              
    }
    
    /*
    * @Description: This method is used in beforeInsert context to call service class
    * @Name: beforeInsert
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void beforeInsert(List<SObject> newItems) {
        // For Future Use  
    }
    
    /*
    * @Description: This method is used in beforeUpdate context to call service class
    * @Name: beforeUpdate
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        // For Future Use 
    }
    
    /*
    * @Description: This method is used in afterInsert context to call service class
    * @Name: afterInsert
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void afterInsert(Map<Id, SObject> newItems) {
        CensusMembersService.updateAggregateCensusData(newItems.values());  
    }
    
    /*
    * @Description: This method is used in afterUpdate context to call service class
    * @Name: afterUpdate
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        CensusMembersService.updateAggregateCensusData(newItems.values());  
    } 
    
    /*
    * @Description: This method is used in beforeDelete context to call service class
    * @Name: beforeDelete
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void beforeDelete(Map<Id, SObject> oldItems) {
        // For Future Use
    }
    
    /*
    * @Description: This method is used in afterDelete context to call service class
    * @Name: afterDelete
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void afterDelete(Map<Id, SObject> oldItems) {
        // For Future Use
    }
    
    /*
    * @Description: This method is used in afterUndelete context to call service class
    * @Name: afterUndelete
    * @Created Date: 10th FEB 2020
    * @Author : Anshul Nagraj (Deloitte)
    * @Jira user story: PRDCRM2-1545
    */ 
    public void afterUndelete(Map<Id, SObject> oldItems) {
        // For Future Use 
    }
}
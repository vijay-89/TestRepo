/*
*******************************************************************************************
* Name          TriggerDispatcher
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   01/28/2020
* UsedBy        The dispatcher is responsible for making sure all of the applicable methods on your
                trigger handler are called, depending on the current trigger context
*********************************************************************************************
*/
 
public with sharing class TriggerDispatcher {
     /*
     * @This Method is called from Contentversion Trigger
     * @Name:Run
     * @Param: ITriggerHandler handler
     * @Created Date: 28th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1386   
     */ 
    public static void Run(ITriggerHandler handler) {
        // Check to see if the trigger has been disabled. If it has, return
        if (handler.IsDisabled()){
                return;
        }
         // Check to see if the trigger has run once in the same transaction
        if (!handler.checkRecursion() && !Test.isRunningTest()) {
                return;
        }      
        // Detect the current trigger context and fire the relevant methods on the trigger handler:
        // After trigger logic
        if (Trigger.IsBefore ) {
            if (Trigger.IsInsert)
                handler.beforeInsert(trigger.new);
            if (Trigger.IsUpdate)
                handler.beforeUpdate(trigger.newMap, trigger.oldMap);
            if (Trigger.IsDelete)
                handler.beforeDelete(trigger.oldMap);
        } 
        // After trigger logic  
        else if (Trigger.IsAfter) {
            if (Trigger.IsInsert)
                handler.afterInsert(trigger.newMap);
            if (Trigger.IsUpdate)
                handler.afterUpdate(trigger.newMap, trigger.oldMap);
            if (trigger.IsDelete)
                handler.afterDelete(trigger.oldMap);
            if (trigger.isUndelete)
                handler.afterUndelete(trigger.oldMap);
        }
        
    }
}
/*
*******************************************************************************************
* Name          ITriggerHandler
* Author        Deepak Kumar Reddy Regatte
* CreatedBy     Deepak Kumar Reddy Regatte
* CreatedDate   01/28/2020
* UsedBy        The interface dictates which methods every trigger handler must implement,
                even if these methods have no code in them. By implementing the methods in this class,
                the TriggerDispatcher (discussed below) can be confident that the trigger handler has
                a method for each of these events
*********************************************************************************************
*/
public interface ITriggerHandler {
        void beforeInsert(List<SObject> newItems);
        void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
        void beforeDelete(Map<Id, SObject> oldItems);
        void afterInsert(Map<Id, SObject> newItems);
        void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems);
        void afterDelete(Map<Id, SObject> oldItems);
        void afterUndelete(Map<Id, SObject> oldItems);
        Boolean IsDisabled();
        Boolean checkRecursion();
    
        
}
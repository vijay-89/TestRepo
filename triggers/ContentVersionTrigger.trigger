/*
*******************************************************************************************
* Name          ContentVersionTrigger
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   01/28/2020
* UsedBy        The ContentVersionTrigger is responsible to invoke ContentVersionNLPService 
                in aftertrigger context
*********************************************************************************************
*/
trigger ContentVersionTrigger on ContentVersion (after insert) {
    TriggerDispatcher.Run(new ContentVersionTriggerHandler());
}
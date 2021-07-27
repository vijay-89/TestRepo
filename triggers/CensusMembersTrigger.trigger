/*
*******************************************************************************************
* Name          CensusMembersTrigger
* Author        Anshul Nagraj (Deloitte)
* CreatedDate   10th FEB 2020
* UsedBy        The CensusMembersTrigger is responsible for invoking CensusMembersService 
                in aftertrigger context
*********************************************************************************************
*/
trigger CensusMembersTrigger on Census_Members__c (after insert, after update) {
    TriggerDispatcher.Run(new CensusMembersTriggerHandler());
}
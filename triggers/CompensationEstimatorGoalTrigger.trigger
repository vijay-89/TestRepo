/*
@Author : Suman Manjunatha(Avengers)
@name : CompensationEstimationGoalTrigger
@CreateDate :5thMarch2020
@Description : Compensation Estimation trigger on beofre insert, before update Jira ID: 53813.
@Modifiedby : 
*/
trigger CompensationEstimatorGoalTrigger on Compensation_Estimator_Goal__c (before insert,before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CompensationEstimatorGoalTriggerHandler.onBeforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            CompensationEstimatorGoalTriggerHandler.onBeforeUpdate(Trigger.oldMap,Trigger.new);   
        }
     }
}
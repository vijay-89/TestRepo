/*
@Author : Suman Manjunatha(Avengers)
@CreateDate : 5th March 2020
@description : Handler for Compensation Estimator Goal Object - Created for PRDCRM-53813
*/
public with sharing class CompensationEstimatorGoalTriggerHandler {
    /*
    @description :Method is invoked on before insert event
    @name :onBeforeInsert
    @param :trigger.new
    */
    public static void onBeforeInsert(List<Compensation_Estimator_Goal__c> newCEG){
        CompensationEstimatorGoalActions.updateYTDMembersAndPremium(newCEG);
    }
    /*
    @description :Method is invoked on before update event
    @name :onBeforeUpdate
    @param :trigger.oldMap,trigger.new
    */
    public static void onBeforeUpdate(Map<Id,Compensation_Estimator_Goal__c> oldValMap,List<Compensation_Estimator_Goal__c> newVals){
        List<Compensation_Estimator_Goal__c> newCegList = new List<Compensation_Estimator_Goal__c>();
        for(Compensation_Estimator_Goal__c ceg:newVals){
            if((ceg.Refresh__c!=oldValMap.get(ceg.Id).Refresh__c) && ceg.Refresh__c==true){
                newCegList.add(ceg);
            }
        }
        CompensationEstimatorGoalActions.updateYTDMembersAndPremium(newCegList);
    }
}
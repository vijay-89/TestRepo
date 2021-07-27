/*
@Author : CDHP Team
@name : CDHP_OpportunityAfterUpdate
@CreateDate :25-05-2017
@Description : This trigger fires when Opportunity gets updated.
*/
trigger CDHP_OpportunityAfterUpdate on Opportunity (after update) {   
/* This method checks whether Opportunity stageName changed or not. */ 
    //Commented below code - 38037, 38416
    /*if(TriggerHelperUtility.shouldRunTrigger()){
      //ANA_OpportunityTrigger_Handler.afterUpdate(trigger.new,trigger.oldMap);
        Boolean callMethod = false;
        for(Opportunity opp : trigger.new){
            Opportunity oldOpp = trigger.oldMap.get(opp.Id);
            Boolean oldOppIsWon = oldOpp.StageName.equals('Closed Won');
        Boolean newOppIsWon = opp.StageName.equals('Closed Won');
            if (!oldOppIsWon && newOppIsWon){
                callMethod = true;
            }
        }
        if(callMethod)
            ANA_OpportunityTrigger_Handler.afterUpdate(trigger.new,trigger.oldMap);
    }*/
           
}
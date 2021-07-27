/**
* ------------------------------------------------------------------------------------------------------
* Name          LGRenewalBatchScheduler
* Author        Deloitte Offshore
* ModifiedBy    Deloitte Offshore
* CreatedDate   14/03/2018
* UsedBy        Scheduled in the environment
* ------------------------------------------------------------------------------------------------------
* 
* @description
* 
* This class is a scheduler for LGCreateRenewalOpportunityBatch
* 
* ------------------------------------------------------------------------------------------------------
* Changes
* 
* MCS report corrections for 49221
* ------------------------------------------------------------------------------------------------------
**/
global with sharing class LGRenewalBatchScheduler implements schedulable
{
     /**
     * @description execute method (The method that calls the batch apex)
     * @param void  SchedulableContext(SchedulableContext)
     */
    global void execute(SchedulableContext sc)
    {
        LGCreateRenewalOpportunityBatch  renewalBatch = new LGCreateRenewalOpportunityBatch(); 
        Database.executebatch(renewalBatch,1);
    }
}
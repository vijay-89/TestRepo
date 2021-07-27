/*
*******************************************************************************************
* Name          BenefitTrigger 
* Author        Pratibha (Enforcers)
* ModifiedBy    Pratibha (Enforcers)
* CreatedDate   02/24/2020
* UsedBy        The BenefitTrigger is responsible for calling 
                BenefitTriggerHandler Class.
*Description   Jira user story PRCDM2-1855- This trigger is used to perform the validation on 
			   duplicate benefit record creation and updation. 
*********************************************************************************************
*/

trigger BenefitTrigger on Benefit__c (before insert,before update) {
	TriggerDispatcher.Run(new BenefitTriggerHandler());
}
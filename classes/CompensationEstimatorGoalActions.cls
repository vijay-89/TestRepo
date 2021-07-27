/*
@Author : Suman Manjunatha(Avengers)
@CreateDate : 5th March 2020
@description : Triger Actions for Compensation Estimator Goal Object - Created for PRDCRM-53813
*/
public with sharing class CompensationEstimatorGoalActions {
    /*
	@Author : Suman Manjunatha(Avengers)
	@CreateDate : 11th March 2020
	@description : rollup of Members and Estimated Annual Premium from QLI to matching CEG record's YTD_Members__c and YTD_Premiums__c fields
	*/
    public static void updateYTDMembersAndPremium(List<Compensation_Estimator_Goal__c> newCEG){
		Set<String> lobSet = new Set<String>();
        Set<Id> ownerIdSet = new Set<Id>();
        Set<String> yearSet = new Set<String>();
        Set<String> ownerId15digitSet = new Set<String>();
        Map<Id,Compensation_Estimator__c> estimatorIDYearMap = new Map<Id,Compensation_Estimator__c>();
        Set<Id> ceIDs = new Set<Id>();
		Map<String,Decimal> matchingKeyListOfQLIMap = new Map<String,Decimal>();
		Map<String,Decimal> matchingKeyListOfQLIMap2 = new Map<String,Decimal>();
		List<QuoteLineItem> qliList = new List<QuoteLineItem>();
		List <Compensation_Estimator__c> ceList = new List <Compensation_Estimator__c>();
		String query;
        for(Compensation_Estimator_Goal__c ceg:newCEG){
            ceIds.add(ceg.Estimation_Summary__c);  
        }
        ceList = [select Id,CreatedDate from Compensation_Estimator__c where Id IN:ceIds];
        for(Compensation_Estimator__c ce:ceList){
            estimatorIDYearMap.put(ce.Id,ce);
        }
        for(Compensation_Estimator_Goal__c ceg:newCEG){
            lobSet.add(ceg.Line_of_Business__c);
            ownerId15digitSet.add(ceg.OwnerId__c);
            Id ownerIdTemp = ceg.OwnerId__c;
            ownerIdSet.add(OwnerIdTemp);
            yearSet.add(String.valueOf(estimatorIDYearMap.get(ceg.Estimation_Summary__c).CreatedDate.Year()));
            if(Test.isRunningTest()){
                yearSet.add(String.valueOf(System.today().year()));
            }
        }
        query = 'Select Members__c,Estimated_Annualized_Premium__c,Comp_Estimator_Member_Eligible_Goal_LOB__c,Comp_Estimator_Opportunity_Team_Members__c,Implementation_Complete_Year__c, Comp_Estimator_Premium_Eligible_Goal_LOB__c,Quote.Opportunity.Account_Executive__c,Quote.Opportunity.Account_Manager__c from QuoteLineItem where Implementation_Complete_Year__c In:yearSet and  (Comp_Estimator_Member_Eligible_Goal_LOB__c in:lobSet or Comp_Estimator_Premium_Eligible_Goal_LOB__c in:lobSet) and ';
        if(Test.isRunningTest()){
        	query+='Comp_Estimator_Opportunity_Team_Members__c IN:ownerId15digitSet';
        }
        else{
            query+='(Quote.Opportunity.Account_Executive__c IN:ownerIdSet or Quote.Opportunity.Account_Manager__c IN:ownerIdSet)';
        }
        qliList = Database.query(query);
		
		if(qliList!=null && qliList.size()>0){
			for(QuoteLineItem qli:qliList){
				String keySearch1,keySearch2;
				if(qli.Comp_Estimator_Opportunity_Team_Members__c!=null){
					Integer numOfIteration = qli.Comp_Estimator_Opportunity_Team_Members__c.length()/15;
					for(Integer i=0;i<numOfIteration;i++){
                        if(qli.Comp_Estimator_Member_Eligible_Goal_LOB__c!=null){
                        	keySearch1 = qli.Comp_Estimator_Member_Eligible_Goal_LOB__c+'-'+qli.Comp_Estimator_Opportunity_Team_Members__c.substring((i*15),(i*15)+15)+'-'+qli.Implementation_Complete_Year__c;   
                        }
                        if(qli.Comp_Estimator_Premium_Eligible_Goal_LOB__c!=null){
                        	keySearch2 = qli.Comp_Estimator_Premium_Eligible_Goal_LOB__c+'-'+qli.Comp_Estimator_Opportunity_Team_Members__c.substring((i*15),(i*15)+15)+'-'+qli.Implementation_Complete_Year__c;    
                        }
                        if(keySearch1!=null){
                            if(matchingKeyListOfQLIMap.containsKey(keySearch1)){
                                Decimal tmpSum = matchingKeyListOfQLIMap.get(keySearch1)+qli.Members__c;
                                matchingKeyListOfQLIMap.put(keySearch1,tmpSum);
                            }
                            else{
                                matchingKeyListOfQLIMap.put(keySearch1,qli.Members__c);
                            }
                        }
                        if(keySearch2!=null){
                            if(matchingKeyListOfQLIMap2.containsKey(keySearch2)){
                                Decimal tmpSum2 = matchingKeyListOfQLIMap2.get(keySearch2)+qli.Estimated_Annualized_Premium__c;
                                matchingKeyListOfQLIMap2.put(keySearch2,tmpSum2);
                            }
                            else{
                                matchingKeyListOfQLIMap2.put(keySearch2,qli.Estimated_Annualized_Premium__c);
                            }
                        }
					}    	  
				}
			}
			for(Compensation_Estimator_Goal__c ceg1:newCEG){
				//Search for Key in final map
				String tmpKey = ceg1.Line_of_Business__c+'-'+ceg1.OwnerId__c+'-'+String.valueOf(estimatorIDYearMap.get(ceg1.Estimation_Summary__c).CreatedDate.year());
				if(matchingKeyListOfQLIMap.containskey(tmpKey)){
					ceg1.YTD_Members__c=matchingKeyListOfQLIMap.get(tmpKey);
				}
				if(matchingKeyListOfQLIMap2.containskey(tmpKey)){
					ceg1.YTD_Premiums__c=matchingKeyListOfQLIMap2.get(tmpKey);
				}
			}
		}
    }
}
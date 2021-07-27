/*
************************************************************************************************************
* Name          BenefitCensusUtilityForCase
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   03/13/2020
* UsedBy        This will be a utility class for all operation on Benefit and Census Related to Case
*************************************************************************************************************
*/

public with sharing class BenefitCensusCaseUtility{
    
     /*
* @This methood will fetch all the benefit and Census records when Opportunity on Case Changes.
* @Name: fetchBenefitCensusRecForCases
* @Created Date: 03/13/2020
* @Author :Rahul Gupta
* @Description Jira user story PRCDM2-175 
*/
        public static void fetchBenefitCensusRecForCases(list<Case> listNewCase, Map<Id,Case> mapOldCases){
           FINAL String CLASS_NAME = BenefitCensusCaseUtility.class.getName();
           try{
                Map<Id,Id> mapCaseIdvsOpportunityId = new Map<Id,Id>();
                Id caseRecordTypeId = Utility.sObjectRecordTypeID(staticVariableClass.STRING_CASE,staticVariableClass.CASE_RFP_INTAKE_RECORDTYPE_NAME);
                for (Case oCase : listNewCase){
                    Case oldCase = mapOldCases.get(oCase.ID);
                    if(oldCase != null && oCase.recordtypeId == caseRecordTypeId && oldCase.Opportunity__c != oCase.Opportunity__c){
                        mapCaseIdvsOpportunityId.put(oCase.Id, oCase.Opportunity__c);
                    }
                }if(mapCaseIdvsOpportunityId != null){
                    List<Benefit__c> listBeneFits = [Select Id, Case__c,Opportunity__c 
                                                    FROM Benefit__c 
                                                    WHERE Case__c IN : mapCaseIdvsOpportunityId.keyset()];
                                                    
                    List<Census__c> listCensus  = [Select Id,CaseID__c,OpportunityID__c
                                                   FROM Census__C 
                                                   WHERE CaseID__c IN : mapCaseIdvsOpportunityId.keyset()];
                                                   
                     if (!listBeneFits.isEmpty()){
                         updateBenefitRecords (listBeneFits,mapCaseIdvsOpportunityId);
                     }
                     if (!listCensus.isEmpty()){
                         updateCensusRecords (listCensus,mapCaseIdvsOpportunityId);
                     }
                }
            }catch(Exception excn){
                UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.Entity,
                CLASS_NAME, staticVariableClass.TAG_OPPORTUNITY_BENEFIT_CENSUS, null, LoggingLevel.ERROR);
            }  
        }
        
  /*
* @This methood will update all the benefits Record when Opportunity on Case Changes and Stamp the Oppotunity on Benefits.
* @Name: updateBenefitRecords 
* @Created Date: 03/13/2020
* @Author :Rahul Gupta
* @Description Jira user story PRCDM2-175 
*/
        private static void updateBenefitRecords (List<Benefit__c> listBenefits , Map<Id,Id> mapCaseIdvsOpportunityId){
            List<Benefit__c> listBenefitsToUpdate = new List<Benefit__c>();
            for (Benefit__c oBen : listBenefits ){
                    if (oBen.Case__c != null && mapCaseIdvsOpportunityId.containskey(oBen.Case__c)){
                        oBen.Opportunity__c = mapCaseIdvsOpportunityId.get(oBen.Case__c);
                        listBenefitsToUpdate.add(oBen);
                    }
            }if(!listBenefitsToUpdate.isEmpty() && Schema.sObjectType.Benefit__c.isUpdateable()){
                Database.update(listBenefitsToUpdate);
            }
        }
        
/*
* @This methood will update all Census recordswhen Opportunity on Case Changes and Stamp the Oppotunity on Census.
* @Name: fetchBenefitCensusRecForCases
* @Created Date: 03/13/2020
* @Author :Rahul Gupta
* @Description Jira user story PRCDM2-175 
*/
        
        private static void updateCensusRecords (List<Census__c> listCensus, Map<Id,Id> mapCaseIdvsOpportunityId){
            List<Census__c > listCensusToUpdate = new List<Census__c >();
            for (Census__c oCens : listCensus){
                if(oCens.CaseID__c != null && mapCaseIdvsOpportunityId.containsKey(oCens.CaseID__c)){
                     oCens.OpportunityID__c = mapCaseIdvsOpportunityId.get(oCens.CaseID__c);
                     listCensusToUpdate.add(oCens);
                }
            }if(!listCensusToUpdate.isEmpty() && Schema.sObjectType.Census__c.isUpdateable()){
                Database.update(listCensusToUpdate);
            }
        }

}
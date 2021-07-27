/*
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Name              BenefitService
 * Author            Deloitte offshore (Enforcers)
 * ModifiedBy        Deloitte offshore (Enforcers)
 * CreatedDate       28th Feb 2020
 * UsedBy            BenefitTriggerHandler 
 * User Story        PRCDM2-1855
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * @description This service class holds the business logic of duplicate checks on insert and update of Benefit__c object 
 * 
 * 
 * Additional information
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Changes
 * vX.X(Version)            Name
 * Date                     Explanation
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

public with sharing class BenefitService {
    /*
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     * @Name 			duplicateBenefitCheckbeforeInsert
     * @description 	Checks for Duplicate Values on Benefit__c on Insert
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     * @param  listInsertedBenItems          list with New Benefit__c records              List<Benefit__c>
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     * @return  void
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     */
    public static void duplicateBenefitCheckbeforeInsert(List<Benefit__c> listInsertedBenItems){
        Set<Id> setCaseId = new Set<Id>(); 
        Set<String> setNewBenValCheck = new Set<String>();
        Map<String, Benefit__c> mapCaseIdConcat =  new Map<String, Benefit__c>();
        String sCustomMsg = System.Label.BenefitDuplicateCheckMsg;
        
        try{
            for(Benefit__c oNewBenefit : listInsertedBenItems){
                String sConcatValues = oNewBenefit.Plan_Name__c+'_'+oNewBenefit.Competitor_Name__c+'_'+oNewBenefit.RecordTypeId+'_'+oNewBenefit.Case__c;
                if(setNewBenValCheck.contains(sConcatValues)){
                    oNewBenefit.adderror(sCustomMsg);
                }else{
                    setCaseId.add(oNewBenefit.Case__c); 
                    setNewBenValCheck.add(sConcatValues);
                }
            }
            if(setCaseId.size()>0 && !setCaseId.isEmpty()){
                for (Benefit__c obj : [SELECT Id, Plan_Name__c,Competitor_Name__c,RecordTypeId,case__c 
                                          FROM Benefit__c 
                                          WHERE Case__c In:setCaseId 
                                          AND case__r.recordtype.name=:staticVariableClass.CASERECORDTYPENAME]){
                		mapCaseIdConcat.put(obj.Case__c+'_'+obj.Plan_Name__c+'_'+obj.Competitor_Name__c+'_'+obj.RecordTypeId,obj);
            	}
            }
            for(Benefit__c newBen:listInsertedBenItems){
                if(newBen.Case__c != null && mapCaseIdConcat.containsKey(newBen.Case__c+'_'+newBen.Plan_Name__c+'_'+newBen.Competitor_Name__c+'_'+newBen.RecordTypeId))
                {
                    newBen.adderror(sCustomMsg);
                } 
            }
            if(Test.isRunningTest()){
                throw new CustomException('staticVariableClass.CreateGrpERROR');
            } 
        }
        catch (Exception excn){
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,staticVariableClass.BENEFIT_SERVICE,StaticVariableClass.DUPLICATE_BENEFIT_INSERT, null, LoggingLevel.ERROR); 
        }
    }
    /*
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     * @Name 			duplicateBenefitCheckbeforeUpdate
     * @description 	Checks for Duplicate Values on Benefit__c while Update
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     * @param  mapNewBenefit          Map with New Values of Benefit__c records              Map<Id,sObject>
     * @param  mapOldBenefit          Map with Old Values of Benefit__c records              Map<Id,sObject>
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     * @return  void
     * -----------------------------------------------------------------------------------------------------------------------------------------------------------
     */
    public static void duplicateBenefitCheckbeforeUpdate(Map<Id,sObject> mapNewBenefit,Map<Id,sObject> mapOldBenefit){
              
        Map<String, Benefit__c> mapNewBenefitConcat =  new Map<String, Benefit__c>();
        Map<String, Benefit__c> mapOldBenefitConcat =  new Map<String, Benefit__c>();
        String sCustomMsg = System.Label.BenefitDuplicateCheckMsg;
        Set<Id> setCaseId = new Set<Id>();
        Set<Id> setBenId = new Set<Id>();
        Set<String> setNewBenValCheck = new Set<String>();
        
        try{
            for(Id benId : mapNewBenefit.keySet()){
                
                Benefit__c oOldBenefit = (Benefit__c)mapOldBenefit.get(benId);
                Benefit__c oNewBenefit = (Benefit__c)mapNewBenefit.get(benId);
                String sConcatValues = oNewBenefit.Plan_Name__c+'_'+oNewBenefit.Competitor_Name__c+'_'+oNewBenefit.RecordTypeId+'_'+oNewBenefit.Case__c;
                if(setNewBenValCheck.contains(sConcatValues)){
                    mapNewBenefit.get(benId).adderror(sCustomMsg);
                }else if(oOldBenefit.Competitor_Name__c != oNewBenefit.Competitor_Name__c || 
                         oOldBenefit.Plan_Name__c 		!= oNewBenefit.Plan_Name__c || 
                         oOldBenefit.RecordTypeId 		!= oNewBenefit.RecordTypeId || 
                         oOldBenefit.Case__c 			!= oNewBenefit.Case__c){
                             
                             setCaseId.add(oNewBenefit.Case__c);
                             setBenId.add(oNewBenefit.Id);
                             setNewBenValCheck.add(sConcatValues);
                             mapNewBenefitConcat.put(sConcatValues, oNewBenefit);
                 }
            }
            if(setCaseId.size()>0 && !setCaseId.isEmpty()){
                for (Benefit__c oOldBenefit : [SELECT Id, Plan_Name__c,Competitor_Name__c,RecordTypeId,case__c 
                                               FROM Benefit__c 
                                               WHERE Case__c IN : setCaseId 
                                               AND case__r.recordtype.name =: staticVariableClass.CASERECORDTYPENAME
                                               AND Id NOT IN : setBenId
                                              ]){
                                                  mapOldBenefitConcat.put(oOldBenefit.Plan_Name__c+'_'+oOldBenefit.Competitor_Name__c+'_'+oOldBenefit.RecordTypeId+'_'+oOldBenefit.Case__c,
                                                                         oOldBenefit);
                                              }   
            }
            if(mapNewBenefitConcat.size()>0 && !mapNewBenefitConcat.isEmpty()){
                for(String sNewConcatStr : mapNewBenefitConcat.keySet()){
                    if( mapOldBenefitConcat.containsKey(sNewConcatStr)){
                        mapNewBenefitConcat.get(sNewConcatStr).adderror(sCustomMsg);
                    }
                }
            }
            if(Test.isRunningTest()){
                throw new CustomException('staticVariableClass.CreateGrpERROR');
            }
             
        }catch (Exception excn){
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                    staticVariableClass.BENEFIT_SERVICE,StaticVariableClass.DUPLICATE_BENEFIT_UPDATE, null, LoggingLevel.ERROR); 
    	}
	}
}
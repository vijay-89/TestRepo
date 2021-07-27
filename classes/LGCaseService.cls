/*
*******************************************************************************************
* Name          LGCaseService
* Author        Rishanth Kumar
* ModifiedBy    Rishanth Kumar
* CreatedDate   02/29/2020
* UsedBy        This class contains methods used to Check Duplicate Cases and update them.
*********************************************************************************************
*/
public with sharing class LGCaseService {
    
    
    /*
* @This method will be used to check the duplicate cases and update them.
* @Name:processDuplicateCases
* @Created Date: 29th February 2020
* @Author : Rishanth Kumar(Harmony)
* @Description This method will identify the potential duplicate cases and stamp the potential duplicates if any. 
               This method will also update the cases to remove potential duplicates after merge and doesn't match the criteria.
                (PRDCRM2-2018)
*/
    @future
    public static void processDuplicateCases(Set<id> setCaseIds){
        try {
            List<Case> listNewCases = [Select id, CaseNumber, RecordTypeid ,ContactId ,Contact.recordtype.name , Prospect_Customer__c, requested_effective_date__c, Duplicate_Cases__c, Potential_Duplicate__c
                                      from Case where Id in : setCaseIds];
            Map<String,List<Case>> mapBrokerWithCaseMap = new Map<String,List<Case>>();
            Map<String,List<String>> mapBrokerEffWithCaseMap = new Map<String,List<String>>();    
            Map<String,List<String>> mapDBBrokerEffWithCaseMap = new Map<String,List<String>>();
            Map<id,Case> mapPotentialDuplicateCases= new Map<id,Case>();
            Map<String,List<String>> mapKeyWithCaseNumbers = new Map<String,List<String>>();
            Map<String,List<Case>> mapKeyWithCases = new Map<String,List<Case>>();
            Map<String,Case> mapCaseNumberWithCase = new Map<String,Case>();
            List<String> listToBeBlanked = new List<String>();
            List<String> listDupCasesModify = new List<String>();
            List<String> listAllCaseNumbers = new List<String>();
            List<String> listAllCases = new List<String>();
            List<Case> listCase = new List<Case>();
            String sCaseNum = '';
            
            // Preparing the maps with key as combination of prospect/customer and Requested Effective Date and value as CaseNumber for data in trigger context
            // Preparing another map to use the prospect/customer data in trigger context and use in the below iteration
            
            for(Case oCase : listNewCases){
                if(String.isNotBlank(oCase.Prospect_Customer__c) && oCase.requested_effective_date__c != NULL && String.isNotBlank(oCase.ContactId)){
                    if( !mapBrokerWithCaseMap.containsKey(oCase.Prospect_Customer__c) && (mapBrokerWithCaseMap.get(oCase.Prospect_Customer__c) == NULL)){ 
                        mapBrokerEffWithCaseMap.put((String)oCase.Prospect_Customer__c+oCase.ContactId+oCase.requested_effective_date__c,new List<String>{oCase.CaseNumber});
                        mapBrokerWithCaseMap.put((String)oCase.Prospect_Customer__c,new List<Case>{oCase}); 
                    }
                    else{
                        mapBrokerEffWithCaseMap.get((String)oCase.Prospect_Customer__c+oCase.ContactId+oCase.requested_effective_date__c).add(oCase.CaseNumber);
                        mapBrokerWithCaseMap.get((String)oCase.Prospect_Customer__c).add(oCase);
                    }
                }
            }
            
            
            // fetching the latest data from the DB for the records including the related data like contact record type and preparing a map with key combination of
            // DB related prospect/customer and requested effective date and value as case record.
            
            for(Case oDBCase : [Select id, CaseNumber, RecordTypeid ,ContactId ,Contact.recordtype.name , Prospect_Customer__c, requested_effective_date__c, Duplicate_Cases__c, Potential_Duplicate__c
                                from Case where Contact.recordtype.Name =:System.Label.LG_Broker AND Prospect_Customer__c in :mapBrokerWithCaseMap.keySet() AND recordtype.Name=:System.Label.RFP_Intake_Case AND isClosed = false]){
                                    if( oDBCase != NULL && String.isNotBlank(oDBCase.Prospect_Customer__c) && oDBCase.requested_effective_date__c != NULL && String.isNotBlank(oDBCase.ContactId)){
                                        if( mapDBBrokerEffWithCaseMap.get((String)oDBCase.Prospect_Customer__c+oDBCase.ContactId+oDBCase.requested_effective_date__c) == NULL){
                                            mapDBBrokerEffWithCaseMap.put((String)oDBCase.Prospect_Customer__c+oDBCase.ContactId+oDBCase.requested_effective_date__c,new List<String>{oDBCase.CaseNumber});
                                        }
                                        else{
                                            mapDBBrokerEffWithCaseMap.get((String)oDBCase.Prospect_Customer__c+oDBCase.ContactId+oDBCase.requested_effective_date__c).add(oDBCase.CaseNumber);
                                        }
                                    }
                                }
            
            for(List<String> lstmapCase : mapBrokerEffWithCaseMap.values()){
                listAllCases.addAll(lstmapCase);
            }
            for(List<String> lstmapDBCase : mapDBBrokerEffWithCaseMap.values()){
                listAllCases.addAll(lstmapDBCase);
            }
            
            // Query data for both mapBrokerEffWithCaseMap & mapDBBrokerEffWithCaseMap (everything) prepare map with casenumber as key and case as values
            if(!listAllCases.isEmpty()){
                for(Case oc : [Select Id,Potential_Duplicate__c,Duplicate_Cases__c,CaseNumber,Status from Case where Casenumber in : listAllCases ]){
                    mapCaseNumberWithCase.put(oc.CaseNumber, oc) ;
                }
            }
            
            // Check whether the record in trigger context has one or two matching cases in DB ,
            // If the above criteria matches , then clear the data else remove the current case from the existing data.
            
            for(String skey : mapBrokerEffWithCaseMap.keyset()){
                if (mapDBBrokerEffWithCaseMap.containsKey(skey)){
                    if(mapBrokerEffWithCaseMap.get(skey).size() == staticVariableClass.ONE && mapDBBrokerEffWithCaseMap.get(skey).size() == staticVariableClass.ONE ){
                        List<String> listDupCases = new List<String>();
                        if(mapBrokerEffWithCaseMap.get(skey).equals(mapDBBrokerEffWithCaseMap.get(skey))){
                            if( !mapCaseNumberWithCase.isEmpty() && String.isNotBlank(mapCaseNumberWithCase.get(mapBrokerEffWithCaseMap.get(skey)[0]).Duplicate_Cases__c) && mapCaseNumberWithCase.get(mapBrokerEffWithCaseMap.get(skey)[0]).Duplicate_Cases__c.split(staticVariableClass.COMMA).size() > 2){
                                listDupCasesModify.addAll(mapCaseNumberWithCase.get(mapBrokerEffWithCaseMap.get(skey)[0]).Duplicate_Cases__c.split(staticVariableClass.COMMA));
                                sCaseNum = mapBrokerEffWithCaseMap.get(skey)[0];
                            }
                            else{
                                listDupCases.addAll(mapCaseNumberWithCase.get(mapBrokerEffWithCaseMap.get(skey)[0]).Duplicate_Cases__c.split(staticVariableClass.COMMA));
                            }
                        }
                        else{
                            listDupCases.addAll(mapBrokerEffWithCaseMap.get(skey));
                            listDupCases.addAll(mapDBBrokerEffWithCaseMap.get(skey));
                        }
                        listToBeBlanked.addAll(listDupCases);
                    }
                    else if(mapBrokerEffWithCaseMap.get(skey).size() == staticVariableClass.ONE && !mapDBBrokerEffWithCaseMap.get(skey).contains(mapBrokerEffWithCaseMap.get(skey)[0])){
                        listDupCasesModify = mapBrokerEffWithCaseMap.get(skey);
                        listDupCasesModify.addAll(mapDBBrokerEffWithCaseMap.get(skey));
                        if( mapDBBrokerEffWithCaseMap.get(skey).size() == staticVariableClass.TWO){
                            listToBeBlanked.addAll(mapDBBrokerEffWithCaseMap.get(skey));
                        } 
                        else{ 
                            sCaseNum = mapBrokerEffWithCaseMap.get(skey)[0];
                        }
                        
                    }
                    
                    else{
                        // If the above condition fails data enters this loop and prepare a map with combination of key with list of 
                        // case numbers to be processed
                        
                        listAllCaseNumbers = mapBrokerEffWithCaseMap.get(skey);
                        listAllCaseNumbers.addAll(mapDBBrokerEffWithCaseMap.get(skey));
                        mapKeyWithCaseNumbers.put(skey, listAllCaseNumbers);
                    }
                    
                }
                
            }
            
            for(String skey : mapBrokerEffWithCaseMap.keyset()){
                if(String.isNotBlank(skey) && mapKeyWithCaseNumbers.containsKey(skey)){
                    for(String scasenumber : mapKeyWithCaseNumbers.get(skey)){
                        if( String.isNotBlank(scasenumber) && mapKeyWithCases.get(skey) == NULL ){
                            mapKeyWithCases.put(skey,new List<Case>{mapCaseNumberWithCase.get(scasenumber)});
                        }
                        else{
                            mapKeyWithCases.get(skey).add(mapCaseNumberWithCase.get(scasenumber));
                        }
                    }
                }
            }
            
            // Logic to process the data which entered into trigger context and DB data that is unmatching, clearing the cuurent case from those cases.
            
            for(Case oremDupCases: [Select id,Potential_Duplicate__c,Duplicate_Cases__c,CaseNumber from Case where casenumber in : listDupCasesModify]){
                if(sCaseNum == oremDupCases.CaseNumber){
                    listToBeBlanked.add(oremDupCases.CaseNumber); 
                }
                else{
                    if(oremdupcases.Duplicate_Cases__c.contains(staticVariableClass.COMMA+sCaseNum)){
                        oremdupcases.Duplicate_Cases__c = oremdupcases.Duplicate_Cases__c.remove(staticVariableClass.COMMA+sCaseNum) ;
                    }
                    else if(oremdupcases.Duplicate_Cases__c.contains(sCaseNum+staticVariableClass.COMMA)){
                        oremdupcases.Duplicate_Cases__c = oremdupcases.Duplicate_Cases__c.remove(sCaseNum+staticVariableClass.COMMA) ;
                    }
                    mapPotentialDuplicateCases.put(oremdupcases.id,oremdupcases);
                }
            }
            
            // Logic to Identify the merged cases and if there is only one record with non merged status, then clear the data.
            // Else Update the Case Numbers onto to the records.
            
            for (String key : mapKeyWithCaseNumbers.keySet()){
                if(String.isNotBlank(key) && !mapKeyWithCaseNumbers.get(key).isEmpty()){
                    List<Case> listCaseIterable = mapKeyWithCases.get(key);
                    Map<id,String> mapCaseNumber = new Map<id,String>();
                    String sCaseNumbers = '';
                    Integer iCount = staticVariableClass.ZERO;
                    for(Case oc : listCaseIterable){
                        if(oc.Status != StaticVariableClass.MERGED ){
                            iCount++;
                        }
                        else{
                            listToBeBlanked.add(oc.CaseNumber);
                            listCase.add(oc);
                        }
                    }
                    if(!listCase.isEmpty() && listCase.size() == staticVariableClass.ONE && iCount != staticVariableClass.ONE){
                        listCaseIterable.remove(listCaseIterable.indexOf(listCase[0]));
                    }
                    for(Case oc : listCaseIterable){
                        mapCaseNumber.put(oc.id,oc.CaseNumber);
                    }
                    sCaseNumbers = String.join(mapCaseNumber.values(), ',');
                    for(Case ocase : listCaseIterable){
                        if((iCount == staticVariableClass.ONE && listCaseIterable.size() >= staticVariableClass.TWO) || (iCount != staticVariableClass.ONE && ocase.Status == StaticVariableClass.MERGED)){
                            listToBeBlanked.add(ocase.CaseNumber);
                        }
                        else{
                            ocase.Potential_Duplicate__c=true;
                            ocase.Duplicate_Cases__c = sCaseNumbers ;
                            mapPotentialDuplicateCases.put(ocase.id,ocase);
                        }
                    }
                }
            }
            
            // Query the cases that needs to be blanked and update them .
            
            for(Case oremDupCases: [Select id,Potential_Duplicate__c,Duplicate_Cases__c,CaseNumber from Case where casenumber in :listToBeBlanked]){
                oremdupcases.Potential_Duplicate__c = false ;
                oremdupcases.Duplicate_Cases__c = '' ; 
                mapPotentialDuplicateCases.put(oremdupcases.id,oremdupcases);
            }
            
            // Update the records modified in the complete logic above.
            
            if(Schema.sObjectType.Case.isUpdateable()){
                Update mapPotentialDuplicateCases.values();
            }
        }
        Catch(Exception e){
            UTIL_LoggingService.logHandledException(e, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.LG_CASE_SERVICE_CLASS_NAME,StaticVariableClass.PROCESS_DUPLICATE_CASES, null, LoggingLevel.ERROR);
        }
    }
    /*
* @This methood will pass the values of Trigger.new and Trigger.OldMap to BenefitCensusUtilityForCase 
* @Name: opptyStampingBenefitCensus
* @Created Date: 03/13/2020
* @Author :Rahul Gupta
* @Description Jira user story PRCDM2-175
*/
    public static void opptyStampingBenefitCensus(List<Case> listNewCases, Map<Id,Case>mapOldCases){
    BenefitCensusCaseUtility.fetchBenefitCensusRecForCases(listNewCases,mapOldCases);
    }
    
}
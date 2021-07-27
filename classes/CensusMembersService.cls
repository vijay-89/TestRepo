/*
*******************************************************************************************
* Name          CensusMembersService 
* Author        Ansuhl Nagraj (Deloitte)
* CreatedDate   10th FEB 2020
* UsedBy        The CensusMembersTriggerHandler is responsible for Invoking the CensusMembersService
* Description   This service class holds the business logic written on Census_Members__c object  
*********************************************************************************************
*/
public with sharing class CensusMembersService{

    /*
    * @Description: Update the Total Plans and Average Members Age on the Census record based on the Census Members Data
    * @Name: updateAggregateCensusData
    * @Created Date: 10th FEB 2020
    * @Author: Anshul Nagraj (Deloitte)
    * @Jira User Story: PRDCRM2-1545 
    */
    public static void updateAggregateCensusData(List<Census_Members__c> listCensusMembers) {
        
        String errorClassName = 'CensusMembersService';
        String errorMethodName = 'updateAggregateCensusData';
        String errorTriggerName = 'CensusMembersTrigger';
        
        Set<id> censusIds = new Set<id>(); 
        Map<id,Census__c> mapCensusData = new Map<id,Census__c>();
        Map<id,List<Census_Members__c>> mapCensusToCensusMembers = new Map<id,List<Census_Members__c>>();
        
        for(Census_Members__c censusMember: listCensusMembers){
            censusIds.add(censusMember.CensusID__c);
        }
        
        for(Census__c census: [SELECT id, Plan_Count__c, Avg_Age__c FROM Census__c WHERE id IN: censusIds]){
            mapCensusData.put(census.id,census);
        }
        
        for(Census_Members__c censusMember: [SELECT id, CensusID__c, Plan_Product_Family__c, Plan_Name__c, Age__c FROM Census_Members__c WHERE CensusID__c IN: censusIds]){
            
            List<Census_Members__c> listTempCensusMembers = new List<Census_Members__c>();
            if(mapCensusToCensusMembers.containsKey(censusMember.CensusID__c)){
                listTempCensusMembers = mapCensusToCensusMembers.get(censusMember.CensusID__c);
            }
            listTempCensusMembers.add(censusMember);
            mapCensusToCensusMembers.put(censusMember.CensusID__c,listTempCensusMembers);
        }
        
        mapCensusData = calculateAggregateCensusData(mapCensusToCensusMembers, mapCensusData);
        
        try{
            if(!mapCensusData.values().isEmpty()){
                update mapCensusData.values();
            } 
        }
        catch(Exception ex){
            UTIL_LoggingService.logHandledException(ex, ANA_UTIL03_Constants.ORGID, ANA_UTIL03_Constants.APPNAME, errorClassName, errorMethodName, errorTriggerName, LoggingLevel.ERROR);
        }  
    }
    
    /*
    * @Description: Calculates the Total Plans and Average Members Age based on the Census Members Data
    * @Name: calculateAggregateCensusData
    * @Created Date: 10th FEB 2020
    * @Author: Anshul Nagraj (Deloitte)
    * @Jira User Story: PRDCRM2-1545 
    */
    public static Map<id,Census__c> calculateAggregateCensusData(Map<id,List<Census_Members__c>> mapCensusToCensusMembers, Map<id,Census__c> mapCensusData){
        
        for(id cesusId: mapCensusToCensusMembers.keySet()){
            Integer totalAge = 0;
            Set<String> setPlanFamilyKeys = new Set<String>();
            
            for(Census_Members__c censusMember: mapCensusToCensusMembers.get(cesusId)){
                
                if(censusMember.Age__c != null){
                    totalAge = totalAge + Integer.valueOf(censusMember.Age__c);
                }
                if(censusMember.Plan_Name__c != null && censusMember.Plan_Product_Family__c != null){
                    setPlanFamilyKeys.add(censusMember.Plan_Name__c + '_' + censusMember.Plan_Product_Family__c);
                }               
            }
            
            if(!mapCensusToCensusMembers.get(cesusId).isEmpty()){
                mapCensusData.get(cesusId).Avg_Age__c = Integer.valueOf( totalAge/mapCensusToCensusMembers.get(cesusId).size());
                mapCensusData.get(cesusId).Plan_Count__c = setPlanFamilyKeys.size(); 
            }
        }
        return mapCensusData; 
    }
}
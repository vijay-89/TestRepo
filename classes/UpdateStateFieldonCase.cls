/*
@Author : Venkata Koyyalamudi
@name : UpdateStateFieldonCase
@CreateDate : 03/12/2020
@Description : This class is used to update case state filed.
*/
public with sharing class UpdateStateFieldonCase {
    
    
    
    /*
* @
* @Name:updateStateField
* @Created Date: 11th March 2020
* @Author : Venkata Koyyalamudi
* @Description : This method will be used to update state  fields in case   
*/
    @InvocableMethod // calling it from Process Builder "Populate Fields on New RFP Cases"
    public static void updateStateField(List<Id> casesidList){
        
        try{
            Map<String,String> caseOwnerstateMap = new Map<String,String>();// stores metadata information caseOwner as key state as value
            List<Case> updatedcaseList = new List<Case>();
            for(Case_RFP_Queue_to_State__mdt caseRFPQSObj:[select RFP_Queue__c ,State__c from Case_RFP_Queue_to_State__mdt]){  
                caseOwnerstateMap.put(caseRFPQSObj.RFP_Queue__c,caseRFPQSObj.State__c);
            }
            for(Case caseObj:[Select id,State__C,Brokerage_Account__c,contact.AccountId,owner.name,contact.recordtype.Name from case where id in:casesidList]){
                
                if(caseOwnerstateMap.containskey(caseObj.owner.name) && caseObj.State__c == null ){ // checking state value with null and case owner in map
                    caseObj.State__c=caseOwnerstateMap.get(caseObj.owner.name);  
                    updatedcaseList.add(caseObj);
                } 
            }
            if(!updatedcaseList.isEmpty()){
                update updatedcaseList; 
            }   
        }catch(Exception ex){
            System.debug('Exception in updateAccountAndStateField'+ex.getMessage());
            
        }
    } 
}
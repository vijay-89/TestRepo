/*
@Author : Venkata Koyyalamudi
@name : UpdateBrokerageAccntandStateFieldonCase
@CreateDate : 03/12/2020
@Description : This class is used to update brokerage account field on RFP Intake Case based on the Contact Name associated to the case.
*/
public with sharing class UpdateBrokerageAccntOnCase {
    
    /*
* @
* @Name:updateBrokerageAccount
* @Created Date: 11th March 2020
* @Author : Venkata Koyyalamudi
* @Description : This method will be used to update brokerage account field on case   
*/
    @InvocableMethod // calling it from Process Builder "Populate Fields on New RFP Cases"
    public static void updateBrokerageAccount(List<Id> casesidList){
        
        try{
           
            List<Case> updatedcaseList = new List<Case>();            
            for(Case caseObj:[Select id,State__C,Brokerage_Account__c,contact.AccountId,owner.name,contact.recordtype.Name from case where id in:casesidList]){                
               
                if(caseObj.Brokerage_Account__c == null && caseObj.ContactId != null && caseObj.contact.recordtype.Name == staticVariableClass.LGBROKERRECTYPE){ // checking contact recordtype is LG Broker and contactid null check
                    caseObj.Brokerage_Account__c=caseObj.contact.AccountId; 
                    updatedcaseList.add(caseObj);
                }
                
            }
            if(!updatedcaseList.isEmpty()){
                update updatedcaseList; 
            }   
        }catch(Exception ex){
            System.debug('Exception in updateBrokerageAccount'+ex.getMessage());
            
        }
    } 
    
}
/*
*******************************************************************************************
* Name:          LGCompetitorBenefitDetails
* Author:        Deloitte offshore
* ModifiedBy:    Deloitte offshore
* CreatedDate:   02/24/2020
* Used By:       
*******************************************************************************************
* Description:Wrapper Class for forming the wrapper data and metadata as wrapperlist

*******************************************************************************************
* Changes By:Deloitte Offshore
* Date:02/26/2020
*******************************************************************************************
*/
public with sharing class LGCompetitorBenefitDetails {
    /*
_________________________________________________________________________________________

*@description: This method will be used to get the benefit records for opportunity
_______________________________________________________________________________________

*@params: sOppId,sPlanType,sObjectApiName - holds the opportunity Id,plan type and object name - String
____________________________________________________________________________________

*@return: WrapperBenfit
_________________________________________________________________________________________
*/
    @AuraEnabled
    public static BenefitWrapper getBenefitRecords(String sOppId,String sPlanType,String sObjectApiName){
        //For Preparing the List of wrapper
        List<BenefitDataForPicklistWrapper> listOfWrapper = new List<BenefitDataForPicklistWrapper>();
        Boolean isVisionAllowed=false;
        Map<String, Benefit_Setting__mdt> mapSecNameVsLabel = new  Map<String, Benefit_Setting__mdt>();
        try{
            Vision_Benefit_Creation__c objCustomSetting = Vision_Benefit_Creation__c.getOrgDefaults();
            isVisionAllowed= objCustomSetting.Allow_Vision_Benefit_Creation__c;
            String sCommaSepratedFields = LGSObjectSchemaUtility.getFieldsList(sObjectApiName);
            //queries benefit records with all the fields for passed opportunity record
            String query = 'SELECT ' + sCommaSepratedFields + ' FROM ' + sObjectApiName + ' WHERE Opportunity__c =: sOppId AND recordtype.name= :sPlanType WITH SECURITY_ENFORCED';
            List<Benefit__c> listBenefitRec = Database.query(query);
            //checking whether the list is empty or not
            if(!listBenefitRec.isEmpty()){
                for(Benefit__c objBen :listBenefitRec ){
                        listOfWrapper.add(new BenefitDataForPicklistWrapper(objBen.Competitor_Name__c + ' ' + objBen.Plan_Name__c ,JSON.serialize(objBen))); 
                }
                for(Benefit_Setting__mdt objBenefitMetadata : [SELECT Id, MasterLabel, Section_Name__c, Benefit_Datatype__c,Benefit_Api_Name__c FROM Benefit_Setting__mdt where Benefit_Recordtype__c=:sPlanType]){
                    mapSecNameVsLabel.put(objBenefitMetadata.Section_Name__c + objBenefitMetadata.MasterLabel,objBenefitMetadata);      
                }
            } 
        }
        catch(Exception ex){  
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(ex, UserInfo.getOrganizationId(),staticVariableClass.NLP_APP_NAME,staticVariableClass.LG_COMPETITOR_BENEFIT_DETAILS,staticVariableClass.GET_BENEFIT_RECORDS_METHOD, null, LoggingLevel.ERROR);  
        }
        //retuning the wrapperbenefit with label,name as liftOfWrapper and metadata                            
        return new BenefitWrapper(listOfWrapper,mapSecNameVsLabel,isVisionAllowed);
    } 
}
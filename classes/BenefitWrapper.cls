/*
*******************************************************************************************
* Name:          BenefitWrapper
* Author:        Deloitte offshore
* ModifiedBy:    Deloitte offshore
* CreatedDate:   02/26/2020
* Used By:       
*******************************************************************************************
* Description:Class for forming the wrapper data and metadata as wrapperlist for sending to LWC.

*******************************************************************************************
* Changes By:Deloitte Offshore
* Date:02/26/2020
*******************************************************************************************
*/
public with sharing class BenefitWrapper{
    @AuraEnabled
    public List<BenefitDataForPicklistWrapper> lstWrap{get;set;}
    @AuraEnabled
    public Map<String, Benefit_Setting__mdt> mapBenefit{get;set;}
    @AuraEnabled
    public Boolean isVisionAllowed{get;set;}
    //Constructor for forming the wrapper
     public BenefitWrapper(List<BenefitDataForPicklistWrapper> lstWrap, Map<String, Benefit_Setting__mdt> mapBenefit,Boolean isVisionAllowed){
         this.lstWrap = lstWrap;
         this.mapBenefit = mapBenefit;
         this.isVisionAllowed = isVisionAllowed;
         }
}
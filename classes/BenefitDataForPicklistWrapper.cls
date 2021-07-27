/*
*******************************************************************************************
* Name:          BenefitDataForPicklistWrapper
* Author:        Deloitte offshore
* ModifiedBy:    Deloitte offshore
* CreatedDate:   02/26/2020
* Used By:       
*******************************************************************************************
* Description:WrapperClass for forming the wrapperdata with label and value and using it in LWC DropDown Field

*******************************************************************************************
* Changes By:Deloitte Offshore
* Date:02/26/2020
*******************************************************************************************
*/
public with sharing class BenefitDataForPicklistWrapper {
@AuraEnabled
public String label {get;set;}
@AuraEnabled
public String value {get;set;}

//Constructor for setting label and value
public BenefitDataForPicklistWrapper(String label,String value) {
    this.label = label;
    this.value = value;
}
}
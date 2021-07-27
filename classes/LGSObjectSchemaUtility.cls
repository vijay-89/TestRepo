/*
*******************************************************************************************
* Name:          LGSObjectSchemaUtility
* Author:        Deloitte offshore
* ModifiedBy:    Deloitte offshore
* CreatedDate:   02/26/2020
* Used By:       
*******************************************************************************************
* Description: This will be a utility class for fecthing fields for specified object name

*******************************************************************************************
* Changes By:Deloitte Offshore
* Date:02/26/2020
*******************************************************************************************
*/
public with sharing class LGSObjectSchemaUtility{
    
    /*
_________________________________________________________________________________________

*@description: This method will be used to get the fields for passed sobject name
_______________________________________________________________________________________

*@param: sObjectApiName - holds the object name- String
____________________________________________________________________________________

*@return: String
_________________________________________________________________________________________
*/
    public static String getFieldsList(String sObjectApiName){ 
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        //fetches the fieldsmap for passed sobject
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(sObjectApiName).getDescribe().fields.getMap();
        String sCommaSepratedFields = '';
        for(String objFieldName : fieldMap.keyset()){
            if(String.isBlank(sCommaSepratedFields)){
                sCommaSepratedFields = objFieldName;
            }           
            else{
                sCommaSepratedFields = sCommaSepratedFields + ', ' + objFieldName;   
            } 
        }
        //returning the list of fields for passed object
        return sCommaSepratedFields;
    }
    
}
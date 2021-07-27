/*
********************************************************************************************
* Name          DupCaseViewerController
* Author        Ethan Park
* ModifiedBy    Ethan Park
* CreatedDate   03/11/2020
* UsedBy        dupCaseViewerLWC to retrieve Case and potential duplicate Case records
*********************************************************************************************
*/

public with sharing class DupCaseViewerController {
    Static final String deliminator = ',';
    
    /*
    * @This method is called from dupCaseViewerLWC and used to get Case record data
    * @Name: getCaseRecord
    * @Created Date: 03/11/2020
    * @Author: Ethan Park
    * @Description Jira user story PRCDM2-1235
    */
    @AuraEnabled(cacheable = true)
    public static Case getCaseRecord(Id recordId)
    {
        try {
            Case caseRecord = [
                SELECT Id, CaseNumber, Status, Potential_Duplicate__c, Duplicate_Cases__c
                FROM Case
                WHERE Id = :recordId
                LIMIT 1
            ];
            return caseRecord;
        } catch (Exception e) {
            throw new AuraHandledException('Something went wrong from the Controller: ' + e.getMessage());
        }
    }
    
    /*
    * @This method is called from dupCaseViewerLWC and used to get a list of potential duplicate case records
    * @Name: getDupRecords
    * @Created Date: 03/11/2020
    * @Author: Ethan Park
    * @Description Jira user story PRCDM2-1235
    */
    @AuraEnabled(cacheable = true)
    public static List<Case> getDupRecords(Id recordId)
    {
        try {
            Case currentCase = [
                SELECT Id, Potential_Duplicate__c, Duplicate_Cases__c FROM Case WHERE Id = :recordId LIMIT 1
            ];

            String idString = currentCase.Duplicate_Cases__c;
            if(String.isEmpty(idString)) { return null; }
            Set<String> dupIds = new Set<String>();
            for(String item : idString.split(deliminator)) {
                dupIds.add(item.trim());
            }
            
            List<Case> dupCases = [
                SELECT Id, CaseNumber, Status, CreatedDate, LastModifiedDate, Subject,
                    Contact.FirstName, Contact.LastName,
                    Prospect_Customer__c, Prospect_Customer__r.Name, Prospect_Customer_Name__c,  
                    Requested_Effective_Date__c
                FROM Case
                WHERE Status != 'Merged' AND CaseNumber IN :dupIds
                ORDER BY CaseNumber
            ];

            return dupCases;
        } catch (Exception e) {
            throw new AuraHandledException('Something went wrong from the Controller ' + e.getMessage());
        }
    }
}
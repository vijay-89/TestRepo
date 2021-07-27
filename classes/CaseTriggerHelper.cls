public with sharing class CaseTriggerHelper {
    public void updateMailBox(List<Case> lstCase) {
        List<Mailbox_Origin_Emails__c> mailsList = Mailbox_Origin_Emails__c.getall().values();
        
        if(!mailsList.isEmpty()) {
            Map<String,String> mails = new Map<String,String>();
            for(Mailbox_Origin_Emails__c m:mailsList){
                mails.put(m.Mailbox_origin_Name__c.toUpperCase(),m.Mailbox_Value__c);
            }
            for(case cs : lstCase) {
                List<String> allEmail = new List<String>();
                if(cs.Mailbox_Origin__c != null) {
                    List<String> mailBoxOriginMails = cs.Mailbox_Origin__c.split('; ');
                    String mbMail = ';';
                    for(String mbo:mailBoxOriginMails) {
                        String mailWithoutSemiColon = mbo.split(';').get(0).toUpperCase();
                      
                        if(mails.containsKey(mailWithoutSemiColon.toUpperCase()) && (allEmail.isEmpty() || (!allEmail.Contains(mails.get(mailWithoutSemiColon))))) {
                            
                            mbMail =  mbMail + mails.get(mailWithoutSemiColon)  + '; '  ;
                            allEmail.add(mails.get(mailWithoutSemiColon));
                        }
                    }
                    mbMail = mbMail.removeEnd(';');
                    cs.Mailbox__c = mbMail;   
                } else{
                    cs.Mailbox__c = '';
                }
            }
        } else{
            for(case cs : lstCase){
                cs.Mailbox__c = '';
            }
        }
    } 
    
    public void removeAccountContact(List<Case> caseList, Map<Id,Case> mapIdCase) {
        system.debug('mapIdCase '+mapIdCase);
        set<string> accIdSet = new set<string>();
        for(Case cs : caseList){
            if(NULL != cs.AccountId)
                accIdSet.add(cs.AccountId);
        }
        if(accIdSet.size()>0){
            Map<Id,Account> mapAcc = new Map<id,Account>([select id, Name from Account where id in :accIdSet]);        
            for(Case cs:caseList){
                Account acc = mapAcc.get(cs.AccountId);
                if(NULL != acc  && acc.Name == Label.AccountAnthemAssociates){
                    cs.AccountId = null;
                    cs.ContactId = null;
                }
            }
        }
    }
    
    /*
* @This method will be used to pass the List of Cases to process duplicate Check.
* @Name:potentialDuplicateCheck
* @Created Date: 29th February 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    
    public void potentialDuplicateCheck(List<Case> lstCases){
        try {
            processData(lstCases);
        }
        Catch(Exception e){
            UTIL_LoggingService.logHandledException(e, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.CASETRIGGERHELPER_CLASS_NAME,StaticVariableClass.POTENTIAL_DUPLICATE_CHECK, null, LoggingLevel.ERROR);
        }
    } 
    
    /*
* @This method will be used to uncheck the Merged Cases and pass the List of Cases to process duplicate Check.
* @Name:UncheckPotentialDuplicates
* @Created Date: 29th February 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    
    public void uncheckPotentialDuplicates(List<Case> listNewUpdatedCases){
        try {
            List<Case> listProcessingCases= new List<Case>();
            List<Case> listCasesToBeUpdated= new List<Case>();
            List<String> listCaseNumber = new List<String>();
            for(Case oC: listNewUpdatedCases) {
                if(oC.Status == StaticVariableClass.MERGED ){
                    if(String.isNotEmpty(oC.Duplicate_Cases__c)){
                        listCaseNumber.addAll(oC.Duplicate_Cases__c.split(','));
                    }
                }
                else {
                    listProcessingCases.add(oC);
                }
            }
            for(Case ocase : [Select Id, Duplicate_Cases__c, Potential_Duplicate__c,CaseNumber from Case where CaseNumber in : listCaseNumber]) {
                ocase.Potential_Duplicate__c = false ;
                ocase.Duplicate_Cases__c = '' ; 
                listCasesToBeUpdated.add(ocase);
            }
            if (Schema.sObjectType.Case.isUpdateable() && !listCasesToBeUpdated.isEmpty()) {
                Update listCasesToBeUpdated;
            }
            if(!listProcessingCases.isEmpty()){
                processData(listProcessingCases);
            }
        }
        Catch(Exception e){
            UTIL_LoggingService.logHandledException(e, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.CASETRIGGERHELPER_CLASS_NAME,StaticVariableClass.UNCHECK_POTENTIAL_DUPLICATES, null, LoggingLevel.ERROR);
        } 
    }
    
    /*
* @This method will be used to check cases and send the cases to process duplicate check.
* @Name:processData
* @Created Date: 29th February 2020
* @Author : Rishanth Kumar(Harmony)
* @Description Jira user story PRCDM2-2018   
*/
    
    private void processData(List<Case> listNewCases){
        try {
            
            Map<String,List<String>> mapDBBrokerEffWithCaseMap = new Map<String,List<String>>();
            Map<String,List<Case>> mapBrokerWithCaseMap = new Map<String,List<Case>>();
            Map<Id,Case> mapDataWithMatchingCriteria = new Map<Id,Case>();
            Map<String,List<String>> mapCaseWithCaseNumbers = new Map<String,List<String>>();
            Map<Id,Case> mapNewCases = new Map<Id,Case>(listNewCases);
            Map<String,List<Case>> mapKeyWithCases = new Map<String,List<Case>>();
            Map<String,Case> mapCaseNumberWithCase = new Map<String,Case>();
            List<Case> listRemDupCases = new List<Case>();
            List<String> listToBeBlanked = new List<String>();
            List<String> listAllCases = new List<String>();
            Set<Id> setCaseIds = new Set<Id>();
            
            for(Case oc : listNewCases) {
                setCaseIds.add(oc.id);
            }
            
            // Preparing the maps with key as combination of prospect/customer and Requested Effective Date and value as CaseNumber for data in trigger context
            // Preparing another map to use the prospect/customer data in trigger context and use in the below iteration
            
            for(Case oCase : listNewCases)
            {
                if(String.isNotBlank(oCase.Prospect_Customer__c) && oCase.requested_effective_date__c != NULL && String.isNotBlank(oCase.Prospect_Customer__c)) {
                    if( !mapBrokerWithCaseMap.containsKey(oCase.Prospect_Customer__c) && (mapBrokerWithCaseMap.get(oCase.Prospect_Customer__c) == NULL)){ 
                        mapBrokerWithCaseMap.put((String)oCase.Prospect_Customer__c,new List<Case>{oCase}); 
                    }
                    else {
                        mapBrokerWithCaseMap.get((String)oCase.Prospect_Customer__c).add(oCase);
                    }
                }
            }
            
            // fetching the latest data from the DB for the records including the related data like contact record type and preparing a map with key combination of
            // DB related prospect/customer and requested effective date and value as case record.
            
            for(Case oDBCase : [Select id, CaseNumber, RecordTypeid ,ContactId ,Contact.recordtype.name , Prospect_Customer__c, requested_effective_date__c, Duplicate_Cases__c, Potential_Duplicate__c
                                from Case where Contact.recordtype.Name =:System.Label.LG_Broker AND Prospect_Customer__c in :mapBrokerWithCaseMap.keySet() AND recordtype.Name=:System.Label.RFP_Intake_Case AND isClosed = false]) {
                                    if( oDBCase != NULL && String.isNotBlank(oDBCase.Prospect_Customer__c) && oDBCase.requested_effective_date__c != NULL && String.isNotBlank(oDBCase.ContactId)){
                                        if( mapDBBrokerEffWithCaseMap.get((String)oDBCase.Prospect_Customer__c+oDBCase.ContactId+oDBCase.requested_effective_date__c) == NULL){
                                            mapDataWithMatchingCriteria.put(oDBCase.Id, oDBCase);
                                            mapDBBrokerEffWithCaseMap.put((String)oDBCase.Prospect_Customer__c+oDBCase.ContactId+oDBCase.requested_effective_date__c,new List<String>{oDBCase.CaseNumber});
                                        }
                                        else {
                                            mapDataWithMatchingCriteria.put(oDBCase.Id, oDBCase);
                                            mapDBBrokerEffWithCaseMap.get((String)oDBCase.Prospect_Customer__c+oDBCase.ContactId+oDBCase.requested_effective_date__c).add(oDBCase.CaseNumber);
                                        }
                                    }
                                }
            
            
            // Process the data to find the duplicates and update the records in future method
            
            LGCaseService.processDuplicateCases(setCaseIds);
            
            // Logic to identify the cases which doesn't match the duplicate criteria
            
            for(Id ikey : mapNewCases.keySet()){
                if(!mapDataWithMatchingCriteria.containsKey(ikey) && mapNewCases.get(ikey).Potential_Duplicate__c == true && mapNewCases.get(ikey).Duplicate_Cases__c != NULL){
                    if( mapCaseWithCaseNumbers.get(ikey) != NULL ){
                        mapCaseWithCaseNumbers.put(mapNewCases.get(ikey).CaseNumber, mapNewCases.get(ikey).Duplicate_Cases__c.split(staticVariableClass.COMMA));
                    }
                    else {
                        List<String> sdupCaseNum = mapNewCases.get(ikey).Duplicate_Cases__c.split(staticVariableClass.COMMA);
                        mapCaseWithCaseNumbers.put(mapNewCases.get(ikey).CaseNumber,sdupCaseNum); 
                    }
                }
            }
            
            
            for(List<String> listmapCase : mapCaseWithCaseNumbers.values()){
                listAllCases.addAll(listmapCase);
            }
            // Query data (everything) prepare map with casenumber as key and case as values
            if(!listAllCases.isEmpty()){
                for(Case oc : [Select Id,Potential_Duplicate__c,Duplicate_Cases__c,CaseNumber,Status from Case where Casenumber in : listAllCases ]){
                    mapCaseNumberWithCase.put(oc.CaseNumber, oc) ;
                }
            }

            for(String skey : mapCaseWithCaseNumbers.keyset()){
                if(String.isNotBlank(skey) && mapCaseNumberWithCase.containsKey(skey)){
                    for(String scasenumber : mapCaseWithCaseNumbers.get(skey)){
                        if( String.isNotBlank(scasenumber) && mapKeyWithCases.get(skey) == NULL ){
                            mapKeyWithCases.put(skey,new List<Case>{mapCaseNumberWithCase.get(scasenumber)});
                        }
                        else{
                            mapKeyWithCases.get(skey).add(mapCaseNumberWithCase.get(scasenumber));
                        }
                    }
                }
            }
            
            // Check whether only 2 cases are involved in matching criteria. if not, need to clear the current case and
            // should remove the current case from other records.
            
            for(String ocasenum : mapCaseWithCaseNumbers.keySet()){
                if(mapCaseWithCaseNumbers.get(ocasenum) != NULL && mapCaseWithCaseNumbers.get(ocasenum).size() == staticVariableClass.TWO){
                    listToBeBlanked.addAll(mapCaseWithCaseNumbers.get(ocasenum));
                }
                else{
                    for(Case oremDupCases: mapKeyWithCases.get(ocasenum)){
                        if(ocasenum == oremDupCases.CaseNumber){
                            oremdupcases.Potential_Duplicate__c = false ;
                            oremdupcases.Duplicate_Cases__c = '' ; 
                            listRemDupCases.add(oremDupcases);
                        }
                        else{
                            if(oremdupcases.Duplicate_Cases__c.contains(staticVariableClass.COMMA+ocasenum)){
                                oremdupcases.Duplicate_Cases__c = oremdupcases.Duplicate_Cases__c.remove(staticVariableClass.COMMA+ocasenum) ;
                            }
                            else{
                                oremDupCases.Duplicate_Cases__c = oremDupCases.Duplicate_Cases__c.remove(ocasenum) ; 
                            } 
                            listRemDupCases.add(oremDupcases);
                        }
                    }  
                }
            }
            
            // Clearing out the cases which are identified in above logic.
            
            for(Case oremDupCases: [Select id,Potential_Duplicate__c,Duplicate_Cases__c,CaseNumber from Case where casenumber in :listToBeBlanked]){
                oremdupcases.Potential_Duplicate__c = false ;
                oremdupcases.Duplicate_Cases__c = '' ; 
                listRemDupCases.add(oremDupcases);
            }
            
            // Updating the records to remove duplicates
            
            if (Schema.sObjectType.Case.isUpdateable() && !listRemDupCases.isEmpty()) {
                Update listRemDupCases;
            }
            
        }
        Catch(Exception e){
            UTIL_LoggingService.logHandledException(e, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.CASETRIGGERHELPER_CLASS_NAME,StaticVariableClass.PROCESS_DATA, null, LoggingLevel.ERROR);
        }
    }
    /*
* @This methood will pass the values of Trigger.new and Trigger.OldMap to BenefitCensusUtilityForCase 
* @Name: opptyStampingBenefitCensus
* @Created Date: 03/13/2020
* @Author :Rahul Gupta
* @Description Jira user story PRCDM2-175
*/
    public void opptyStampingBenefitCensus(List<Case> listNewCases, Map<Id,Case>mapOldCases){
       LGCaseService.opptyStampingBenefitCensus(listNewCases,mapOldCases);
    }
}
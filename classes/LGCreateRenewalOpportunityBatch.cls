/**
* ------------------------------------------------------------------------------------------------------
* Name          LGCreateRenewalOpportunityBatch
* Author        Deloitte Offshore
* ModifiedBy    Deloitte Offshore
* CreatedDate   14/03/2018
* UsedBy        LGRenewalBatchScheduler
* ------------------------------------------------------------------------------------------------------
* 
* @description
* 
* Batch to clone Opportunities that are ready to move to renewal Local and Cloning the related List 
* of the opportunities.
* 
* ------------------------------------------------------------------------------------------------------
* Changes
* 
* Added the Code lines by Ranjith 69 to 94 and 249 to 289 with respect of 
* JIRA Number: PRDCRM-35396(Vikings Team )
* 
* Added the error handling mechanism for 46384 and MCS report corrections for 49221
* ------------------------------------------------------------------------------------------------------
**/
global with sharing class LGCreateRenewalOpportunityBatch   extends staticVariableClass 
                                                            implements Database.Batchable<sObject>, Database.Stateful
{
    String sOpportunityQuery;
    Map<Id, String> mapStatus{get; set;}
    Integer iSuccessCount=0;
    Integer iFailureCount=0;
  Set<String> setOppIds = new Set<String>();
    
    /**
    * @description LGCreateRenewalOpportunityBatch (Constructor)
    */
    public LGCreateRenewalOpportunityBatch() {
        mapStatus = new Map<Id, String>();
        sOpportunityQuery = 'select ID,Is_Pharmacy_Onsite__c,Pharmacy_Comments__c,X340B__c,Length_of_Rx_Contract_Term_in_Years__c,On_Site_Pharmacy__c,Description,Is_Renewed__c,Exchange_PEO_Consortium__c,Pricebook2ID,Account.OwnerID,CloseDate,AccountId,RecordTypeName__c,Name,Account.name,Opportunity_Renewal_Date__c, Custom_Prefix__c FROM Opportunity where Account.Account_s_Suppress_Auto_Renewal__c = false AND AnthemEntity__c IN (\'Local/Large Group\',\'Labor and Trust\')  AND RecordTypeName__c IN (\'Renewal Local\',\'New Business Local\',\'In Group Add Product Local\',\'In Group Change Local\')AND StageName IN (\'Closed Won\',\'Renewal Finalized\',\'Change Confirmed\') AND Is_Renewed__c = False and Account.owner.IsActive = true';
    }
    
    /**
    * @description LGCreateRenewalOpportunityBatch (Parameterized Constructor)
    * @param opportunityId
    */
    public LGCreateRenewalOpportunityBatch(Id opportunityId) {
        mapStatus = new Map<Id, String>();
        sOpportunityQuery = 'select ID,Is_Pharmacy_Onsite__c,Pharmacy_Comments__c,X340B__c,Length_of_Rx_Contract_Term_in_Years__c,On_Site_Pharmacy__c,Description,Is_Renewed__c,Exchange_PEO_Consortium__c,Pricebook2ID,Account.OwnerID,CloseDate,AccountId,RecordTypeName__c,Name,Account.name,Opportunity_Renewal_Date__c, Custom_Prefix__c FROM Opportunity where AnthemEntity__c IN (\'Local/Large Group\',\'Labor and Trust\')  AND RecordTypeName__c IN (\'Renewal Local\',\'New Business Local\',\'In Group Add Product Local\',\'In Group Change Local\')AND StageName IN (\'Closed Won\',\'Renewal Finalized\',\'Change Confirmed\') and Id = \''+opportunityId+'\' and Account.owner.IsActive = true';
    }
    
    /**
    * @description LGCreateRenewalOpportunityBatch (Parameterized Constructor)
    * @param setOpportunityId
    */
    public LGCreateRenewalOpportunityBatch(set<string> setOpportunityId) {
        mapStatus = new Map<Id, String>();
        setOppIds.addAll(setOpportunityId);  
    }
    
    /**
    * @description start method (Standard structure of batch class)
    * @param batchableContextIns (Database BatchableContext)
    * @return Query locator (Database QueryLocator)
    */
    global Database.QueryLocator start(Database.BatchableContext batchableContextIns){
        if(setOppIds.size() >0){
             sOpportunityQuery = 'select ID,Is_Pharmacy_Onsite__c,Pharmacy_Comments__c,X340B__c,Length_of_Rx_Contract_Term_in_Years__c,On_Site_Pharmacy__c,Description,Is_Renewed__c,Exchange_PEO_Consortium__c,Pricebook2ID,Account.OwnerID,CloseDate,AccountId,RecordTypeName__c,Name,Account.name,Opportunity_Renewal_Date__c, Custom_Prefix__c FROM Opportunity where AnthemEntity__c IN (\'Local/Large Group\',\'Labor and Trust\')  AND RecordTypeName__c IN (\'Renewal Local\',\'New Business Local\',\'In Group Add Product Local\',\'In Group Change Local\')AND StageName IN (\'Closed Won\',\'Renewal Finalized\',\'Change Confirmed\') and Id =: setOppIds and Account.owner.IsActive = true';
        }
        return Database.getQueryLocator(sOpportunityQuery);
    }
    /**
    * @description execute method (Standard structure of batch class)
    * @param batchableContextIns (Database.BatchableContext)
    * @param scope (List<Account>) gets account list
    */
    global void execute(Database.BatchableContext batchableContextIns, List<Opportunity> scope) {
        
        Map<ID,ID> accountIdMap= new Map<Id,Id>();
        List<OpportunityTeamMember> teamMemberList = new List<OpportunityTeamMember>();
        
        //Defect fix PRDCRM-18187 Adding below 3 lines
        String quoteLineItemQuery ='Select Id,TECH_QuoteIdForRenewalOpty__c,TECH_ParentIdForRenewalOpty__c,QuoteId from QuoteLineItem where id In:setqliids';
        Map<Id,Id> lineItemMap = new Map<Id,Id>();
        List<QuoteLineItem> childItemList = new List<QuoteLineItem>();
        Map<Date, List<Opportunity>> renewalDateToOpptiesMap = new Map<Date, List<Opportunity>>();
        
        //Opportunity clones
        Map<Id, Opportunity> mapOriginalOppToClonedOpp = new Map<Id, Opportunity>();
        List<opportunity> oldopp = new List<opportunity>();
        List<Opportunity> opptiesCloned = new List<Opportunity>();
        //This List is used to clone the product selection detail records to the newly created plan QLIs
        List<ProductSelectionDetail__c> productSelectionDetailList = new List<ProductSelectionDetail__c>();
        //Quote clones
        Map<Id, Quote> quoteCLONEMap = new Map<Id, Quote>();
        //Group Number and Claim System vs Quotes
        Map<String, List<Quote>> quoteMap = new Map<String, List<Quote>>();
        //Broker and Consuulatant field vs Brokerage and consultant
        Map<String, List<Brokerage_and_Consultant1__c>> brokerMap = new Map<String, List<Brokerage_and_Consultant1__c>>();
        //Broker and consultant  clones
        Map<Id, Brokerage_and_Consultant1__c> brokerCloneMap = new Map<Id, Brokerage_and_Consultant1__c>();
        Map<Id,Pharmacy_Upsell_Details__c> phmudMap=new Map<id,Pharmacy_Upsell_Details__c>();
        //Quote GroupNo. Vs QuoteLineItem
        Map<String, List<QuoteLineItem>> quoteLineItemMap = new Map<String, List<QuoteLineItem>>();
        Map<Id, QuoteLineItem> qliCloneMap = new Map<Id, QuoteLineItem>();
        Map<Id,List<HRA_Administration__c>> hraMap = new Map<Id,List<HRA_Administration__c>>();
        Map<Id,List<Pharmacy_Upsell_Details__c>> pharmacyupsellMap=new Map<Id,List<Pharmacy_Upsell_Details__c>>();
        List<QuoteLineItem> listqline = new List<QuoteLineItem>();
        Id oppId;
        
        Savepoint savePt = Database.setSavepoint();
        
        try{
            for(Opportunity oppty : scope) {
    
                if(renewalDateToOpptiesMap.containsKey(oppty.Opportunity_Renewal_Date__c)) {
                    renewalDateToOpptiesMap.get(oppty.Opportunity_Renewal_Date__c).add(oppty);
                }
                else {
                    renewalDateToOpptiesMap.put(oppty.Opportunity_Renewal_Date__c, new List<Opportunity>{oppty});
                } 
            }
        
            for(Date renewalDt : renewalDateToOpptiesMap.keyset()) {
                if(renewalDt <= (system.now().date()).addMonths(9)) {
                    Opportunity opptyToClone = renewalDateToOpptiesMap.get(renewalDt)[0];
                    Opportunity oppClone = opptyToClone.clone(false, false, false, false);
                    oppClone.StageName = staticVariableClass.StageNameInitiated;
                    oppClone.name=  String.valueOf(opptyToClone.CloseDate.year() + 1) + staticVariableClass.RenewalLocal + opptyToClone.Account.name;
                    oppClone.CloseDate= opptyToClone.Opportunity_Renewal_Date__c;
                    oppClone.Custom_Prefix__c = opptyToClone.Custom_Prefix__c;
                    oppClone.recordTypeId = Schema.getGlobalDescribe().get(staticVariableClass.Opportunity).getDescribe().getRecordTypeInfosByName().get('Renewal Local').getRecordTypeId();
                    oppClone.Probability = 85;
                    oppClone.OwnerId= opptyToClone.Account.OwnerID;
                    oppClone.Description = opptyToClone.Description;
                
                    //-- Added by Ranjith for Pharmacy fields Mappings start
                    
                    //oppClone.Pharmacy_Top_Account__c = opptyToClone.Pharmacy_Top_Account__c; // This is commented by Ranjith --PRDCRM-44411 (VIKINGS)
                    //oppClone.Claims_System__c = opptyToClone.Claims_System__c; // This is commented by Ranjith --PRDCRM-44411 (VIKINGS)
                    oppClone.X340B__c = opptyToClone.X340B__c;
                    //oppClone.Pharmacy_Top_Account_Start_Date__c = opptyToClone.Pharmacy_Top_Account_Start_Date__c; // This is commented by Ranjith --PRDCRM-44411 (VIKINGS)
                    //oppClone.Pharmacy_Top_Account_End_Date__c = opptyToClone.Pharmacy_Top_Account_End_Date__c;  // This is commented by Ranjith --PRDCRM-44411 (VIKINGS)
                    oppClone.Length_of_Rx_Contract_Term_in_Years__c = opptyToClone.Length_of_Rx_Contract_Term_in_Years__c;
                    oppClone.On_Site_Pharmacy__c = opptyToClone.On_Site_Pharmacy__c; // This is NABP/NPI field                     
    
                    //-- Added by Ranjith for Pharmacy fields Mappings end 
                    
                    //-- Added by Ranjith for Pharmacy fields Mappings start -- PRDCRM-44411 (VIKINGS)                                 
                    oppClone.Pharmacy_Comments__c = opptyToClone.Pharmacy_Comments__c;
                    oppClone.Is_Pharmacy_Onsite__c = opptyToClone.Is_Pharmacy_Onsite__c;
                    //-- Added by Ranjith for Pharmacy fields Mappings end   --- PRDCRM-44411 (VIKINGS)
                    
                    //-- Added by Neha Prasad for Is_Pharmacy_Carved_out__c
                    oppClone.Is_Pharmacy_Carved_out__c = '';
                    for(Opportunity oppIns : renewalDateToOpptiesMap.get(renewalDt)) {
                        oppIns.Is_Renewed__c = true;
                        oldopp.add(oppIns);
                    }
    
                    mapOriginalOppToClonedOpp.put(opptyToClone.Id, oppClone);
    
                    if(renewalDateToOpptiesMap.containsKey(opptyToClone.Opportunity_Renewal_Date__c) && renewalDateToOpptiesMap.get(opptyToClone.Opportunity_Renewal_Date__c) != null) {
                        opptiesCloned.addAll(renewalDateToOpptiesMap.get(opptyToClone.Opportunity_Renewal_Date__c));
                    }
                }
            }

            if(mapOriginalOppToClonedOpp.values().size() > 0) {
               insert mapOriginalOppToClonedOpp.values(); 
            }
            
            if(oldopp.size() > 0) {
               update oldopp; 
            }
    
            for(Opportunity o : mapOriginalOppToClonedOpp.values()) {
                accountIdMap.put(o.AccountId, o.Id);
            }
        
            //Converting the List to Map to get Opportunity Ids from List without iterating it
            Map<Id, Opportunity> clonedOpptiesMap = new Map<Id, Opportunity>(opptiesCloned);
            
            //GN to Quotes Map
            for(Quote qt : [select  id,GroupNumber__r.name,Claim_System__c,DivisionName__c,Opportunity.CloseDate,
                                    Account.name,Pricebook2Id,name,Group_Number_Claim_System__c,Opportunity.name, 
                                    Opportunity.Opportunity_Renewal_Date__c,NASCOMarketSegmentCode__c from quote 
                                                            where OpportunityId IN : clonedOpptiesMap.keyset()]) {
    
                if(!quoteMap.containsKey(qt.Group_Number_Claim_System__c)) {
                   quoteMap.put(qt.Group_Number_Claim_System__c, new List<Quote>{qt}); 
                }
                else  {
                    quoteMap.get(qt.Group_Number_Claim_System__c).add(qt);
                }
            }

            for(String grpId : quoteMap.keyset()) {
    
                Quote clonedQuote = quoteMap.get(grpId)[0].clone(false, false, false, false);
                quote q2 = quoteMap.get(grpId)[0];
                Date d = quoteMap.get(grpId)[0].Opportunity.Opportunity_Renewal_Date__c;
    
                if(renewalDateToOpptiesMap.containsKey(d) && renewalDateToOpptiesMap.get(d) != null) {
                    oppId = renewalDateToOpptiesMap.get(d)[0].Id;// cloned Oppty Id  
                }
                if(mapOriginalOppToClonedOpp.containsKey(oppId) && mapOriginalOppToClonedOpp.get(oppId) != null) {
                    clonedQuote.OpportunityId = mapOriginalOppToClonedOpp.get(oppId).Id; // newly Cloned oppty Id
                }
                
                clonedQuote.Name= String.valueOf(q2.Opportunity.CloseDate.year() + 1) + staticVariableClass.RenewalLocal + q2.Account.name;
                clonedQuote.DivisionName__c = q2.DivisionName__c;
                quoteCLONEMap.put(q2.Id, clonedQuote);
                clonedQuote.Pricebook2Id =q2.Pricebook2Id;
            }

            if(quoteCLONEMap.values().size() > 0) {
                insert quoteCLONEMap.values();
            }

            //Account Team Member Clones
            //Iterate through Acc Team members

            List<AccountTeamMember> accountTeamMemberList = new List<AccountTeamMember>([SELECT AccountID,OpportunityAccessLevel,TeamMemberRole,UserId,User.Name FROM AccountTeamMember where AccountId In:accountIdMap.keySet()]);

            //Add Opportunity Team Member
            for(Opportunity oppty : mapOriginalOppToClonedOpp.values()) {
    
                for(AccountTeamMember eachTeam : accountTeamMemberList) {
    
                    OpportunityTeamMember newTeam = new OpportunityTeamMember
                    (
                        OpportunityId = oppty.id,
                        OpportunityAccessLevel=eachTeam.OpportunityAccessLevel,
                        TeamMemberRole = eachTeam.TeamMemberRole,
                        UserId= eachTeam.UserId
                    );
                    teamMemberList.add(newTeam);
                }
    
            }
        
            if(teamMemberList.size() > 0) {
                insert teamMemberList;
            }
            
            for(Brokerage_and_Consultant1__c broIns : [select Opportunity__r.Opportunity_Renewal_Date__c,
                                                        Brokerage_Consultant__c,Brokerage__c,Consultant__c,
                                                        Opportunity__c,OwnerId,Line_of_Business__c,
                                                        Brokerage_of_Record__c,Consultant_of_Record__c,
                                                        Brokerage_Role__c,Broker_Role__c,Brokerage_Effective_Date__c,
                                                        Brokerage_End_Date__c,ConsultantEffectiveDate__c,ConsultantEndDate__c,
                                                        Medical_Brokerage_Ranking__c from Brokerage_and_Consultant1__c 
                                                                                    where Opportunity__c IN
                                                                                    :clonedOpptiesMap.keyset()]) {
                if(!brokerMap.containsKey(broIns.Brokerage_Consultant__c)) {
                    brokerMap.put(broIns.Brokerage_Consultant__c, new List<Brokerage_and_Consultant1__c>{broIns});
                }
                else {
                    brokerMap.get(broIns.Brokerage_Consultant__c).add(broIns);
                }
            }

            for(string duplicate : brokerMap.keyset()) {
    
                //Start: Deloitte Offshore, 04/09/2018
                //JIRA ID: 21396
                //Skipping the Brokerage & Consultant records which has past end dates.
                if(brokerMap.get(duplicate)[0].Brokerage_End_Date__c == null) {
                    
                    //End: Deloitte Offshore, 04/09/2018
                    Brokerage_and_Consultant1__c clonedBroker =brokerMap.get(duplicate)[0].clone(false, false, false, false);
                    Brokerage_and_Consultant1__c broInstance = brokerMap.get(duplicate)[0];
                    Date d = brokerMap.get(duplicate)[0].Opportunity__r.Opportunity_Renewal_Date__c;
                    
                    if(renewalDateToOpptiesMap.containsKey(d) && renewalDateToOpptiesMap.get(d) != null) {
                        oppId = renewalDateToOpptiesMap.get(d)[0].Id;// cloned Oppty Id
                    }
                    
                    if(mapOriginalOppToClonedOpp.containsKey(oppId) && mapOriginalOppToClonedOpp.get(oppId) != null) {
                        clonedBroker.Opportunity__c = mapOriginalOppToClonedOpp.get(oppId).Id; // newly Cloned oppty Id
                    }
                    brokerCloneMap.put(broInstance.Id, clonedBroker);
                }
            }

            if(!brokerCloneMap.values().isEmpty()) {
                insert brokerCloneMap.values();
            }  
             
            
      //From Rx_Plan__c records are added By GLD On QLI Requriments of PRDCRM-50802 By GLD
      //Removed fields Reason__c,TermDate__c,ReceivedDate__c,MedicalRXAccumulation__c,PLComplete__c,CurrentMembers__c,CurrentSubscribers__c, by GLD on the requriments of PRDCRM-50802
            //Quote Line item related to Quotes
            List<QuoteLineItem> quoteLineItemList = new List<QuoteLineItem>();

            for(QuoteLineItem qliIns : [SELECT CurrentSubscribers__c,CurrentMembers__c,Probability__c,
                                                Reason__c,PricebookEntryId,Line_of_Business__c,
                                                ActWise_ParentQuoteLineItem__c,ActWiseChildQuote__c,
                                                ProductLOB__c,Is_Pharmacy_Carved_Out_from_the_Medical__c,
                                                FSA_Plan_End_Date__c,Comments__c,TECH_QuoteIdForRenewalOpty__c,
                                                TECH_ParentIdForRenewalOpty__c,ParentQuoteLineItem__c,
                                                RecordType__c,Quote.GroupNumber__r.name,Product2Id,
                                                id,Quote.Pricebook2Id,Quantity,UnitPrice,Product_Term_Years_Left__c,
                                                Quote.Group_Number_Claim_System__c,Quote.opportunity.RecordTypeName__c,
                                                Funding__c,Financing__c,Network__c,Subscribers__c,ProductStage__c,
                                                Members__c,Employer_Contribution_for_the_Dependent__c,
                                                Employer_Contribution_for_the_Employee__c,Discount_sharing__c,
                                                EPHC_Enhanced_Personal_Health_Care__c,Participation_Type__c,
                                                (Select Id,Plan_Start_Date__c,Plan_End_Date__c,
                                                        Claim_Run_Out_Date__c from HRA_Administrations__r) 
                                                        FROM QuoteLineItem 
                                                        where Quote.opportunityId In:clonedOpptiesMap.keyset()]) {
    
                if(!quoteLineItemMap.containsKey(qliIns.Quote.Group_Number_Claim_System__c)) {
                    quoteLineItemMap.put(qliIns.Quote.Group_Number_Claim_System__c, new List<QuoteLineItem>{qliIns});
                }
                
                else {
                    quoteLineItemMap.get(qliIns.Quote.Group_Number_Claim_System__c).add(qliIns);
                }
            }
            
            String [] stageArray  = new List<String>{   staticVariableClass.IGAPSold, 
                                                        staticVariableClass.Renewed,
                                                        staticVariableClass.Notrenewingincurrentperiod};

            for(String grpNumber : quoteLineItemMap.keyset()) {
    
                for(QuoteLineItem qli : quoteLineItemMap.get(grpNumber)) {
    
                    if((qli.Quote.opportunity.RecordTypeName__c == staticVariableClass.NewBusinessLocal && qli.ProductStage__c==staticVariableClass.Sold) || (qli.Quote.opportunity.RecordTypeName__c == staticVariableClass.RenewalLocal1 && stageArray.contains(qli.ProductStage__c)) || (qli.Quote.opportunity.RecordTypeName__c == staticVariableClass.IGAPLocal && qli.ProductStage__c==staticVariableClass.IGAPSold) || (qli.Quote.opportunity.RecordTypeName__c == staticVariableClass.IGCLocal && qli.ProductStage__c==staticVariableClass.Sold) && (qli.Line_of_Business__c != 'Pharmacy' && qli.ProductLOB__c!='Pharmacy')) {
    
                        QuoteLineItem clonedQLI = qli.clone(false, false, false, false);
                        Id quoteId = quoteMap.get(grpNumber)[0].Id;// cloned Oppty Id
                        clonedQLI.RecordType__c = qli.RecordType__c;
                        
                        if(qli.FSA_Plan_End_Date__c !=Null) {
                            clonedQLI.FSA_Plan_End_Date__c = qli.FSA_Plan_End_Date__c.addYears(1);
                        }
                        
                        /* Adding the below 3 lines as part of defect fix PRDCRM-18187 */
                        if(qli.ParentQuoteLineItem__c != null) {
                           clonedQLI.ParentQuoteLineItem__c = qli.ParentQuoteLineItem__c;
                        }
                        
                        clonedQLI.TECH_ParentIdForRenewalOpty__c = qli.ParentQuoteLineItem__c;
                        clonedQLI.TECH_QuoteIdForRenewalOpty__c = qli.Id;
    
                        if(quoteId !=null) {
                            clonedQLI.QuoteId = quoteCLONEMap.get(quoteId).Id; // newly Cloned oppty Id
                        }
                        
                        if(qli.Product_Term_Years_Left__c != null && qli.Product_Term_Years_Left__c != '0') {
                            clonedQLI.Product_Term_Years_Left__c = string.valueof(Integer.valueOf(qli.Product_Term_Years_Left__c) - 1);
                        }
                        else {
                            clonedQLI.Product_Term_Years_Left__c = '0';
                        }
    
                        clonedQLI.PricebookEntryId= qli.PricebookEntryId;
                        clonedQLI.Product2Id=qli.Product2Id;
                        clonedQLI.OppType__c = staticVariableClass.RenewalLocal1;
    
                        if(qli.Discount_sharing__c == staticVariableClass.SoldRenewed) {
                            clonedQLI.Discount_sharing__c = staticVariableClass.SoldRenewed;
                        }
                        else {
                            clonedQLI.Discount_sharing__c =null;
                        }
    
                        if(qli.EPHC_Enhanced_Personal_Health_Care__c==staticVariableClass.SoldRenewed){
                            clonedQLI.EPHC_Enhanced_Personal_Health_Care__c = staticVariableClass.SoldRenewed;
                        }
                        else {
                            clonedQLI.EPHC_Enhanced_Personal_Health_Care__c=null;
                        }
    
                        if(clonedQLI.Product_Term_Years_Left__c == null || Integer.valueOf(clonedQLI.Product_Term_Years_Left__c) == 0) {
                            clonedQLI.ProductStage__c = staticVariableClass.InProgress;
                        }
    
                        else if(qli.Product_Term_Years_Left__c != null && Integer.valueOf(clonedQLI.Product_Term_Years_Left__c) > 0 ) {
                            clonedQLI.ProductStage__c = staticVariableClass.Notrenewingincurrentperiod;
                        }
    
                        clonedQLI.Comments__c = qli.Comments__c ;
                        clonedQLI.Is_Pharmacy_Carved_Out_from_the_Medical__c=qli.Is_Pharmacy_Carved_Out_from_the_Medical__c; // This is added for AC6
                        
                        //Added for PRDCRM-44997/45408/42547 (Olympians Change)
                        clonedQLI.Is_Existing_Product__c = true;
                        
                        clonedQLI.Reason__c=qli.Reason__c;
                        
                        if(clonedQLI.ProductStage__c==staticVariableClass.InProgress) {
                            clonedQLI.Probability__c='10%'; 
                        }
                        else if(clonedQLI.ProductStage__c==staticVariableClass.Notrenewingincurrentperiod) {
                            clonedQLI.Probability__c='100%'; 
                        }
                        
                        clonedQLI.CurrentMembers__c=qli.CurrentMembers__c;
                        clonedQLI.CurrentSubscribers__c=qli.CurrentSubscribers__c; 
                        
                        qliCloneMap.put(qli.Id, clonedQLI);
    
                        if(qli.HRA_Administrations__r.size() > 0) {
                            
                            List<HRA_Administration__c> hraAdmin = new List<HRA_Administration__c>();
                            
                            for(HRA_Administration__c hra : qli.HRA_Administrations__r){
    
                                HRA_Administration__c hraRec = new HRA_Administration__c();
                                if(hra.Plan_Start_Date__c != null) {
                                    hraRec.Plan_Start_Date__c = hra.Plan_Start_Date__c.addYears(1);
                                }
                                if(hra.Plan_End_Date__c != null) {
                                    hraRec.Plan_End_Date__c = hra.Plan_End_Date__c.addYears(1);
                                }
                                if(hra.Claim_Run_Out_Date__c != null) {
                                    hraRec.Claim_Run_Out_Date__c = hra.Claim_Run_Out_Date__c.addYears(1);
                                }
                                hraAdmin.add(hraRec);
                            }
                            hraMap.put(qli.Id,hraAdmin);
                        }
                    }
                }
            }

            // Defect fix PRDCRM-18187 : Updating child items with parent id
            if(qliCloneMap.values() != NULL) {
                
                Database.SaveResult[] results = Database.insert(qliCloneMap.values());
                set<Id> setqliids = new set<Id>();

                for(Database.SaveResult res:results) {
                    
                    if(res.isSuccess()) {
                        setqliids.add(res.getId());
                    }
               }

               //Creating HRA Administration
               List<HRA_Administration__c> hraFinalList = new List<HRA_Administration__c>();

               for(Id ids : qliCloneMap.keySet()) {

                    QuoteLineItem qtLineItem = qliCloneMap.get(ids) != null ? qliCloneMap.get(ids) : null;
                    
                    if(hraMap.containsKey(ids) && hraMap.get(ids) != null) {

                       for(HRA_Administration__c hraAd : hraMap.get(ids)) {
                            
                            hraAd.QLI__c = qtLineItem.Id;
                            hraFinalList.add(hraAd);
                        }
                    }
               }

               if(hraFinalList.size() > 0) {
                   insert hraFinalList;
               }
               
               listqline = Database.query(quoteLineItemQuery);

               if(!listqline.isEmpty()) {

                    for(QuoteLineItem newQLI : listqline) {
                        lineItemMap.put(newQLI.TECH_QuoteIdForRenewalOpty__c,newQLI.Id);
                    }

                    for(QuoteLineItem newQLI : listqline) {
                        
                        if(newQLI.TECH_ParentIdForRenewalOpty__c != null && lineItemMap.get(newQLI.TECH_ParentIdForRenewalOpty__c) != null){
                            
                           newQLI.ParentQuoteLineItem__c = lineItemMap.get(newQLI.TECH_ParentIdForRenewalOpty__c );
                           childItemList.add(newQLI);
                        }
                    }
                    
                    if(!childItemList.isEmpty()) {                          
                        database.update(childItemList);
                    }
                    
                    /*
                    
                    Description: Commenting the below piece of code for migrating the Olympians hotfix
                    Date : 06/11/2019
                    
                    //Added for PRDCRM-43400 Start
                    if(!lineItemMap.isEmpty()) {
                        
                        //Iterating across the product detail selection to clone that to newly created Plan QLIs
                        for(ProductSelectionDetail__c prodSelEle : [select  ID,QuoteLineItem__c,
                                                                            Rider__c,LG_IsActiveRider__c,
                                                                            Parent_QLI_Id__c from ProductSelectionDetail__c 
                                                                            where QuoteLineItem__c IN : 
                                                                            lineItemMap.keyset()]) {
                            //Cloning the old product detail selection Instance
                            ProductSelectionDetail__c prodSelIns = prodSelEle.clone(false);
                            //Setting the new QLI Id to the lookup field
                            prodSelIns.QuoteLineItem__c = lineItemMap.get(prodSelEle.QuoteLineItem__c);
                            prodSelIns.Parent_QLI_Id__c = string.valueOf(lineItemMap.get(prodSelEle.Parent_QLI_Id__c));
                            //setting up the record typeId to the cloned product selection detail
                            prodSelIns.RecordTypeId =  Schema.SObjectType.ProductSelectionDetail__c.getRecordTypeInfosByName().get('LG_Rider_Plan_Assoc').getRecordTypeId();
                            //Adding the instance to the List
                            productSelectionDetailList.add(prodSelIns);
                        }
                        
                        //Inserting the cloned product selection detail record.
                        if(!productSelectionDetailList.isEmpty()) {
                            insert productSelectionDetailList;
                        }
                    }
                    //End: PRDCRM-43400
                    */
                }
            }
            
            if(!opptiesCloned.isEmpty()) {
                mapStatus.put(scope[0].id, staticVariableClass.RECORD_PROCESSED_SUCCESS);
                iSuccessCount++;
            }
        }
        catch(Exception ex) {
            mapStatus.put(scope[0].id,ex.getmessage());
            iFailureCount++;
            Database.RollBack(savePt);
        }
    }
    /**
     * @description finish method (Standard structure of batch class)
     * @param batchableContextIns (Database.BatchableContext)
     * @retrun void this method do not return any instance
     */
    global void finish(Database.BatchableContext batchableContextIns) {
        //Start:46384
        if(!mapStatus.isEmpty()) {
            //Calling the createEmail method on LGBatchRenewalStatus class
            AsyncApexJob asyncJobIns = [select  id, ApexClassId,JobItemsProcessed, TotalJobItems,
                                                NumberOfErrors, CreatedBy.Email from AsyncApexJob
                                                                                where id = :batchableContextIns.getJobId()];
            LGBatchRenewalStatus.createEmail(mapStatus, asyncJobIns.JobItemsProcessed, iSuccessCount, iFailureCount);
        }
        //Stop:46384
    }  
}
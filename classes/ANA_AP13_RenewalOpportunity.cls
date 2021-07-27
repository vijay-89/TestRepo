/*
@author         Accenture offshore
@date           10/07/2017
@name           ANA_AP13_RenewalOpportunity
@description    Used in vlocity omniscript to create a renewal opportunity record.
__________________________________________________________________________________________________________

                            Change Log
__________________________________________________________________________________________________________

    Name                    Date            Change Description
__________________________________________________________________________________________________________

    Deloitte Offshore       20/06/2018      Moved a query out of for Loop to avoid Too Many SOQL error
__________________________________________________________________________________________________________
*/
global  without sharing class ANA_AP13_RenewalOpportunity implements vlocity_ins.VlocityOpenInterface2{
    public static final String GETRENEWALOPPORTUNITY = 'getRenewalOpportunity';
    public static final string NODENAME='OpportunityRecordValues';    
    public static final string CONTEXTID='ContextId';
    public static final String CLASSNAME = ANA_AP13_RenewalOpportunity.class.getName();
    public static final String OPPREN = 'Opportunity Renewal';
    public static final string INITIATED = 'Initiated';
    public static final Integer PROB=10;
    public static final Integer ZERO=0;
    private static final String ANA_STG_RENEWAL='Renewed';
    private static final String ANA_STG_SOLD='Sold';
    private static final String ANA_STG_IGAPSOLD='IGAP Sold';
    private static final String ANA_STG_INPRGS='In Progress';
    private static final String ANA_STG_IGAPINPRGS='IGAP In Progress';
    private static final String ANA_STG_JEOPARDY='Jeopardy';
    private static final String ANA_NOT_STARTED='Not started';
    private static final String ANA_RENEWAL ='Renewal';
    private static final String EMPTY='';
    private static final String SPACE=' ';
    private static final string STRQRY = 'select Id,Name,closedate,accountid,ParentOppty__c from Opportunity where id=: oppid limit 1';
    private static final string STROPPQRY = ' id in :iGapopptidsall';// id in :idSet1
    private static final string NEWOPPID ='NewOptyId';
    private static final string OLDOPPID ='OldOptyId';
    private static final string STATUSCODE ='StatusCode';
    private static final string SUCCESS ='Success';
    private static final string FAILURE ='Failure';
    private static final string ERRMSG ='Errormsg';
    private static final string OBJ_QUOTE='Quote';
    private static final string OBJ_QUOTELINEITEM='QuoteLineItem';
    private static final string OBJ_ALTERNATENW='AlternateNetwork__c';
    private static final string OBJ_PRODSELDETAIL='ProductSelectionDetail__c';  
    private static final string QUOTE_WHERECLAUSE='OpportunityId in :idSet1 and GroupNumber__r.isActive__c = true ';
    private static final string QUOTE_CROSSREFFIELDS='GroupNumber__r.Name,GroupNumber__r.isActive__c';
    private static final string QLI_WHERECLAUSE='Quote.OpportunityId in :idSet1 AND ProductStage__c in :stringSet1';
    private static final string QLI_CROSSREFFIELDS='Quote.OpportunityId,Quote.GroupNumber__c,ParentQuoteLineItem__r.Product2.isActive,Product2.isActive,ParentQuoteLineItem__r.ProductStage__c ';
    
    private static final string ALTNW_WHERECLAUSE='QuoteLineItem__c in :idSet1';
    private static final string PRODSEL_WHERECLAUSE='QuoteLineItem__c in :idSet1';
    private static final string OPPCLONESTATUS='Merged with Cloned Renewal';
    public static final string IGAPNAME='In Group Add Product';
    private static final string OPPSTAGEUPDATE ='RecordType.Name';
    private static final string OPPOBJ ='Opportunity';
    private static map<Id,Id> quoteMap;
    private static set<Id> setquotedel;//to delete quote records
    private static map<Id,Id> lineItemMap;
    private set<string> productStages;  
    private static set<Id> setIGAPopp;
    private static list<Opportunity> listigapoppts;
    private static set<string> renewalStages;
    private static set<string> iGapStages;
    private static set<Id> iGapopptids;
    private static map<Id,Id> mapQuotegroup;
    private static map<Id,Id> mapgroupQuote; 
    private static set<Id> setigapnew;//Req::1353
    private static final String STRQLIQRY ='Select Id,TECH_QuoteIdForRenewalOpty__c,TECH_ParentIdForRenewalOpty__c,QuoteId from QuoteLineItem where id In:setqliids'; 
    
    //Start : Deloitte Offshore (Fix done in order to fix Too Many SOQL Error)
    private String OppType;
    //End: Deloitte Offshore
    
    /*Implementation of invokeMEthod from VlocityOpenInterface2 interface.*/
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap,Map<String,Object> optns) {
        if(GETRENEWALOPPORTUNITY.equalsIgnoreCase(methodName)){
            getRenewalOpportunity(inputMap, outMap, optns);
        } 
        return true;
    }   
    /**------------------------------Controlling Method --------------------------------------**/
    global void getRenewalOpportunity(Map<String,Object> input, Map<String, Object> outMap, Map<String, Object> optns){
        try{ 
            
            string newOptyId=(string)input.get(NEWOPPID); 
            string oldOptyId=(string)input.get(OLDOPPID);         
            renewalStages = new set<string>{ANA_STG_RENEWAL,ANA_STG_SOLD,
                                            ANA_STG_IGAPSOLD,ANA_STG_INPRGS,ANA_STG_IGAPINPRGS,ANA_STG_JEOPARDY};
            iGapStages = new set<string>{ANA_STG_IGAPSOLD,ANA_STG_IGAPINPRGS};
            setigapnew = new set<Id>(); //Req::1353
            setIGAPopp = new set<Id>();
            iGapopptids = new set<id>();//mergedwithclone status update
            ANA_UTIL09_QueryObjectData.idSet1 = new set<Id>{oldOptyId};  
            ANA_UTIL09_QueryObjectData.iGapopptidsall = new set<Id>();          
            /*To get IGAP opportunity*/
            Opportunity oldopprec = getOpportunity(Id.valueOf(oldOptyId));
            Opportunity newopprec = getOpportunity(Id.valueOf(newOptyId));
            listigapoppts = new list<opportunity>();
            listigapoppts = ANA_AP14_IGAPRenewalOpportunity.getOpportunityids(oldopprec); 
            if(!listigapoppts.isEmpty()){
                igapOpporunityupdate(listigapoppts,oldopprec,newopprec);
                ANA_UTIL09_QueryObjectData.iGapopptidsall.addAll(iGapopptids);
            }
            
            if(!setIGAPopp.isEmpty()){
                ANA_UTIL09_QueryObjectData.idSet1.addAll(setIGAPopp);           
            }
            opportuityStageUpdate(oldopprec.closedate);           
            /***Calling CloneQuote****/
              
            List<Quote> newQuoteList = cloneQuote(newopprec,QUOTE_CROSSREFFIELDS,QUOTE_WHERECLAUSE);           
            /***Calling CloneQuoteLineItems****/
            if(!quoteMap.isEmpty()){
             cloneQuoteLineItems(QLI_WHERECLAUSE,QLI_CROSSREFFIELDS);   
            }               
             /***Calling cloneAlternateNetwork****/
            if(!lineItemMap.isEmpty()){
                ANA_UTIL09_QueryObjectData.idSet1 = lineItemMap.keyset();
                cloneAlternateNetwork(ALTNW_WHERECLAUSE); 
            }                                
            /***Calling cloneProductSelectionDetail****/
            if(!lineItemMap.isEmpty()){
                cloneProductSelectionDetail(PRODSEL_WHERECLAUSE);
            }                         
            outMap.put(STATUSCODE,SUCCESS);    
        }
        catch(DmlException e){
            
            outMap.put(STATUSCODE,FAILURE);
            outMap.put(ERRMSG,e.getMessage());
        }
        catch(exception excn){
            
            outMap.put(STATUSCODE,FAILURE);
            outMap.put(ERRMSG,excn.getMessage()); 
        }
    }   
    /*Method is used IGAP Oppotunity update - KAD 1197*/
    public void igapOpporunityupdate(list<Opportunity> listigap,opportunity oldopp,opportunity newopprecid){
        //date oldOpp366 = oldopp.closedate.addDays(366);
        date oldOpp366 = oldopp.closedate.addyears(1).addDays(1);
        //Integer newoppyear= newopprecid.closedate.year();//Req::1353
        boolean blnupdate = false;
        for(opportunity oppigap:listigap){
            iGapopptids.add(oppigap.id);//mergedwithclone status update
            //Req::1353
            if(newopprecid.closedate == oppigap.closedate){
                setigapnew.add(oppigap.id);
            }
            //Req::1353
            if(oppigap.closedate > oldOpp366){
                blnupdate = true;
                oppigap.ParentOppty__c = newopprecid.id;
            }else if(oppigap.closedate < oldopp.closedate ){
                blnupdate = true;
                oppigap.ParentOppty__c = null;
            }else{
                setIGAPopp.add(oppigap.id);
            }
        }
        if(blnupdate){
            update listigap;
        }   
    }
    
    /* get opportunity related by using record id */
    private Opportunity getOpportunity(string oppid){
        return database.query(STRQRY);
    }  
    /*Renewal & IGAP opportunity stage value update with Merged with Cloned Renewal*/
    public void opportuityStageUpdate(Date effectdate){
        
        List<Opportunity> oppLst = (List<Opportunity>)ANA_UTIL09_QueryObjectData.getObjectData(OPPOBJ,OPPSTAGEUPDATE,STROPPQRY);
        
        for(Opportunity oppupd: oppLst){    
                
            Date dobj =  Date.newInstance(effectdate.year()+1, effectdate.month(), effectdate.Day());           
            if  (   (dobj == oppupd.closedate) && 
                    (
                        oppupd.RecordType.Name == IGAPNAME || 
                        //(([Select Name from Profile where ID =: userinfo.getProfileId()].Name == 'Local Sales') && oppupd.RecordType.Name == 'In Group Add Product Local')
                     (([Select Name from Profile where ID =: userinfo.getProfileId()].Name == 'Local Sales') && oppupd.RecordType.Name == 'In Group Add Product Local') || (([Select Name from Profile where ID =: userinfo.getProfileId()].Name == 'Local Sales Dual') && oppupd.RecordType.Name == 'In Group Add Product Local')
                    )
                ){
                oppupd.StageName = OPPCLONESTATUS;
            }    
            //oppLst.add(oppupd);
        }        
        if(!oppLst.isEmpty()){
            database.update(oppLst);
        }
    }
    /**------------------------------Create Quote ----------------------------------------------------------------**/
    private List<Quote> cloneQuote(Opportunity opp,String crossFields,string whereClause)
    {  
        quoteMap = new map<Id,Id>(); 
        setquotedel = new set<Id>();
        List<Quote> newQuoteLst = new List<Quote>();    
        List<Quote> oldQuoteLst = (List<Quote>)ANA_UTIL09_QueryObjectData.getObjectData(OBJ_QUOTE,QUOTE_CROSSREFFIELDS,QUOTE_WHERECLAUSE);       
        mapQuotegroup = new map<Id,Id>(); //Map contains QuoteId, GroupId
        mapgroupQuote = new map<Id,Id>();//Map contains GroupId, QuoteId       
        for(Quote oldquoterec:oldQuoteLst ){ //Renewal Opportunity Quotes                
            if(!setIGAPopp.contains(oldquoterec.OpportunityId)){
                newQuoteLst.add(cloneNewQuote(opp,oldquoterec));   
                mapgroupQuote.put(oldquoterec.GroupNumber__c,oldquoterec.Id);
                mapQuotegroup.put(oldquoterec.Id,oldquoterec.GroupNumber__c);               
            }
        }
        for(Quote oldquoteigap:oldQuoteLst ){ //IGAP Opportunity quote
            if(setIGAPopp.contains(oldquoteigap.OpportunityId) && !mapgroupQuote.containskey(oldquoteigap.GroupNumber__c)){
                newQuoteLst.add(cloneNewQuote(opp,oldquoteigap));
                mapgroupQuote.put(oldquoteigap.GroupNumber__c,oldquoteigap.Id);
                mapQuotegroup.put(oldquoteigap.Id,oldquoteigap.GroupNumber__c);
            }
        }   
        database.insert(newQuoteLst);        
        for(Quote oldQuote : oldQuoteLst){           
            for(Quote newQuote : newQuoteLst){
                setquotedel.add(newQuote.Id);
                if(oldQuote.Id == newQuote.TECH_QuoteIdForRenewalOpty__c){
                    quoteMap.put(oldQuote.Id,newQuote.Id);
                }
            }           
        }       
        return newQuoteLst;        
    }
    /*This method creates new Quote through cloning*/
    private Quote cloneNewQuote(Opportunity opp,Quote oldquoterec){
        Quote newQuote = oldquoterec.clone(false, true);
        newQuote.OpportunityId = opp.Id;
        newQuote.NumberofOpenProducts__c = ZERO;
        newQuote.NumberofOpenProductsProgramsGROUP__c  =ZERO;
        newQuote.Name=opp.Name +SPACE+oldquoterec.GroupNumber__r.Name;
        newQuote.TECH_QuoteIdForRenewalOpty__c = oldquoterec.Id;
        newQuote.BenefitRenewalAnniversaryDate__c=opp.CloseDate;      
        return newQuote;
    }
    /**------------------------------Create QuoteLineItem -----------------------------------------------------------**/
    private void cloneQuoteLineItems(string whereClause,string crossReferFields){
        List<QuoteLineItem> newQliList   = new List<QuoteLineItem>();
        List<QuoteLineItem> childItemList = new List<QuoteLineItem>();
        ANA_UTIL09_QueryObjectData.stringSet1 = new set<string>(renewalStages);
        ANA_UTIL09_QueryObjectData.stringSet1.addAll(iGapStages);
        List<QuoteLineItem> oldQliList = (List<QuoteLineItem>)ANA_UTIL09_QueryObjectData.getObjectData(OBJ_QUOTELINEITEM,QLI_CROSSREFFIELDS,QLI_WHERECLAUSE);
        lineItemMap = new map<Id,Id>();
        
        // Start : Deloitte Offshore
        // Fix done in order to fix Too Many SOQL Error
        //OppType = ([select ID from User where Profile.Name IN ('Local Sales') and ID =: UserInfo.getUserId()]).isEmpty() ? ANA_RENEWAL: 'Renewal Local';
        OppType = ([select ID from User where Profile.Name IN ('Local Sales','Local Sales Dual') and ID =: UserInfo.getUserId()]).isEmpty() ? ANA_RENEWAL: 'Renewal Local';
       
        //End : Deloitte Offshore
        
        
        for(QuoteLineItem oldQLI : oldQliList){  
                if(setIGAPopp.contains(oldQLI.Quote.OpportunityId) && iGapStages.contains(oldQLI.ProductStage__c)){             
                    if(!mapgroupQuote.isEmpty() && mapgroupQuote.containskey(oldQLI.Quote.GroupNumber__c)){
                        //newQliList.add(cloneNewQLI(oldQLI));
                        if((oldQLI.ParentQuoteLineItem__c !=null  && oldQLI.ParentQuoteLineItem__r.Product2.isActive) && renewalStages.contains(oldQLI.ParentQuoteLineItem__r.ProductStage__c )){
                            newQliList.add(cloneNewQLI(oldQLI));
                        }   
                        if(oldQLI.ParentQuoteLineItem__c == null && oldQLI.Product2.isActive){
                            newQliList.add(cloneNewQLI(oldQLI));
                        }                       
                    }                    
                }else if(!setIGAPopp.contains(oldQLI.quote.OpportunityId) && renewalStages.contains(oldQLI.ProductStage__c)){                   
                    if(!mapgroupQuote.isEmpty() && mapgroupQuote.containskey(oldQLI.Quote.GroupNumber__c)){
                        //newQliList.add(cloneNewQLI(oldQLI));
                        if((oldQLI.ParentQuoteLineItem__c !=null  && oldQLI.ParentQuoteLineItem__r.Product2.isActive) && renewalStages.contains(oldQLI.ParentQuoteLineItem__r.ProductStage__c )){
                            newQliList.add(cloneNewQLI(oldQLI));
                        }   
                        if(oldQLI.ParentQuoteLineItem__c == null && oldQLI.Product2.isActive){
                            newQliList.add(cloneNewQLI(oldQLI));
                        } 
                    }
                }else{               
                }               
        }
        if(!newQliList.isEmpty())
        {
           Database.SaveResult[] results = Database.insert(newQliList, false);
           set<Id> setqliids = new set<Id>();
           set<Id> setquoterecdel = new set<Id>();//Quote delete
           for(Database.SaveResult res:results){
                if(res.isSuccess()){
                    setqliids.add(res.getId());
                }
           }
           list<QuoteLineItem> listqline = new list<QuoteLineItem>();
           listqline = Database.query(STRQLIQRY);           
           if(!listqline.isEmpty()){
                for(QuoteLineItem newQLI : listqline){
                    lineItemMap.put(newQLI.TECH_QuoteIdForRenewalOpty__c,newQLI.Id);
                    setquoterecdel.add(newQLI.QuoteId);
                }
                for(QuoteLineItem newQLI : listqline){                                          
                    if(newQLI.TECH_ParentIdForRenewalOpty__c != null && lineItemMap.get(newQLI.TECH_ParentIdForRenewalOpty__c) != null){
                       newQLI.ParentQuoteLineItem__c = lineItemMap.get(newQLI.TECH_ParentIdForRenewalOpty__c );
                       childItemList.add(newQLI);
                    }
                }
                if(!childItemList.isEmpty()){
                    ANA_QuoteLineItemTrigger_Handler.isRecursiveupdate = false;
                    database.update(childItemList);
                }
           }
           if(!setquotedel.isEmpty()){
                set<Id> permenentQuotedel = new set<Id>();
                for(Id qdel:setquotedel){
                    if(!setquoterecdel.isEmpty() && setquoterecdel.contains(qdel)){}
                    else{permenentQuotedel.add(qdel);}
                }
                if(!permenentQuotedel.isEmpty()){
                    delete[select id from Quote where id IN:permenentQuotedel];
                }
           }
        }else{
            delete[select id from Quote where id IN:setquotedel];
        }
    }
    /*This method creates new QuoteLineItem through cloning*/
    private QuoteLineItem cloneNewQLI(QuoteLineItem oldQLI){  
        QuoteLineItem newQLI = oldQLI.clone(false, true);           
        Id oldquoteId = mapgroupQuote.get(oldQLI.Quote.GroupNumber__c);
        newQLI.QuoteId = quoteMap.get(oldquoteId);       
        newQLI.Probability__c=EMPTY;
        newQLI.TermDate__c=null;
        newQLI.Federal_Mental_Health_Parity_ASO__c=null;
        newQLI.Renewed_with_Changes__c=null;
        newQLI.Federal_Mental_Health_Parity_FI_Min_Prem__c=null;
        newQLI.Federal_Mental_Health_Parity_UW_Review__c=null;  
        if(oldQLI.ProductStage__c == ANA_STG_IGAPSOLD){
            //newQLI.NOUFlag__c = true;
        }else{
            newQLI.Competitor__c=null;
            newQLI.CompetitorStatus__c=EMPTY;
            newQLI.Reason__c=EMPTY; 
        }
        if(!((!setigapnew.isEmpty() && setigapnew.contains(oldQLI.Quote.OpportunityId)) && (oldQLI.ProductStage__c == ANA_STG_IGAPINPRGS || oldQLI.ProductStage__c == ANA_STG_IGAPSOLD))){
            newQLI.ProductStage__c=ANA_STG_INPRGS;
        }
        newQLI.ProductLineApprovalStatus__c=ANA_NOT_STARTED;
        newQLI.TECH_QuoteIdForRenewalOpty__c = oldQLI.Id;
        newQLI.PLComplete__c=false;
        newQLI.IsthisRenewalOpportunityCloned__c=true;
		newQLI.Is_Existing_Product__c = true; //added for PRDCRM-42547 
        newQLI.ProgramLines__c= ZERO;
        newQLI.ProductSelections__c= ZERO;
        newQLI.TECH_ParentIdForRenewalOpty__c = oldQLI.ParentQuoteLineItem__c;
        newQLI.ParentQuoteLineItem__c = null;
        
        // Start : Deloitte Offshore
        // Fix done in order to fix Too Many SOQL Error
        newQLI.OppType__c = OppType;
        // End : Deloitte Offshore
        // Start : PRDCRM-24777 Uncheck fields - 'RDRC Configuration Complete' and 'VSOC Configuration Complete' | X-Men
        newQLI.VSOC_Configuration_Complete__c = False;
        newQLI.RDRC_Configuration_Complete__c = False;
        // End : PRDCRM-24777 Uncheck fields - 'RDRC Configuration Complete' and 'VSOC Configuration Complete' | X-Men 
        
        // PRDCRM-38679 Populate null value for Reason in Quote Products
        newQLI.Reason__c = '';
        return  newQLI; 
    }
    /**------------------------------Create Alternate Network -----------------------------------------------------------**/
    private void cloneAlternateNetwork(string whereClause){
        List<AlternateNetwork__c> newANList   = new List<AlternateNetwork__c>();      
        List<AlternateNetwork__c> oldANList = (List<AlternateNetwork__c>)ANA_UTIL09_QueryObjectData.getObjectData(OBJ_ALTERNATENW,null,ALTNW_WHERECLAUSE);
        System.debug('oldANList'+oldANList);
        for(AlternateNetwork__c oldAN : oldANList){             
            AlternateNetwork__c newAN = oldAN.clone(false, true);
            if(lineItemMap.get(oldAN.QuoteLineItem__c)!= null){
                newAN.QuoteLineItem__c = lineItemMap.get(oldAN.QuoteLineItem__c);             
                newANList.add(newAN);
            }                                   
        }        
        database.insert(newANList);                  
    }    
    /**------------------------------Create ProductSelectionDetail-----------------------------------------------**/
    private void cloneProductSelectionDetail(string whereClause){
        List<ProductSelectionDetail__c> newPSList   = new List<ProductSelectionDetail__c>();        
        List<ProductSelectionDetail__c> oldPSList = (List<ProductSelectionDetail__c>)ANA_UTIL09_QueryObjectData.getObjectData(OBJ_PRODSELDETAIL,null,PRODSEL_WHERECLAUSE);
        for(ProductSelectionDetail__c oldPS : oldPSList){             
            ProductSelectionDetail__c newPS = oldPS.clone(false, true);
            if(lineItemMap.get(oldPS.QuoteLineItem__c)!= null){
                newPS.QuoteLineItem__c = lineItemMap.get(oldPS.QuoteLineItem__c);             
                newPSList.add(newPS);
            }                                   
        }        
        database.insert(newPSList);                  
    }   
}
trigger trigger1 on Contact (after update) {

    Map<ID,string> accLeadsourceMap = new Map<ID,string>();
    for(Contact c : Trigger.New){
        accLeadsourceMap.put(c.Accountid,c.LeadSource);
    }
    system.debug('accLeadsourceMap : ' + accLeadsourceMap.keyset());
    List<Opportunity> oppList = [select id,LeadSource,Account.id from Opportunity where Account.id in :accLeadsourceMap.keyset()];
    for(Opportunity opp :  oppList ){
        opp.LeadSource=accLeadsourceMap.get(opp.account.id);
    }
    update oppList;
}
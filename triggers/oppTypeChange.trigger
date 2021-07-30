trigger oppTypeChange on Account (after update) {
    
    set<Id> AccIdSet= new set<Id>();
    List<Opportunity> oppList  = new List<Opportunity>();
        for(Account acc1:Trigger.new){
            
            if(acc1.Type=='Prospect'){
                AccIdSet.add(acc1.id);    
                }
            
            }
      List<Opportunity> opp = [Select id,Type from Opportunity where AccountID In:AccIdSet];
        
        if(opp!=Null && opp.size()>0){
            for(Opportunity op1:opp){
            
            op1.Type='New Customer';
            oppList.add(op1);
            
            }
        }
        Update oppList;
    }
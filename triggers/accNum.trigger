trigger accNum on Account (after update) {
        
        //list<id> accountids = new list<id>();
        
        Map<id, string> de = new Map<id, string>();
        
        for(account a: trigger.new){
            if(a.accountNumber != trigger.oldmap.get(a.id).accountnumber){
                //accountids.add(a.id);
                de.put(a.id, a.accountnumber);
            }
        }
        
        List<opportunity> opps = [select id,Description,account.id from opportunity where Account.id in : de.keyset()];
        
        for(opportunity o : opps){
            o.description = de.get(o.account.id);
        }
        
        update opps;
        
        }
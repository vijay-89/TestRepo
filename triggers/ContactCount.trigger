//To count number of contacts on an Account object

trigger ContactCount on Contact (after update,after delete, after undelete, after insert) {
    
    list<id> accId = new list<id>();
    if(trigger.isinsert){
        
        for(Contact con:Trigger.New){
            accId.add(con.accountId);
        }
    
    }
    
        if(trigger.isUpdate){
        
        for(Contact con:Trigger.New){
            accId.add(con.accountId);
        }
    
          }
    
        if(trigger.isDelete){
        
        for(Contact con:Trigger.old){
            accId.add(con.accountId);
        }
    
    }
    
        if(trigger.isUndelete){
        
        for(Contact con:Trigger.New){
            accId.add(con.accountId);
        }
    
    }
    
    
    if(!accId.isEmpty()){
        list<account> accList = [SELECT id, Contact_Count__c, (SELECT ID FROM contacts) From Account WHERE ID IN: accId];
        
        for(account a: accList){
            a.Contact_Count__c = a.contacts.size();
        }
        
        update accList;
    }
    

}
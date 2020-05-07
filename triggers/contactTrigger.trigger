trigger contactTrigger on Contact (before Insert) {

List<Id> l1 = new List<Id>();
    
    for(Contact con: Trigger.new){
        l1.add(con.AccountId);
        }
    List<Account> ac1= [Select Id,Name,(Select Id,Name from Contacts) from Account where id in:l1];
        
       for(Contact cc:Trigger.New) {
        for(Account ac2: ac1){
                if(ac2.contacts.size()>1){
                    cc.addError('Cannot Add more than one Contact to this Account');
                }
        
        }
      }

}
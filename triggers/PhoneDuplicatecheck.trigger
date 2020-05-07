trigger PhoneDuplicatecheck on Contact (before insert, after insert,before update,after update,before delete,after delete,after undelete) {
    
        list<Contact> toUpdate = new list<contact>();
     if(trigger.isinsert && trigger.isbefore){
              
        List<ID> ConId= new List<ID>();
        List<contact> toDel = new List<contact>();
        
        for(Contact con:Trigger.new){   
            ConId.add(con.AccountId);
        }  
        
        List<Contact> ListCon1 = [select Id,Name,Phone,email,AccountId,lastName from Contact where AccountId IN: ConId and isDeleted = false];
        
        for(Contact newContact : Trigger.new){
            for(Contact oldContact : ListCon1){
                if(newContact.AccountId == oldContact.AccountId){
                    if(oldContact.Phone == newContact.Phone){
                        newContact.email = oldContact.email;
                        newContact.lastName = oldContact.lastName;
                        
                        toDel.add(oldContact);
                        //newContact.Name = oldContact.Name;
                       Break;
                    }
                    else{
                    }
                }
            }
        
        }
    delete toDel;
    }

}
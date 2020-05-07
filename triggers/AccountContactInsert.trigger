//create contact while creating an account

trigger AccountContactInsert on Account (after insert,before insert,after update) {
    List<Contact> contactList = new List<Contact>();
 
 
 if(trigger.isinsert && trigger.isbefore){
 
  Set<String> accNames = new Set<String>();
  List<Account> accList = [select id,name from Account];
 
  for(Account acc : accList){
   accNames.add(acc.name);
  }
  for(Account acc: Trigger.new){
   if(accNames.contains(acc.Name)){
    acc.addError('Another Account already exists with the same name');
   }
  
  }
 
    }
    
Set<ID> accIDS = new Set<ID>();
    for(Account acc1:Trigger.new) {
 
  accIDS.add(acc1.id);
    
       if(trigger.isinsert && trigger.isafter){
            Contact con = new Contact();
            con.Accountid = acc1.id;
            con.LastName = 'Ajay';
            contactList.add(con); 
            
            
            if(StaticFlagClass.flag1){
            StaticFlagClass.flag1=false;
             Account acc2 = new Account();
             acc2.Name = acc1.Name+'--2';
             insert acc2;
             }
            
        }
  
   
    
    }
 
 if(!contactList.isEmpty()){
    insert contactList;
    }

 List<Contact> updateCon = new List<contact>();
 
 if(Trigger.isAfter && Trigger.isupdate){
 
    Map<id,Account>  AccountCons = new Map<id,Account>([select id,name,phone,(select id,name,phone from Contacts) from Account where ID IN:accIDS limit 50000]);
    
        for(Account acc : Trigger.New){
  
   Account accNew = AccountCons.get(acc.id);
   if(accNew.contacts.size()>0){
   for(Contact con : accNew.Contacts){
    Contact con2 = con;
    con2.phone = acc.Phone;
    updateCon.add(con2);
   
   }
  }
  }     
 
   if(!updateCon.isEmpty()){
    update updateCon;
   }
 }
    
}
trigger duplicateUser on User (before insert, before update) {
    
    Set<String> userset = new Set<String>();
    Set<String> userid = new Set<String>();
    Map<String, String> usermap = new Map<String,String>();
    List<User> userlist = new List<User>();
    for(user u : trigger.new){
        userset.add(u.email);
        if(Trigger.isUpdate){
            userid.add(u.id);
        }
       
    }
    userlist = [select id,name,email,Duplicate_User__c from user where email IN:userset and id <>:userid];
    for(user u2:userlist){
         usermap.put(u2.email,u2.id);
    }
    
    for(user u1: trigger.new){
      if (usermap.containsKey(u1.email)){
          if(usermap.get(u1.email)!=u1.id) 
              u1.Duplicate_User__c = true;
      }
    
    }
}
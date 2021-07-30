trigger Scenario13 on Account (before Update) {
    string names;
    list<Contact>c=[SELECT id, lastname FROM Contact];
    for(account acct:trigger.new){
        names=acct.name;
    
    }
   
    for(contact con:c){
        con.lastname=names;
        system.debug('con.lastname--->'+con.lastname);
    }
    update c;
}
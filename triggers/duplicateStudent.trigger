trigger duplicateStudent on Student__c (before insert) {
    
        set<string> l1 = new set<string>();
        List<Student__c> l2= [select Name from Student__c];
        system.debug('l2--->'+l2);
        for(Student__c l3:l2){
            l1.add(l3.Name);
            }
        
        for(Student__c l4 : Trigger.new){
            if(l1.contains(l4.Name)){
                l4.addError('Another Account already exists with the same name');
                }
        
        }
    }
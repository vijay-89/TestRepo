//to update student result on Mark object based on student marks

trigger StudentResult on Student__c (after insert, after update) {

    if(trigger.isafter && trigger.isinsert){
    
    List<Mark__c> l1 = new List<Mark__c>();
    
        for(Student__c stu: trigger.new){
            Mark__c m1 = new Mark__c();
            m1.StudentName__c = stu.ID;
            m1.Name = stu.Name;
            
            if((stu.S1__c+stu.S2__c)>=50){
                m1.Result__c = 'Pass';  
            }else{
                 m1.Result__c = 'Fail'; 
            }
            
            l1.add(m1);
        }
            Insert l1;    
    }
    
    
  if(trigger.isafter && trigger.isupdate){
  
        List<Mark__c> mInsert = new List<Mark__c>();
         
        list<Mark__c> mUpdate=new list<Mark__c>();
        
        list<Mark__c> maList =new list<Mark__c>();
        
        List<Mark__c> marks = [SELECT ID, StudentName__c, Result__c FROM Mark__c WHERE StudentName__c IN: trigger.newMap.KeySet()];
        map<id,list<Mark__c>> stuMarkMap = new map<id,list<Mark__c>>();
        set<id> idSet = new set<id>();
        
        for(Mark__c m: marks){
            idSet.add(m.StudentName__c);
        }
        
        for(id i : idSet){
            for(Mark__c m : marks){
                if(m.StudentName__c == i){
                    maList.add(m);
                }
            }
            if(!maList.isEmpty()){
                stuMarkMap.put(i,maList);
            }
        }
          
        for(Student__c stu: Trigger.new){
        if(!stuMarkMap.isEmpty()){        List<Mark__c> marksList = stuMarkMap.get(stu.id);
            //system.debug('marksList :'+marksList);
                  if(!marksList.isEmpty()){
                   marksList[0].StudentName__c = stu.id;
                   
                       if((stu.S1__c+stu.S2__c)>=50){
                   
                        marksList[0].Result__c='Pass';
                        
                        }
                        else{
                        marksList[0].Result__c='Fail';
                        } 
                        mUpdate.add(marksList[0]);
                    }
                    else{
                         mark__C m1= new mark__C();
                         m1.StudentName__c = stu.id;
                       
                          if((stu.S1__c+stu.S2__c)>=50){
                       
                            m1.Result__c='Pass';
                            
                            }
                            else{
                            m1.Result__c='Fail';
                            } 
                            mInsert.add(m1);
                     }
            }
             else{
                 mark__C m1= new mark__C();
                 m1.StudentName__c = stu.id;
               
                  if((stu.S1__c+stu.S2__c)>=50){
               
                    m1.Result__c='Pass';
                    
                    }
                    else{
                    m1.Result__c='Fail';
                    } 
                    mInsert.add(m1);
             }
        }
            update mUpdate;
            insert mInsert;
    }
    


}
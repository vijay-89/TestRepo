trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
List<Task> t1 = new List<Task>();


for(Opportunity o: Trigger.new){

if(o.StageName == 'Closed Won'){

Task t = new Task();

    t.Subject = 'Follow Up Test Task';
    t.Status = 'In Progress';
    t.WhatId=o.Id;
    t1.add(t);

    }
    
    
 
 }
 if(t1.size() > 0){
        insert t1;

        }
 
 }
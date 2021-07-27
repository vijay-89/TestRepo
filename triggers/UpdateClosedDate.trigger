trigger UpdateClosedDate on Defect__c (before update) {

    List<Defect__c> oldDef = new List<Defect__c>((Defect__c[])Trigger.old);
    List<Defect__c> newDef = new List<Defect__c>((Defect__c[])Trigger.new);  

    String  CurStat = newDef.get(0).Current_status__c;
    String  PrevStat = oldDef.get(0).Current_status__c;
    
    if(CurStat != null && CurStat.length()>=6){
        
        CurStat = newDef.get(0).Current_status__c.substring(0,6); 
    }
    
    if(PrevStat != null && PrevStat.length()>=6){
        
        PrevStat = oldDef.get(0).Current_status__c.substring(0,6);    
    }
    
    if(CurStat != null && CurStat.equalsIgnoreCase('CLOSED')){ //Check for Null done by Accenture-MCS Code Scan PRDCRM-44931
        newDef[0].Target_Completion_Date__c = null;
        if(PrevStat != null && newDef[0].Closed_Date__c != null && !PrevStat.equalsIgnoreCase('CLOSED')){ //Check for Null done by Accenture-MCS Code Scan PRDCRM-44931
            newDef[0].Closed_Date__c = datetime.now();
        }
    }
    
    if(CurStat != null && PrevStat != null && !CurStat.equalsIgnoreCase('CLOSED') & PrevStat.equalsIgnoreCase('CLOSED')){ //Check for Null done by Accenture-MCS Code Scan PRDCRM-44931
        newDef[0].Closed_Date__c = null;
    }
}
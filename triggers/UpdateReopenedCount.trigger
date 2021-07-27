trigger UpdateReopenedCount on Defect__c (before update) {

    List<Defect__c> oldDef = new List<Defect__c>((Defect__c[])Trigger.old);
    List<Defect__c> newDef = new List<Defect__c>((Defect__c[])Trigger.new);
    
    String  CurStat = newDef.get(0).Current_status__c;
    String  PrevStat = oldDef.get(0).Current_status__c;
    Decimal ReopenCount;
    
    if (oldDef.get(0).Times_Reopened__c <> null){
        ReopenCount = oldDef.get(0).Times_Reopened__c;
    }
    
    else{
        ReopenCount = 0;
    }
    if(CurStat != null && CurStat.length()>=9 ){
        
        CurStat = newDef.get(0).Current_status__c.substring(0,9);       
    }
    
    if(PrevStat != null && PrevStat.length()>=9 ){ 
        
        PrevStat = oldDef.get(0).Current_status__c.substring(0,9);            
    }
    
    if(CurStat != null && PrevStat !=null && CurStat.equalsIgnoreCase('RE-OPENED') & !PrevStat.equalsIgnoreCase('RE-OPENED')){ //Check for Null done by Accenture-MCS Code Scan PRDCRM-44931
        
        newDef[0].Times_Reopened__c = ReopenCount + 1;  
    }
}
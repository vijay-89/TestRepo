public class myclass {

    private ApexPages.standardController controller;
    public myclass(ApexPages.StandardController controller) {

    this.controller=controller;
    }
    object__c obj = new object__c();

  
    public PageReference Save() {
    this.controller.save();
    
       IF(obj.Check__c== true){
       
           obj.Description__c= obj.Country_Name__c+' ' + obj.Select_State__c+ '  ' + obj.Comments__c;
       
       }
       ELSE{
           obj.Description__c= obj.Comments__c;
       
       }
    
    
        INSERT obj;
        return null;
    }

    
    
}
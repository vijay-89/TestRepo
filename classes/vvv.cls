public class vvv {

public customS1__c v1{set;get;}

public vvv(){

v1 = [SELECT Project_Owner__c FROM customS1__c WHERE Name ='Record1']; 

}


}
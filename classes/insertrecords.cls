public class insertrecords{

public insertrecords(){

custom1__c c1 = new custom1__c();
c1.Name = 'karun';
c1.Pan_Number__c = 'qsc';
c1.License_Number__c = 'plm';
insert c1;

system.debug(c1);

}
}
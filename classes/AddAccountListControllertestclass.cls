@isTest
public class AddAccountListControllertestclass{

public static testmethod void test1(){

AddAccountListController  aacc = new AddAccountListController ();
List<Account> ac = new List<Account>();

Account acc1 = new Account();
acc1.Name= 'qqq';
acc1.AccountNumber = '11111';
acc1.SLA__c = 'Gold';
acc1.SLASerialNumber__c = '1111111';
acc1.SLAExpirationDate__c = System.today() + 5;
insert acc1;

Account acc= new Account();
acc = [select Name,Id,AccountNumber from Account limit 1];
Account accList =   [select Name,Id,AccountNumber from Account order by LastModifiedDate desc limit 10];
test.startTest();
aacc.SaveAccount();
aacc.SetRecord();
test.stopTest();
}

}
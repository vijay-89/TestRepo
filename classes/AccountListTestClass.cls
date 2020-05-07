//Created by Vijay...
@isTest
public class AccountListTestClass{

public static testmethod void test1(){

AccountList aacc = new AccountList();

Account acc1 = new Account();
acc1.Name= 'qqq';
acc1.AccountNumber = '11111';
acc1.SLA__c = 'Gold';
acc1.SLASerialNumber__c = '1111111';
acc1.SLAExpirationDate__c = System.today() + 5;
insert acc1;

test.startTest();
aacc.Method1();
test.stopTest();
}
}
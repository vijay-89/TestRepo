@isTest

public class HelloWorldTriggerTest{
public void validateHelloWorld() {

Account acc = new Account();
acc.Name = 'Ajay';
insert acc;
    
    acc = [SELECT Name from Account where ID = :acc.ID];
    System.debug('account name: ' + acc.Name);


    }
    }
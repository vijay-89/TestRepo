@isTest
public class ContactListTestClass{

public static testmethod void test1(){

ContactList con = new ContactList();

Contact con1 = new Contact();
con1.LastName= 'Contact1';
insert con1;

test.startTest();
con.Method1();
test.stopTest();
}
}
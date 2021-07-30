@isTest


public class test1{

    public static void method11(){
    
    Account a = new Account(Name = 'sunil');
    insert a;
    test.starttest();
    example e = new example();
    e.method1();
    system.debug(a.Name);
    Account b = [select Name from Account WHERE ID =:a.id];
    system.assertequals('sunilvijay' , b.Name);
    }
    


}
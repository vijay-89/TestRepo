public class accountrecords{

public List<Account> l1{get;set;}


public accountrecords(){

l1 = [Select Name,AccountNumber from Account];

}





}
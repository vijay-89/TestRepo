public class AccountList {

     public List<Account> accList {get;set;}
    public Account acc{get;set;}
    
    public void Method1(){
        acc= new Account();
        //testing 123
    accList =   [select Name,Id,AccountNumber from Account order by LastModifiedDate desc limit 10];
    }
    }

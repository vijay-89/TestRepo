public class AddAccountListController {


    public List<Account> accList {get;set;}
    public Account acc{get;set;}
    
    public AddAccountListController (){
        acc= new Account();
    accList =   [select Name,Id,AccountNumber from Account order by LastModifiedDate desc limit 10];
    }

    public PageReference SaveAccount(){
        insert acc;
        accList =   [select Name,Id,AccountNumber from Account order by LastModifiedDate desc limit 10];
        return Null;
    }
    
    public PageReference SetRecord(){
    
        acc.Name = '';
        acc.AccountNumber = '';
        //acc.Address= '';
        return NULL;
    }

}
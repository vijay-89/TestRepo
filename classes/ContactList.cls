//Created by Vijay 
public class ContactList {

     public List<Contact> conList {get;set;}
    public Contact con{get;set;}
    
    public void Method1(){
        con= new Contact();
    conList =   [select  LastName,Id from Contact order by LastModifiedDate desc limit 10];
    }
    }
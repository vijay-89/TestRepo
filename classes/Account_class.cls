public class Account_class { 
public List<account> acct{get; set;}
public Account_class(){
acct = [Select ID, Name, Phone From ACCOUNT];
}
public PageReference save() {
        return null;
    }
}
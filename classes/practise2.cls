public class practise2 {

//public List<Account> acc1{get;set;}
public Account ac{get;set;}

public practise2(){
ac=new Account();

}

public pagereference save(){
pagereference pg = new pagereference('https://c.ap2.visual.force.com/apex/practise1');
insert ac;

return pg;
}

public list<Account> getacc1(){
list<Account> acc1= database.query('select Name from Account'); 
return acc1;
}



}
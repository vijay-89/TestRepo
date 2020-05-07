public class MarksUpdate {

public List<Mark__c> MarkTable {get;set;}
public List<Student__c> StudentTable {get;set;}
public Student__c stu {get;set;}
public string name{get;set;}
public integer marks1{get;set;}
public integer marks2{get;set;}

    public MarksUpdate(ApexPages.StandardController controller) {
    
   // stu= new Student__c();
    MarkTable =new List<Mark__c> ();
    MarkTable= [Select Name,Result__c,StudentName__c from Mark__c];
    
    StudentTable=new List<Student__c>();
    StudentTable= [Select Name,S1__c,S2__c from Student__c];
        
    
    }
    
      public PageReference SaveAccount(){
      
      student__c stu = new student__c();
      stu.Name=name;
      stu.S1__c=marks1;
      stu.S2__c=marks2;
        insert stu;
        StudentTable =   [Select Name,S1__c,S2__c from Student__c order by LastModifiedDate desc];
        return null;
    }
    
    
    

}
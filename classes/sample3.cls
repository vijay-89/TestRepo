public class sample3 {
    public string name{set;get;}
    public string city{set;get;}
    public string description{set;get;}
    public sample3(){
     //  description=name+''+city;
        
    }

   public pageReference mth(){

       description=name+''+city;
       pageReference pg=new PageReference('/apex/sample3vf2');
       return pg;
      // return null;
    } 
}
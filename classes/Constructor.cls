public class Constructor{

    public Constructor(integer d, String a){ //This is default Constructor 
  
    System.debug('Hey I am a default constructor');
  
 }
  
    public Constructor(String a, integer b){ //This is default Constructor 
          
        System.debug('Hey I am a overloaded constructor');
        System.debug('this is string a ='+a);
        System.debug('this is integer b ='+b);
    }
 public void method1(){
    System.debug('Hey I am a normal method');
     
  
 }



    
}
public class power{

List<integer> l2 = new List<integer>();

public  power(integer a, integer b){
    integer output = a;
   l2.add(a);
   for(integer c=2;c<=b; c++) {
   output = output*a;
   l2.add(output);
   
   }  
   
   
   
   system.debug('power numbers are' + output);
   
   system.debug('power numbers are' + l2);
   
   integer sum = 0;
   for(integer z:l2){
   sum = sum+z;
   
   }


system.debug(sum);


}



}
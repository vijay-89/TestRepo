public class class1{

List<integer> l1 = new List<integer>();

    public class1(integer n){
    integer count = 0;
    for(integer i=2;i<=n;i++){
            for(integer j=1; j<i; j++){
            
                   if(math.mod(i,j)==0) 
                   count++;
                   }
               if(count == 1){
               l1.add(i);
           
                       }
    count=0;  
    }
    
    system.debug('the even numbers are' + l1);
    
    }
    
    public void add(){
    integer sum=0;
    for(integer a:l1){
    
    sum=sum+a;
    
    }
    
    system.debug('sum values are' + sum);
    
    }

}
public class PrimeNumbers{

public string primes(){

    integer count = 0;     //This integer stores the no of exact divisors for each number    
    String listOFPrimes = 'The list of Prime numbers are '; // This is for storing prime numbers 
    for(integer i=2;i<10;i++){// THis is outer for loop
        for(integer j=1;j<=i;j++){     // This is inner for loop
        integer reminder = math.mod(i,j);
        if(reminder==0){ // Checking if i is prime number or not 
    count++;
        }
    
    }
       if(count==2){
    listOFPrimes = listOFPrimes+i+',';    
        }
      count =0; // Re- assigning th value of count to 0 for other value of i    
    }

    return listOFPrimes;
}
}
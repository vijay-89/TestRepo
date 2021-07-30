public class MethodParametrs2 {
    integer d;
    integer g;
    
    public Integer divisionmethod(integer b, integer c){
        
        d = b/c;
        
        return d;
                
    }
    
    public Integer divisionmethod(){
        
        integer e = 20;
        integer f = 10;
        g = e/f;
        return g;
    }
     
    public Integer divisionmethod(integer a){
        
        integer e = 20;
        integer f = 10;
        g = e/f;
        return g;
    }
    
    public static void main(String args1){
        integer b = 10;
        integer c = 2;
        MethodParametrs2 obj1 = new MethodParametrs2();
        System.debug('the value of divisionMethod1 is '+obj1.divisionmethod());
        System.debug('the value div is '+obj1.divisionmethod(b,c));
        
    }

}
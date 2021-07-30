Public Class staticExample{


static{
System.debug('Hi Iam a static block');
//ANy code or logic written here will be executed first. 
//Even before a controller this gets called 
}
    

    public staticExample(){
System.debug('Hi iam a constructor');

}

public static void staticMethod1(){
System.debug('HI iam a static method');
System.debug('You dont need a object to call me');
System.debug('You can call me directly');   

}


}
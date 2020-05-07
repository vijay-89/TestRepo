public class callingclass2{

public void calling2(){
sumof2numbers obj2 = new sumof2numbers();
integer c = obj2.addition();
System.debug(c);
}

public void call(){

callingclass1 objj = new callingclass1();
objj.calling1();
}


}
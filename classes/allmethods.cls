public class allmethods{

//starting with forloop constructor

public allmethods(integer a){
integer c;
for(integer i=1; i<=10; i++){
c = a*i;
System.debug('the multiplication numbers are'+c);
}
}

// static method listinforloop

static void listInForloop(){

List<String> strl1 = new List<String>();
strl1.add('hi');
strl1.add('how');
strl1.add('are');
strl1.add('you');
for(string s :strl1)
{
System.debug('THis is string'+s);
}

}
public void callmethod(){

callingclass2 cc2 = new callingclass2();
cc2.calling2();

}

}
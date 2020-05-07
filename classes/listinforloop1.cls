public class listinforloop1{

public void listmethod(){
List<String> forl = new List<String>();

forl.add('Vijay');
forl.add('is');
forl.add('a');
forl.add('salesforce');
forl.add('developer');


for(String s1 : forl){
System.debug('All words together' + s1);
}
}

}
public class listinforloop{
 
 public void method1(){
 
 for(integer i=0;i<=10;i++){
  
System.debug('THis is number '+i);
  
  }
  
  List<String>  strList = new List<String>();
  
  strList.add('A');
  strList.add('B');
  strList.add('C');
  strList.add('D');
  strList.add('E');
  strList.add('F');
  
  for(String s : strList){
System.debug('THis is alphabet '+s);
  }
}
}
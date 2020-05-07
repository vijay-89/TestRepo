public class mapclass{

public void mapmethod(){

map<integer,string> map1 = new map<integer,string>();
map1.put(1, 'vijay');
map1.put(2,'ajay');
map1.put(1, 'vijay');
}

public void listmethod(){

List<string> list1 = new List<string>();
list1.add('vijay');
list1.add('ajay');
list1.add('vijay');

set<string> set1 = new set<string>(list1);
System.debug('the result is ' + list1);
System.debug('the result is ' + set1);

}


}
public class class111 {

    public string country{set;get;}
    public string state{set;get;}
    public string comments{set;get;}
    public boolean CHECK{set;get;}
    public List<selectoption> l1 {set;get;}
    
    public class111(){
      	l1 = new List<selectoption>();
        selectoption s1 = new selectoption('None','None');
        l1.add(s1);
        selectoption s2 = new selectoption('Ind','India');
        l1.add(s2);
        selectoption s3 = new selectoption('AUS','Australia');
        l1.add(s3);
        selectoption s4 = new selectoption('USA','United States');
        l1.add(s4);
        
    }    
}
trigger automaticCreationOfRecord on Trail__C (before insert) {
   List<Custom1__C> l1= new List<Custom1__C>(); 
  
  for(Trail__C t: Trigger.New){
  Custom1__C c =new Custom1__C(Name = t.Name);
  l1.add(c);
   
  }
    insert l1;
  }
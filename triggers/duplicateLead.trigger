trigger duplicateLead on Lead(before insert){
set<string> l1 = new set<string>();
List<Lead> l2= [select Email,Name from Lead];

for(Lead l3:l2){
l1.add(l3.Name);
}

for(Lead l4 : Trigger.new){
if(l1.contains(l4.Name)){
l4.addError('Another Account already exists with the same name');
}

}
}
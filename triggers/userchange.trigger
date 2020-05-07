trigger userchange on Lead(before update){

//UserUpdate__c u1 = UserUpdate__c.getValues('User1');
//u1.OwnerId__c

 //if (Trigger.new[0].OwnerId != '005280000028J3v')
 // {
 //      Trigger.new[0].OwnerId.addError('ownership cannot be changed to User1');
 // }

for (Lead a : Trigger.new)
  {
    if (a.OwnerId =='005280000028dge')
    {
      a.addError('Cannot transfer ownership of Account');
    }
  }

}
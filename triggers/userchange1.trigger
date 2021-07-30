trigger userchange1 on Account(before update){

UserUpdate__c u1 = UserUpdate__c.getValues('User1');


 //if (Trigger.new[0].OwnerId != '005280000028J3v')
 // {
 //      Trigger.new[0].OwnerId.addError('ownership cannot be changed to User3');
 // }

for (Account a : Trigger.new)
  {
    if (a.OwnerId == u1.OwnerId__c)
    {
      a.addError('Cannot transfer ownership of Account to User3');
    }
  }

}
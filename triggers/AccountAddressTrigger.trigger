trigger AccountAddressTrigger on Account (before insert) {

List<Account> acc1 = new List<Account>();
for(Account acc2:Trigger.new)
if(acc2.Match_Billing_Address__c == true){

acc2.ShippingPostalCode =acc2.BillingPostalCode;

}

}
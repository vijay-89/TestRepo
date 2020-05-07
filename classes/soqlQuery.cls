public class soqlQuery{

        public void method1(){
        List<custom1__c> acc = [select Name from custom1__c Limit 10];
        for(custom1__c s:acc){
        system.debug('the records are' + s + 'vijay');
        }
        
        }

}
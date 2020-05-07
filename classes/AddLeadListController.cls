public class AddLeadListController {

        public integer counter=0;
        public integer list_size=5;
        public integer total_size{get;set;}
        public List<Lead> lelist{get;set;}
        public Lead lea{get;set;}
        public boolean table{get;set;}
        public string Name{get;set;}
        //  public custom_setting_new__c cus{get;set;}
        
        public string str1{get;set;}
        
        public List<Lead> getLeadList(){
            
            lelist= [select Status,LastName,Company,Company_Phone__c,Project_Owner__c from Lead ORDER BY createdDate DESC NULLS LAST limit:list_size offset:counter ];
            return lelist;
            }
        
        public AddLeadListController(){
     //   cus= New custom_setting_new__c();
     //  str1=custom_setting_new__c.getvalues('Abhiram project').Project_Owner__c;
        
            lea = new lead();
            total_size = [select count() from Lead];
            }
        
        public PageReference SaveAccount(){
            table=True;
            if(Name!='--None--'){
                str1=custom_setting_new__c.getvalues(Name).Project_Owner__c;
                lea.Project_Owner__c = str1;
                }
            system.debug('lea---->'+lea);
            insert lea;
       //     cus= custom_setting_new__c.getvalues(cus.Name);
            ResetPage();
            return Null;
        }
        
        public PageReference ResetPage(){
            try{
            lea = new lead();
           /* lea.Company= '';
            lea.LastName='';
            lea.Company_Phone__c ='';
            lea.Status=''; */
           
            return NULL;
            }catch(exception e){
                return null;
            }
            
        }
   
        public PageReference  Previous() {

            counter -= list_size;
          return null;
            }

        public PageReference Next() {
              counter = counter+ list_size;
              system.debug('counter  :'+counter );
               system.debug('list_size:'+list_size);

          return null;
             } 
             
        public PageReference  First() {
            counter = 0;
          return null;
            
        }   
        
        public PageReference  Last() {
              
                counter = total_size - math.mod(total_size, list_size);
              return null;
                }
                
        public Boolean getDisablePrevious() { 
                      if (counter>0){
                               return false; 
                               }else {
                               return true;
                       }
           }

        public Boolean getDisableNext() { 
              if (counter + list_size < total_size){
              return false; }
              
              else {
              return true;
              }
           }
         
    public Integer getPageNumber() {
        return counter/list_size + 1;
        }

    public Integer getTotalPages() {
          if (math.mod(total_size, list_size) > 0) {
             return total_size/list_size + 1;
          } else {
             return (total_size/list_size);
          }
        } 
     
     public pagereference ShowTable() { 
     table=true;
     return null;
     
     }
     
     public pagereference HideTable() {
     table=false;
     return null; 
     } 
     
     public List<SelectOption> getCutom1(){
     
         List<SelectOption> options = new List<SelectOption>();
         options.add(new SelectOption('--None--','--None--'));
         List<custom_setting_new__c> cs1=custom_setting_new__c.getall().values();
         
         for(custom_setting_new__c opt: cs1){
             options.add(New selectOption(opt.name,opt.name));
         
         }
         return options;
     
     } 
       
    }
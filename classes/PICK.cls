public class PICK
{
    public Boolean CHECK{set;get;}
    
    public String Country {get;set;}
    public String State {get;set;}
    public String COMMENTS {get;set;}
    public String DESCRIPTION {get;set;}

    public List<SelectOption> getCountries()
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--- None ---'));       
        options.add(new SelectOption('INDIA','INDIA'));
        options.add(new SelectOption('USA','USA'));
        options.add(new SelectOption('NEWZEALAND','NEWZEALAND'));
        options.add(new SelectOption('AUSTRALIA','AUSTRALIA'));
       
        return options;
    }
   
    public List<SelectOption> getstates()
    {
        List<SelectOption> options = new List<SelectOption>();
        if(Country == 'INDIA')
        {      
            options.add(new SelectOption('ANDHRA PRADESH','ANDHRA PRADESH'));
            options.add(new SelectOption('TELANGANA','TELANGANA'));
            options.add(new SelectOption('KARNATAKA','KARNATAKA'));
        }
        else if(Country == 'USA')
        {      
            options.add(new SelectOption('TEXAS','TEXAS'));
            options.add(new SelectOption('CALIFORNIA','CALIFORNIA'));
            options.add(new SelectOption('NEW YORK','NEW YORK'));
        }
        else if(Country == 'New Zealand')
        {      
            options.add(new SelectOption('AUCKLAND','AUCKLAND'));
            options.add(new SelectOption('WELLINGTON','WELLINGTON'));
            
        }
        else if(Country == 'Australia')
        {      
            options.add(new SelectOption('SYDNEY','SYDNEY'));
            options.add(new SelectOption('PERTH','PERTH'));
            options.add(new SelectOption('BREISBANE','BREISBANE'));
        }
        else
        {
            options.add(new SelectOption('None','--- None ---'));
        }     
        return options;
    }      
     public PageReference save() {
  
      if(CHECK == True){
      DESCRIPTION= DESCRIPTION  +  '    ' + comments+ '   ' + State + '   ' + Country;
    
      }
    else 
    {
   DESCRIPTION= Country+ '   ' + State ;
   }
    
   
   
        return null;
       
        
    }
}
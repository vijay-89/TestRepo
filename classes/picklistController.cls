public class picklistController {
    public String dropdown1{get; set;}
    public List<SelectOption> options;
    public void updateDropdown() {
        if(dropdown1 == 'INDIA'){
            options = new List<SelectOption>();
            options.add(new SelectOption('Delhi','AP'));
           }else if(dropdown1 == 'Australia'){
            options = new List<SelectOption>();
            options.add(new SelectOption('Sydney','Melbourne'));
        }else if(dropdown1 == 'USA'){
            options = new List<SelectOption>();
            options.add(new SelectOption('New York','California'));
        }        
    }
    public List<SelectOption> getItems() {
        return options;
    }    
}
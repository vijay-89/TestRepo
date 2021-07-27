/*
@Author : Venkata Koyyalamudi
@name : UpdateCaseSharedGroupMailbox
@CreateDate : 03/11/2020
@Description : This class is used to update case shared group mailbox field when RFP case is created from email.
*/
public with sharing  class  UpdateCaseSharedGroupMailbox {
   
    @InvocableMethod // calling it from Process Builder "Populate Fields on New RFP Cases"
    public static void updateSharedEmailBoxonCase(List<String> caseIdList){  
        Map<String,String> caseEmailaddMap = new Map<String,String>();// stores case id as key and value as state
        
        List<String> sharedGroupemailsList = new List<String>();// stores metadata information of sharedgroupemails
        String validatedEmailAddress;
        String toCcBccEmailAddress;
        for(Case_Shared_Group_Mailbox_Emails__mdt sgmbEAObj:[select Shared_Group_Mailbox_Email_Addresses__c from Case_Shared_Group_Mailbox_Emails__mdt]){  
            
            sharedGroupemailsList.add(sgmbEAObj.Shared_Group_Mailbox_Email_Addresses__c);
        }
        // System.debug('caseIdList'+caseIdList);
        for(EmailMessage emObj:[Select id,ParentId,ToAddress,CcAddress,bccAddress from EmailMessage where ParentId in:caseIdList]){
            toCcBccEmailAddress=''; // concat all the emailaddress into this field.
            if(emObj.ToAddress!='' && emObj.ToAddress != null){
                toCcBccEmailAddress+=emObj.ToAddress.trim();
            }
            if(emObj.CcAddress!='' && emObj.CcAddress != null){
                toCcBccEmailAddress+=';'+emObj.CcAddress.trim();
            }
            if(emObj.bccAddress!='' && emObj.bccAddress != null){ // salesforce is not storing bcc value 
                toCcBccEmailAddress+=';'+emObj.bccAddress.trim();
            }
            validatedEmailAddress=getValidEmailAddress(toCcBccEmailAddress.trim(),sharedGroupemailsList);
            if(validatedEmailAddress!=null){
                caseEmailaddMap.put(emObj.ParentId, validatedEmailAddress);
            }            
        }
        
        if(!caseEmailaddMap.isEmpty()){
            
            List<Case> caseList=[select id,Shared_Group_Mailbox__c from case where id in:caseEmailaddMap.keyset()];
            for(Case caseObj:caseList){
                caseObj.Shared_Group_Mailbox__c = caseEmailaddMap.get(caseObj.Id);                    
            }
            update caseList; // updating case List with shared group mailbox
            
        }
        
    }
    /**
* name :  getValidEmailAddress
* Params : emailAddress,emailstateMap
* Description : used to validate all the email addresses and return matched email address or null.
* 
*/ 
    public static String getValidEmailAddress(String emailAddress,List<String> sharedGroupemailsList){
        boolean flag=false;
        String validEmail=null;
        List<String> emailsList = emailAddress.split(';'); // split the email address to process one by one
        //system.debug('size'+emailsList.size());
        Set<String> setEmails = new Set<String>();
        setEmails.addAll(emailsList);        
        for(String strEmail:setEmails){                
            if(sharedGroupemailsList.contains(strEmail.trim())){
                if(!flag){ // checking for more than one match
                    flag=true;
                    validEmail=strEmail.trim();
                }else{
                    return null; // having 2 matches
                }
            }
        }
        
        return validEmail;
    }
     
}
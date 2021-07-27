// SPRINT 192.4 - XMen - Shifted from COM1
// Modification - OE_AMB_Facilitator__c replaced with Contact
public class OEAMBOnBoardingSurveyController {
  
    /*************************************************************************
    * Purpose:  Controller for Onboarding site 
    * Created:  3/20/2015
    * Author:   Leslie Getman
    **************************************************************************
    * Mod:      4/28/2015
    *            Modified for better code coverage - LG
    *           11/23/2016 - Modified to add new page block for not show 2016
    *            01/10/2017 - Modified to add Zip Code - LG
    **************************************************************************/
    
    public Boolean showReturnSurvey {get;set;}
    public Boolean showNotCleared {get;set;}
    public Boolean showThankYouNew {get;set;}
    public Boolean showThankYouAmb {get;set;}
    public Boolean showAlreadyVolunteered {get;set;}
    public Boolean showNewVol {get; set;}
    public Boolean DoNotShowNewVol {get; set;}
    public String facName {get; set;}
    //public OE_AMB_Facilitator__c ambassador{get;set;} ---Contact object to be used in 
    //place of OE_AMB_Facilitator__c object. - XMen - 22nd May
    public Contact ambassador{get;set;}
    public Date dateUpdated =system.Today();
    public Boolean isConsultant { get; set;}
    
    
    @testvisible private String urlFacID=ApexPages.currentpage().getParameters().get('FacID');
    @testvisible private String urlEmail=ApexPages.currentpage().getParameters().get('Email');
    @testvisible private String meetingId = ApexPages.currentpage().getParameters().get('MeetingId');

    string urlNewVol=ApexPages.currentpage().getParameters().get('NewVol'); 
    
    
    {
        showReturnSurvey=false;
        showNotCleared=false;
        showThankYouNew=false;
        showThankYouAmb=false;
        showAlreadyVolunteered=false;
        showNewVol = false;
        ambassador=new Contact();
        ambassador.Id=urlFacID;
        newOrReturning(urlNewVol);
    }
    
    //public String getMainCSSFile(){
     //   Document docs=[select id from Document where name='main'];
     //   return URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.FileDownload?file='+docs.Id;
  //  }
    
   // public String getAnthemLogoFile(){
     //   Document docs=[select id from Document where name='AnthemLogo'];
       // return URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.FileDownload?file='+docs.Id;
    //}
    
    public PageReference backToMeeting() {
    
        PageReference pageRef = Page.OE_Amb_Signup;
        pageRef.getParameters().put('facid', urlFacID);
        pageRef.getParameters().put('email', urlEmail);
        pageRef.getParameters().put('meetingId', meetingId);
        
        return pageRef;
    } 

    public void newOrReturning(string newVol) {
        if (newVol == 'TRUE') {
            showNewVol = true;
            showReturnSurvey = false;
       }
       else{
           whichAmbassador(urlFacID, urlEmail);
       }
   }
       
    
    public void whichAmbassador(string FacId, string Email){
        LIST<Contact> facInfo = new LIST<Contact>();
            /*facInfo= [SELECT Id, Facilitator_Type__c, Additional_Training_Requested__c,
                      ARG_Names__c,ARG__c,Associate_Type__c,Benefit_presentations_outside_the_OEAP__c,
                      Benefit_presentations_within_the_OEAP__c,Bilingual__c,City__c,Confidence_level_conducting_presentation__c,
                      Comments__c, ContactID__c,Department__c,Email__c,Explaining_and_answering_CDHP_questions__c,
                      Explaining_H_W_programs__c,First_Name__c,Go_To_Meeting_Trained__c,Initial_Training__c,Last_Name__c,
                      Languages__c,Mobile_Phone__c,Name,OE_AMB_FacilitatorID__c,Ongoing_CE_Training__c,
                      Phone__c,Preferred_Meeting_Type__c, Preferred_Meeting_Type_Reason__c, 
                      Presentations_outside_the_company__c,State__c,Zip_Code__c,Title__c,Understanding_benefit_plans__c,
                      US_Domain_ID__c,Walking_through_benefit_summaries__c,Work_Location__c,Year_certified__c, 
                      Years_as_an_Ambassador__c ,Confirm_Manager_s_Approval__c, Are_you_in_a_client_facing_role__c, 
                      Commercial_Medical_Product_Benefits__c, Part_of_National_Governmen__c, 
                      Other_live_presentation_within_Company__c, Elaborate_On_Presentation_Experience__c, 
                      Knowledge_of_specialty_products__c, Explaining_and_answering_questions_on_sp__c 
                      FROM OE_AMB_Facilitator__c WHERE  ID=:FacID and email__c = :Email];*/
                facInfo= [SELECT Id, Facilitator_Type__c,ARG_Names__c,
					  ARG__c,
					  Associate_Type__c,
					  Benefit_presentations_outside_the_OEAP__c,
                      Benefit_presentations_within_the_OEAP__c,
					  Bilingual__c,
					  Confidence_level_conducting_presentation__c,
					  Email,
                      FirstName,
					  LastName,
                      Department,
					  Explaining_and_answering_CDHP_questions__c,
                      Explaining_H_W_programs__c,Languages__c,
					  Name,OE_AMB_FacilitatorID__c,
					  Preferred_Meeting_Type__c,					   
                      Presentations_outside_the_company__c,
					  Title,Understanding_benefit_plans__c,
                      US_Domain_ID__c,
					  Walking_through_benefit_summaries__c,
					  Work_Location__c, Part_of_National_Government__c,
                        Billing_City__c,Billing_State_Province__c,Billing_Zip_Postal_Code__c,Phone, MobilePhone,
                      Commercial_Medical_Product_Benefits__c,
                      Years_as_an_Ambassador__c , Are_you_in_a_client_facing_role__c, 
                      Other_live_presentation_within_Company__c, Elaborate_On_Presentation_Experience__c, 
                      Knowledge_of_specialty_products__c,Facilitator_Comments__c,Explaining_specialty_benefits__c
                      FROM Contact WHERE Email = :Email];
        if(facInfo.size()> 0){
            ambassador = facInfo[0];
            facName=ambassador.FirstName + ' ' + ambassador.LastName;
            showReturnSurvey = true;
            
            if (facInfo[0].Facilitator_Type__c == 'Consultant') {
                isConsultant = true;
            } else {
                isConsultant = false;
            }
        }
        else{ 
            showNotCleared=true;
        }
    }
    
 
    public PageReference submitAmbassador(){
    
        if (showNewVol) {
            try{
            showNewVol=false;
            
                string DomainId;
                DomainId = ambassador.US_Domain_ID__c;
             LIST<Contact> facExist = new LIST<Contact>();
            facExist= [SELECT Id FROM Contact WHERE US_Domain_ID__c = :DomainId];
          if(facExist.size()== 0){
            insert ambassador;
              showThankYouNew=true;
                    }
        else{ 
            showAlreadyVolunteered=true;
        }
           }
            catch(DmlException ex){
            ApexPages.addMessages(ex);
            showNewVol=TRUE;
            showThankYouNew=FALSE;
            return null;
           }    
        }
        else{
            try{
                //Ambassador.Date_Updated_on_Web_survey__c = dateUpdated;
                showThankYouAmb=true;
                showReturnSurvey=false;
                update Ambassador;
            }
                catch(DmlException ex){
                ApexPages.addMessages(ex);
                showThankYouAmb=FALSE;
                showReturnSurvey=TRUE;
                return null;
           }
        } 
        return null;
    }


}
public class OpenEnrollmentTriggerHandler {
	
    public static void updateMeetingCommHistory(List<SFDC_Volunteer_Event__c> newRecords, Map<Id, SFDC_Volunteer_Event__c> oldMap){
        
		String sComments = null;
        DateTime myDateTime = System.now();
        String formatted = myDateTime.formatGMT('MM-dd-yyyy\' - \'HH:mm:ss');
        
        for(SFDC_Volunteer_Event__c objSVE : newRecords){
			
            SFDC_Volunteer_Event__c objOldRec = oldMap.get(objSVE.id);            
            if(objSVE.Meeting_Comments__c== objOldRec.Meeting_Comments__c) continue;
            sComments = objOldRec.Meeting_Comments__c + ' - ' + Userinfo.getFirstName() + ' ' + Userinfo.getLastName() + ' - ' + formatted;
            
            if(objSVE.Meeting_Comments_History__c==null || objSVE.Meeting_Comments_History__c=='')
            	objSVE.Meeting_Comments_History__c  = sComments;
            else
                objSVE.Meeting_Comments_History__c  = sComments + '\n' + objSVE.Meeting_Comments_History__c;
        }
    }
	
	///Added - DK - 17-Jul
	
/*	public static void updateCoordinator(List<SFDC_Volunteer_Event__c> newRecords) {
      // Load Groups into Map
      List<Open_Enrollment_Meetings__c> grpgRecs=[select id,name,account_region__c,Source__c,Account__c,OE_Coordinator_Contact__c,OE_Coordinator_Contact__r.Name from Open_Enrollment_Meetings__c];
      Map<Id,Open_Enrollment_Meetings__c> mgrpgRecs=new Map<Id,Open_Enrollment_Meetings__c>(grpgRecs);    
      
      // Work through trigger records
      for(SFDC_Volunteer_Event__c volRec : newRecords){
          // Lookup Grouping
          if(mgrpgRecs.containsKey(volRec.OE_Grouping__c)) {
            Open_Enrollment_Meetings__c grpgRec=mgrpgRecs.get(volRec.OE_Grouping__c);
            volRec.OE_Coordinator_Contact__c=grpgRec.OE_Coordinator_Contact__c;
        volRec.OE_Coordinator_Text__c=grpgRec.OE_Coordinator_Contact__r.Name;
      }
      }
  }*/

  public static List<SFDC_Volunteer_Event__c> verifyLocation(List<SFDC_Volunteer_Event__c> newRecords, Map<Id, SFDC_Volunteer_Event__c> oldRecords){

    List<SFDC_Volunteer_Event__c> updatedAddresses = new List<SFDC_Volunteer_Event__c>();
    for(SFDC_Volunteer_Event__c event : newRecords){
      if(isAddressChanged(event, oldRecords.get(event.Id))){
        updatedAddresses.add(event);
      }
    }

    return updatedAddresses;
  }

  public static void updateChangedAddresses(List<SFDC_Volunteer_Event__c> updatedMeetings) {
    List<SFDC_Volunteer_Event__c> meetingsToUpdateWithLocations = new List<SFDC_Volunteer_Event__c>();

    TravelResponseService.sendLocationRequest(updatedMeetings);
  }

  public static boolean isAddressChanged(SFDC_Volunteer_Event__c newMeeting, SFDC_Volunteer_Event__c oldMeeting){
    return ((newMeeting.Location__latitude__s == null && newMeeting.Location__longitude__s == null) || newMeeting.Meeting_Street__c != oldMeeting.Meeting_Street__c || newMeeting.Meeting_City__c != oldMeeting.Meeting_City__c || newMeeting.Meeting_State__c != oldMeeting.Meeting_State__c || newMeeting.Meeting_Zip_Code__c != oldMeeting.Meeting_Zip_Code__c);
  }

  public static Boolean checkUpdateCount(List<SFDC_Volunteer_Event__c> newRecords) {
    return (newRecords.size() > 100);
  }
}
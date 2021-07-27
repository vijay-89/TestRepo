/*
*******************************************************************************************
* Name          UtilityTest
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   03/04/2020
* UsedBy        The UtilityTest is a test class for Utility.
* Description   Jira user story PRCDM2-1904
*********************************************************************************************
*/
@isTest
public class UtilityTest {
    /*
    *******************************************************************************************
    * Name          utilityRecordTypeTest
    * Author        Deepak Kumar Reddy Regatte
    * ModifiedBy    Deepak Kumar Reddy Regatte
    * CreatedDate   03/04/2020
    * UsedBy        This Method "utilityRecordTypeTest" is used to get recordtypeId.
	* Description   Jira user story PRCDM2-1904
    *********************************************************************************************
    */
    @isTest 
    static void utilityRecordTypeTest() {
    	Test.startTest();
        Id caseRecordTypeID = Utility.sObjectRecordTypeID(staticVariableClass.STRING_CASE,staticVariableClass.CASE_RFP_INTAKE_RECORDTYPE_NAME);	
        RecordType rT = [select id,Name from recordtype where id=:caseRecordTypeID];
        System.assertEquals(rT.Id, caseRecordTypeID);
        Test.stopTest();
    } 
    /*
    *******************************************************************************************
    * Name          utilityCustomMetaDataTypeTest
    * Author        Deepak Kumar Reddy Regatte
    * ModifiedBy    Deepak Kumar Reddy Regatte
    * CreatedDate   03/04/2020
    * UsedBy        This Method "utilityCustomMetaDataTypeTest" is used to get CustomMetaDataType.
	* Description   Jira user story PRCDM2-1904
    *********************************************************************************************
    */
    @isTest 
    static void utilityCustomMetaDataTypeTest() {
    	Test.startTest();
        Integration_EndPoint_Setting_Details__mdt  endPointInfo  = Utility.getCustomMetaDataType();	
        system.assertEquals(endPointInfo.End_Point_URL__c, endPointInfo.End_Point_URL__c);
        system.assertNotEquals(endPointInfo.ApiKey__c, 'test');
        Test.stopTest();
    }
    
}
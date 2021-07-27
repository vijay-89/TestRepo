/*
*******************************************************************************************
* Name          IntegrationUtilityTest
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/24/2020
* UsedBy        The IntegrationUtilityTest is a test class for IntegrationUtility.
* Description Jira user story PRCDM2-1904
*********************************************************************************************
*/
@isTest
public class IntegrationUtilityTest {
    
    /*
    *******************************************************************************************
    * Name          IntegrationTokenDetailTest
    * Author        Deepak Kumar Reddy Regatte
    * ModifiedBy    Deepak Kumar Reddy Regatte
    * CreatedDate   02/24/2020
    * UsedBy        This Method "IntegrationTokenDetailTest" is used to get code coverage  
    				for IntegrationTokenDetail wrapper class.
	* Description   Jira user story PRCDM2-1904
    *********************************************************************************************
    */
    @isTest 
    static void IntegrationTokenDetailTest() {
    
        Test.startTest();
        IntegrationTokenDetails tokenDetail = new   IntegrationTokenDetails();
        tokenDetail.access_token = 'test';
        tokenDetail.currentTime = System.now();
        tokenDetail.isNewToken = true;
        tokenDetail.issued_at='PMO';
        tokenDetail.application_name ='APM';
        tokenDetail.status ='Active';
        tokenDetail.expires_in ='30 days';
        tokenDetail.client_id ='BDF01';       
        Test.stopTest();
    }
    /*
    *******************************************************************************************
    * Name          getAccessToken
    * Author        Deepak Kumar Reddy Regatte
    * ModifiedBy    Deepak Kumar Reddy Regatte
    * CreatedDate   02/24/2020
    * UsedBy        This Method is used to get code coverage  for accesstoken method in 
     				Integration utility Class.
	* Description   Jira user story PRCDM2-1904
    *********************************************************************************************
    */
    @isTest 
    static void getAccessToken()
    {
        
        Test.startTest();
        
        IntegrationUtilityMockTest mockTest = new IntegrationUtilityMockTest(200);
        Test.setMock(HttpCalloutMock.class, mockTest);

        IntegrationUtility iU = new IntegrationUtility();
        IntegrationTokenDetails resp = iU.AccessToken();
        
        Test.stopTest();
	}
    
}
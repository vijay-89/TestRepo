/*
*******************************************************************************************
* Name          NlpServiceRequestWrapper_Test 
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   03/16/2020
* UsedBy        The NlpServiceRequestWrapper_TEST is Test Class for NlpServiceRequestWrapper class to build Json Request to NLP.
*********************************************************************************************
*/
@isTest
public class NlpServiceRequestWrapper_Test {
	
	/*
     * @This is a test class Method to NlpServiceRequestWrapper_Test.
     * @Name:testParse
     * @Created Date: 16th March 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1356  
    */  
    @isTest
    static void testParse() {
        String json = '{"metadata":{"topicName":"digital-extract-request-topic-sit"},"events":[{"requestStartDate":"2020-03-17 14:58:46","requestId":"1085138784","lobType":"LG Group","document":[{"documentType":"EXCEL_X","documentLocation":"https://commercial--SMPNYQA.cs60.my.salesforce.com/services/data/v47.0/sobjects/ContentVersion/0683C0000002rUYQAY/VersionData","documentId":"0683C0000002rUYQAY"},{"documentType":"EXCEL","documentLocation":"https://commercial--SMPNYQA.cs60.my.salesforce.com/services/data/v47.0/sobjects/ContentVersion/0683C0000002rUXQAY/VersionData","documentId":"0683C0000002rUXQAY"}],"channel":"SFDC","businessContextId":"5003C000003wtfpQAA"}]}';
        NlpServiceRequestWrapper oNlpServiceRequest= new NlpServiceRequestWrapper();
        oNlpServiceRequest = NlpServiceRequestWrapper.parse(json);
        System.assertEquals(oNlpServiceRequest.Metadata.topicName,'digital-extract-request-topic-sit');
	}
}
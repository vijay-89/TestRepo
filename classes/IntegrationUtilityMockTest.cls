/*
*******************************************************************************************
* Name          IntegrationUtilityMockTest
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/24/2020
* UsedBy        The IntegrationUtilityMockTest class implements HttpCalloutMock.
* Description Jira user story PRCDM2-1904
*********************************************************************************************
*/
@isTest
public class IntegrationUtilityMockTest implements HttpCalloutMock {

    String sIntegrationSuccessResponse = '{"id":"103829","key":"EWM-49704","self":"https://jiraewm-dev.anthem.com/rest/api/2/issue/103829"}';
    String sIntegrationResponseWithResponse = '{"id":"103829","key":"EWM-49704","self":"https://jiraewm-dev.anthem.com/rest/api/2/issue/103829","response":"Test Response"}';
    String sIntegrationErrorResponse = '{"id":"103829","key":"EWM-49704","self":"https://jiraewm-dev.anthem.com/rest/api/2/issue/103829","exceptions":[{"type":"errors","code":"400","message":"Test errors Exception","detail":"Test Detail"}]}';
    Integer Code =200;
    
    public IntegrationUtilityMockTest(Integer code)
    {
        
        this.code = code;
        
    }
     //HTTP Response for mock test
     public HttpResponse respond(HTTPRequest request){
         String reqBody = request.getBody();
         HTTPResponse resp = new HTTPResponse();
         resp.setHeader('Content-Type', 'application/json');
         resp.setStatusCode(code);
         if(code!=200){
             resp.setBody(sIntegrationErrorResponse);
         }else {
             resp.setBody(sIntegrationSuccessResponse);
          }
          return resp;
    }
}
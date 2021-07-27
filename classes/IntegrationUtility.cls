/*
*******************************************************************************************
* Name          IntegrationUtility
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/24/2020
* UsedBy        The IntegrationUtility is used globally for all Integration to get access token.
* Description   Jira user story PRCDM2-1904
*********************************************************************************************
*/
public with sharing class IntegrationUtility {
    public String apiKey;
    public String clientId;
    public String clientSecret;
    public String userName;
    public String passWord;
    public String host;
    public String accessTokenURL;
    public Integer tokenRefreshTime;
    
    //Constructor to fetch metadata
    public IntegrationUtility(){
    
        
            Integration_EndPoint_Setting_Details__mdt endPointInfo = Utility.getCustomMetaDataType();
           
            apiKey = endPointInfo.ApiKey__c;
            clientId = endPointInfo.ClientID__c;
            clientSecret = endPointInfo.Client_Secret__c;
            userName = endPointInfo.Application_Username__c;
            passWord = endPointInfo.Application_Password__c;
            host = endPointInfo.Host__c;
            accessTokenURL = endPointInfo.Access_Token__c;
            tokenRefreshTime = Integer.valueOf(endPointInfo.TokenRefreshTime__c);
    
    }
    /*
    *******************************************************************************************
    * Name          AccessToken
    * Author        Deepak Kumar Reddy Regatte
    * ModifiedBy    Deepak Kumar Reddy Regatte
    * CreatedDate   02/24/2020
    * UsedBy        Method AccessToken is to authenticate to Kafka before actual request is sent.
    * Description Jira user story PRCDM2-1904
    *********************************************************************************************
    */
    public IntegrationTokenDetails  AccessToken() {
        
        IntegrationTokenDetails getTokenDetails  = new  IntegrationTokenDetails();  
        
        String authString = clientId + ':' + clientSecret;
        
        Blob headerValue = Blob.valueOf(authString);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
 
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(accessTokenURL);
        req.setTimeout(120000);
        req.setHeader('authorization', authorizationHeader);
        req.setHeader('apikey', apiKey);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('Accept', 'application/json');
        req.setHeader('Host', host);
        req.setBody('scope=public&grant_type=client_credentials');        
        HttpResponse res = h.send(req);
        getTokenDetails = (IntegrationTokenDetails)JSON.deserialize(res.getbody(), IntegrationTokenDetails.class);
        getTokenDetails.currentTime = datetime.now();       
        getTokenDetails.isNewToken = true; 
        return getTokenDetails;   
    }

}
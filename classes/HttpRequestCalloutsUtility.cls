/*
*******************************************************************************************
* Name          HttpRequestCallout 
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   01/29/2020
* UsedBy        The HttpRequestCallout apex class is responsible for making callout to 3rd party applications.
*********************************************************************************************
*/
public with sharing class HttpRequestCalloutsUtility{
     /*
     * This Method is used for doing callout to NLP
     * @name:HttpRequestCallouts
     * @param: string requestJSON,Map<string,string> authParameter, string timeout
     * Created Date: 29th January 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @description Jira user story PRCDM2-1386   
     */ 
    public static HttpResponse HttpRequestCallouts(String requestJSON,Map<string,string> authParameter, String namedCredential, String timeout){
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setTimeout(120 * 1000);
        httpRequest.setEndpoint(authParameter.get('endpoint'));
        httpRequest.setMethod('POST');
        httpRequest.setHeader('Accept', 'application/json');
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setHeader('Authorization', authParameter.get('authorization'));
        httpRequest.setHeader('apikey',authParameter.get('apiKey')); 
        httpRequest.setBody(requestJSON); 
        system.debug('Request'+httpRequest);
        HttpResponse httpResponse = new Http().send(httpRequest); 
        system.debug('responce from Apigee'+httpResponse.getBody()); 
        System.debug('*** STATUS CODE=' + httpResponse.getStatusCode());
        System.debug('*** RESPONSE =' + httpResponse.getBody());
        return httpResponse;
    }



}
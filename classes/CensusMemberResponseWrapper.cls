/*
*******************************************************************************************
* Name          CensusMemberResponseWrapper 
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   07/02/2020
* UsedBy        This will be a Wrapper class for census object data operations
*******************************************************************************************
*/
public with sharing class CensusMemberResponseWrapper{
    public String transactionId {get;set;}
    public String transactionTime {get;set;}
    public String requestId {get;set;}
    public String lobType {get;set;}
    public CensusMemberDocumentInformation[] document;
    
    public class CensusMemberDocumentInformation{
        public String location {get;set;}
        public String id {get;set;}
        public String type {get;set;}
        public String context {get;set;}
        public ErrorInformation[] errors;
        public CensusMemberData data;
    }
    
     public class ErrorInformation{
        public String code {get;set;}
        public String description {get;set;}
    }
    
     public class CensusMemberData {
      public CensusMemberPerson[] person;
     }
     
    public  class CensusMemberPerson{
        public String firstName {get;set;}
        public String lastName {get;set;}
        public Integer age {get;set;}
        public String gender {get;set;}
        public String status {get;set;}
        public String zipcode {get;set;} 
        public String planProductFamily {get;set;}
        public String planName {get;set;}
        public String planType{get;set;}
        public String coverageLevel {get;set;}
        public String type {get;set;}
           
    }
    
 
}
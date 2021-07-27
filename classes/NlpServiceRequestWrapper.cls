/*
*******************************************************************************************
* Name          NlpServiceRequestWrapper 
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/19/2020
* UsedBy        The NlpServiceRequestWrapper is Wrapper class to build Json Request to NLP.
*********************************************************************************************
*/
    public with sharing class NlpServiceRequestWrapper{
        public Metadata metadata;
        public List<events> events;
     /*
     * @This is a sub class to NlpServiceRequestWrapper to wrap metadata
     * @Name:Metadata
     * @Created Date: 18th February 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1356  
     */  
     public class Metadata{
        public String topicName;
    }
    /*
     * @This is a sub class to Metadata to wrap Events
     * @Name:Events
     * @Created Date: 18th February 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1356  
     */  
    public class Events{
        public String requestId;
        public String channel;
        public String lobType;
        public String requestStartDate;
        public String businessContextId;
        public List<document> document;
    }
    /*
     * @This is a sub class to Events to wrap Documents
     * @Name:Document
     * @Created Date: 18th February 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Jira user story PRCDM2-1356  
     */  
    public class Document{
        public String documentLocation;
        public String documentId;
        public String documentType;
      
    }
    /*
     * @This Method is to parse Json to get Responce.
     * @Name:parse
     * @Created Date: 17th March 2020
     * @Author : Deepak Kumar Reddy Regatte(Enforcers)
     * @Description Parse JSON to get the responce of  NlpServiceRequestWrapper type.
     */      
    Public static NlpServiceRequestWrapper parse(String sJson){
    	return (NlpServiceRequestWrapper) JSON.deserialize(sJson, NlpServiceRequestWrapper.class);
            
    }    
}
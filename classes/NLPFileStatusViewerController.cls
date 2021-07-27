/*
********************************************************************************************
* Name          NLPFileStatusViewerController
* Author        Ethan Park
* ModifiedBy    Ethan Park
* CreatedDate   03/11/2020
* UsedBy        nLPFileStatusViewer to retrieve NLP file processing status
*********************************************************************************************
*/
public with sharing class NLPFileStatusViewerController {
    @TestVisible
    private static final String GENERIC_ERROR_STATUS_CODE = 'E2ENLP.500.0';
    @TestVisible
    private static final String STATUS_CODE_200 = '200';
    @TestVisible
    private static final String STATUS_CODE_200_IN_PROGRESS = '200In Progress';
    private static final String STATUS_CODE_200_SUCCESS = '200Success';
    private static final String STATUS_ERROR = 'Error';
    private static final String STATUS_OBJECT_CONTENT_VERSION = 'Content Version Object';
    private static final String STATUS_OBJECT_REQUEST_TRACKING = 'Request Tracking Object';
    
    /*
    * @This method is called from nLPFileStatusViewer and used to get NLP file processing status
    * @Name: getNLPFileStatus
    * @Created Date: 03/11/2020
    * @Author: Ethan Park
    * @Description Jira user story PRCDM2-1508
    */
    @AuraEnabled(cacheable = true)
    public static List<ContentVersion> getNLPFileStatus(Id recordId)
    {
        try {
            List<EmailMessage> listEmailMessages = [Select Id From EmailMessage Where ParentId =:recordId ];
            Set<Id> emailMessageIds = new Set<Id>();
            for(EmailMessage emailobj :listEmailMessages){
                emailMessageIds.add(emailobj.Id);
            }            
            List<ContentDocumentLink> contentDocumentLinks = [
                SELECT Id, LinkedEntityId, ContentDocumentId, ContentDocument.Title
                FROM ContentDocumentLink
                WHERE ( LinkedEntityId =: recordId OR LinkedEntityId IN :emailMessageIds ) AND IsDeleted = FALSE
            ];
            Set<Id> contentDocumentIds = new Set<Id>();
            for(ContentDocumentLink item :contentDocumentLinks) {
                contentDocumentIds.add(item.ContentDocumentId);
            }

            List<ContentVersion> contentVersions = [
                SELECT Id, ContentDocumentId, ContentDocument.Title, Error_Message__c, CreatedDate,
                    Response_Status__c, Response_Status_Details__c, Request_Tracking_ID__c,
                    Request_Tracking_Name__c, ContentModifiedDate
                FROM ContentVersion
                WHERE ContentDocumentId IN :contentDocumentIds
                    AND IsDeleted = FALSE
                    AND IsLatest = TRUE
                ORDER BY ContentModifiedDate DESC
            ];

            List<Request_Tracking__c> requestTrackings = [
                SELECT Id, CaseID__c, Status__c, RequestID__c
                FROM Request_Tracking__c
                WHERE CaseID__c = :recordId
            ];
            Map<String, Request_Tracking__c> requestTrackingByRequestId
                = new Map<String, Request_Tracking__c>();
            for(Request_Tracking__c item :requestTrackings) {
                requestTrackingByRequestId.put(item.Id, item);
            }

            List<NLP_Status_Code_Mapping__mdt> statusMetadata = [
                SELECT Id, DeveloperName, Error_Message__c, Object__c, Status_Code__c, Status__c, Description__c
                FROM NLP_Status_Code_Mapping__mdt
                ORDER BY Status__c
            ];
            Map<String, NLP_Status_Code_Mapping__mdt> statusMapByStatusCode
                = new Map<String, NLP_Status_Code_Mapping__mdt>();
            for(NLP_Status_Code_Mapping__mdt item : statusMetadata) {
                if(item.Status_Code__c == STATUS_CODE_200) {
                    if(item.Object__c == STATUS_OBJECT_CONTENT_VERSION) {
                        statusMapByStatusCode.put(STATUS_CODE_200_SUCCESS, item);
                    } else {
                        statusMapByStatusCode.put(STATUS_CODE_200_IN_PROGRESS, item);
                    }
                } else {
                    statusMapByStatusCode.put(item.Status_Code__c, item);
                }
            }

            for(ContentVersion item :contentVersions) {
                Request_Tracking__c requestTracking = null;
                if(requestTrackingByRequestId.containsKey(item.Request_Tracking_ID__c)) {
                    requestTracking = requestTrackingByRequestId.get(item.Request_Tracking_ID__c);
                }

                if(String.isBlank(item.Response_Status__c)) {
                    if(requestTracking != null && !String.isBlank(requestTracking.Status__c) &&
                        (statusMapByStatusCode.containsKey(requestTracking.Status__c) || requestTracking.Status__c == STATUS_CODE_200)) {
                        if (requestTracking.Status__c == STATUS_CODE_200) {
                            item.Response_Status__c = STATUS_CODE_200_IN_PROGRESS;
                        } else {
                            item.Response_Status__c = requestTracking.Status__c;
                        }
                    } else {
                        item.Response_Status__c = GENERIC_ERROR_STATUS_CODE;
                    }
                } else if (item.Response_Status__c != STATUS_CODE_200) {
                    if(!statusMapByStatusCode.containsKey(item.Response_Status__c)) {
                        item.Response_Status__c = GENERIC_ERROR_STATUS_CODE;
                    }
                } else {
                    item.Response_Status__c = STATUS_CODE_200_SUCCESS;
                }

                if(statusMapByStatusCode.get(item.Response_Status__c).Error_Message__c == null) {
                    item.Error_Message__c = '';
                } else {
                    item.Error_Message__c = statusMapByStatusCode.get(item.Response_Status__c).Error_Message__c;
                }

                item.Response_Status__c = statusMapByStatusCode.get(item.Response_Status__c).Status__c;
            }

            return contentVersions;
        } catch (Exception e) {
            throw new AuraHandledException('Something went wrong from the Controller: ' + e.getMessage());
        }
    }
}
/*
*******************************************************************************************
* Name          ContentVersionTriggerTest
* Author        Deepak Kumar Reddy Regatte
* ModifiedBy    Deepak Kumar Reddy Regatte
* CreatedDate   02/04/2020
* UsedBy        The ContentVersionTriggerTest apex class is responsible for apex code coverage for classes
                ContentVersionNLPService, ContentVersionQueueable,ContentVersionTriggerHandler, ContentVersionTrigger,
                HttpRequestCalloutsUtility, TriggerDispatcher.
*********************************************************************************************
*/
@isTest
public with sharing class ContentVersionTriggerTest{
          @testSetup static void createCommonTestData() {
            Id caseRecordTypeID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('RFP Intake Case').getRecordTypeId();
            Integer  iRecordCount = staticVariableClass.RECORD_COUNT; 
            String sName = staticVariableClass.NAME;
            String sStreet = staticVariableClass.STREET;
            String sCity = staticVariableClass.CITY; 
            String sState = staticVariableClass.ACCOUNTSTATE;
            String sZip = staticVariableClass.ZIP;
            String sCountry = staticVariableClass.COUNTRY;
            String sStateCode = staticVariableClass.STATECODE;
            List<Account> listAcc = TestDataFactory.createAccountSICList(iRecordCount  ,sName, sStreet, sCity, sState, sZip, sCountry, sStateCode);
            insert listAcc;  
            List<Case> listCase = TestDataFactory.createCaseList(iRecordCount, listAcc[0]);
            for(Case oCase : listCase){
                oCase.recordTypeId = caseRecordTypeID;
            }
            insert listCase;
            List<EmailMessage> listEmailMessage = TestDataFactory.createEmailMessageList(iRecordCount, listCase[0]);
            insert   listEmailMessage;           
        }
         /*
         * This Method is used for testclass to make a mock callout
         * @name:callHTTP
         * Created Date: 02th Feb 2020
         * @Author : Deepak Kumar Reddy Regatte(Enforcers)
         * @description Jira user story PRCDM2-1386   
         */ 
         @isTest
         public static void callHTTP(){
            Test.startTest();
            List<Case> listCase = [select id,Account.name, origin from case];
            system.assertEquals(listCase[0].origin, 'Email');
            system.assertNotEquals(listCase[0].Account.name, 'Apple123');
            IntegrationUtilityMockTest mockTest = new IntegrationUtilityMockTest(200);
            Test.setMock(HttpCalloutMock.class, mockTest);
            ContentVersionQueueable cClsVQ = new ContentVersionQueueable(null,null);
            cClsVQ.apigeeCallout('test',listCase[0].id,'test', null);
            Test.stopTest();
            List<Request_Tracking__c>  listRequestTracking = [SELECT RequestID__c, Status__c, Error_Message__c, CaseID__c, Id FROM Request_Tracking__c];
            System.assertEquals(listRequestTracking[0].Status__c,'200'); 
        }
       /*
         * This Method is used for testclass to trigger contentversion
         * @name:createEmailMessage
         * Created Date: 02th Feb 2020
         * @Author : Deepak Kumar Reddy Regatte(Enforcers)
         * @description Jira user story PRCDM2-1356   
        */ 
        @isTest
        public static void createEmailMessage(){
            Test.startTest();
            List<EmailMessage> listEmailMessage = [select id,ParentID, Parent.Account.Name,Parent.origin from EmailMessage];
            system.assertEquals(listEmailMessage.size(), 5);
            system.assertEquals(listEmailMessage[0].Parent.origin, 'Email');
            system.assertNotEquals(listEmailMessage[0].Parent.Account.name, 'Apple123');
            List<ContentVersion> listContentVersion = TestDataFactory.createContentVersionList(5);
            insert listContentVersion;
            List<ContentVersion> lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];
            system.assertEquals(lContentVersion[0].Title, 'ABC');
            List<ContentDocumentLink> listContentDocumentLink = TestDataFactory.createContentDocumentLinkList(listEmailMessage[0].ID, lContentVersion);
            List<Database.SaveResult> listDatabaseResults = Database.Insert(listContentDocumentLink, false);
            set<id> setContentVersionIds = new set<id>();
            for(ContentVersion cv: listContentVersion){
                cv.title='test';
                setContentVersionIds.add(cv.id);
            }
            Update listContentVersion;
            HttpResponse res = new HttpResponse();  
            res.setHeader('Content-Type', 'application/json');  
            res.setBody('{"example":"test"}');  
            res.setStatusCode(staticVariableClass.ERROR_CODE_200);  
            ContentVersionService.persistResponce(res, listEmailMessage[0].ParentID , 'Test', setContentVersionIds);
            Request_Tracking__c rT = [select id, caseID__c,Status__c from Request_Tracking__c where caseID__c=:listEmailMessage[0].ParentID];
            system.assertNotEquals(rT, Null, 'Test Failed : Request tracking record not found');
            system.assertEquals(rT.Status__c, string.Valueof(staticVariableClass.ERROR_CODE_200));
            Test.stopTest();        
         } 
        /*
         * This Method is used for testclass to trigger contentversion
         * @name:CreateUnsupportedFile
         * Created Date: 20th Feb 2020
         * @Author : Deepak Kumar Reddy Regatte(Enforcers)
         * @description Jira user story PRCDM2-2085   
        */ 
        @isTest
        public static void CreateUnsupportedFile(){
            Test.startTest();
            List<EmailMessage> listEmailMessage = [select id,ParentID, Parent.Account.Name, parent.origin from EmailMessage];
            system.assertEquals(listEmailMessage.size(), 5);
            system.assertEquals(listEmailMessage[0].Parent.origin, 'Email');
            system.assertNotEquals(listEmailMessage[0].Parent.Account.name, 'Apple123');
            List<ContentVersion> listContentVersion = TestDataFactory.createContentVersionUnsupportedList(5);
            insert listContentVersion;
            List<ContentVersion> lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];
            system.assertEquals(lContentVersion[0].Title, 'ABC');
            List<ContentDocumentLink> listContentDocumentLink = TestDataFactory.createContentDocumentLinkList(listEmailMessage[0].ID, lContentVersion);
            List<Database.SaveResult> listDatabaseResults = Database.Insert(listContentDocumentLink, false);
            set<id> setContentVersionIds = new set<id>();
            for(ContentVersion cv: listContentVersion){
                cv.title='test';
                setContentVersionIds.add(cv.id);
            }
            Update listContentVersion;
            lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];

            system.assertEquals(lContentVersion[0].title, 'test');
            system.assertNotEquals(lContentVersion[0].title, 'test1233');
            List<contentversion> listCv = new List<contentversion>();
            ContentVersionTriggerHandler oCvth = new ContentVersionTriggerHandler();
            oCvth.beforeInsert(listCv);
            map<Id, sObject> mapValues = new map<Id, sObject>();
            oCvth.beforeDelete(mapValues);
            oCvth.afterDelete(mapValues);
            oCvth.afterUndelete(mapValues); 
            oCvth.beforeUpdate(mapValues, mapValues);
            oCvth.afterUpdate(mapValues, mapValues);
            Test.stopTest();
         }     
        /*
         * This Method is used for testclass to trigger contentversion for zip content on case
         * @name:createZipContentVersion
         * Created Date: 18th Feb 2020
         * @Author : Deloitte Consulting
         * @description Jira user story PRCDM2-1497   
        */ 
        @isTest
        public static void createZipContentVersion(){
            Test.startTest();
            List<Case> listCase = [select id,Account.name,origin from case];
            system.assertEquals(listCase.size(), 5);
            system.assertEquals(listCase[0].origin, 'Email');
            system.assertNotEquals(listCase[0].Account.name, 'Apple123');
            List<ContentVersion> listContentVersion = TestDataFactory.createZipContentVersionList(5);
            insert listContentVersion;
            List<ContentVersion> lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];
            system.assertEquals(lContentVersion[0].Title, 'ABC');
            List<ContentDocumentLink> listContentDocumentLink = TestDataFactory.createContentDocumentLinkList(listCase[0].ID, lContentVersion);
            List<Database.SaveResult> listDatabaseResults = Database.Insert(listContentDocumentLink, false);
            Test.stopTest();
            List<ZipContent__c> listZipContent = [SELECT Id, Status__c FROM ZipContent__c];
            System.assertEquals(listZipContent.size(), 5);
            System.assertEquals(listZipContent[0].Status__c, 'New');
         }
        /*
         * This Method is used for testclass to trigger contentversion for zip content on email
         * @name:createEmailMessage
         * Created Date: 02th Feb 2020
         * @Author : Deloitte Consulting
         * @description Jira user story PRCDM2-1497   
        */ 
        @isTest
        public static void createEmailZipContent(){
            Test.startTest();
            List<EmailMessage> listEmailMessage = [select id,ParentID, Parent.Account.Name,parent.origin from EmailMessage];
            system.assertEquals(listEmailMessage.size(), 5);
            system.assertEquals(listEmailMessage[0].Parent.origin, 'Email');
            system.assertNotEquals(listEmailMessage[0].Parent.Account.name, 'Apple123');
            List<ContentVersion> listContentVersion = TestDataFactory.createZipContentVersionList(5);
            insert listContentVersion;
            List<ContentVersion> lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];
            system.assertEquals(lContentVersion[0].Title, 'ABC');
            List<ContentDocumentLink> listContentDocumentLink = TestDataFactory.createContentDocumentLinkList(listEmailMessage[0].ID, lContentVersion);
            List<Database.SaveResult> listDatabaseResults = Database.Insert(listContentDocumentLink, false);
            Test.stopTest();  
            List<ZipContent__c> listZipContent = [SELECT Id, Status__c FROM ZipContent__c];
            System.assertEquals(listZipContent.size(), 5);
            System.assertEquals(listZipContent[0].Status__c, 'New');      
         }

        /*
         * This Method is used for testclass for ContentVersionService for email content version of type zip
         * @name:createCaseContentVersion
         * Created Date: 17 Feb 2020
         * @Author : Deloitte Consulting
         * @description Jira user story PRCDM2-1497   
        */ 
        @isTest
        public static void createEmailContentVersion(){
            Set<id> setContentLinkIds = new Set<id>();
            Map<Id, EmailMessage> mapEmail = new Map<Id, EmailMessage>([select id, parentId from EmailMessage]);
            system.assertEquals(mapEmail.size(), 5);
            List<ContentVersion> listContentVersion = TestDataFactory.createContentVersionList(5);
            insert listContentVersion;
            List<ContentVersion> lContentVersion = [select id, Title, ContentDocumentId from ContentVersion];
            system.assertEquals(lContentVersion[0].Title, 'ABC');
            List<ContentDocumentLink> listContentDocumentLink = new List<ContentDocumentLink>();
            listContentDocumentLink.addAll(TestDataFactory.createContentDocumentLinkList(mapEmail.values()[0].Id, new List<ContentVersion>{lContentVersion[0]}));
            listContentDocumentLink.addAll(TestDataFactory.createContentDocumentLinkList(mapEmail.values()[1].Id, new List<ContentVersion>{lContentVersion[0]}));
            listContentDocumentLink.addAll(TestDataFactory.createContentDocumentLinkList(mapEmail.values()[2].Id, new List<ContentVersion>{lContentVersion[0]}));
            listContentDocumentLink.addAll(TestDataFactory.createContentDocumentLinkList(mapEmail.values()[3].Id, new List<ContentVersion>{lContentVersion[0]}));
            listContentDocumentLink.addAll(TestDataFactory.createContentDocumentLinkList(mapEmail.values()[4].Id, new List<ContentVersion>{lContentVersion[0]}));
            TestDataFactory.createContentDocumentLinkList(mapEmail.values()[0].Id, lContentVersion);
            List<Database.SaveResult> listDatabaseResults = Database.Insert(listContentDocumentLink, false);
            for(ContentDocumentLink oContentDocumentLink : listContentDocumentLink) {
                setContentLinkIds.add(oContentDocumentLink.Id);
            }
            Map<Id, List<ContentDocumentLink>> mapCaseIdContentDocument = new Map<Id, List<ContentDocumentLink>>();
            Map<Id, List<ContentDocumentLink>> mapEmailIdContentDocument = new Map<Id, List<ContentDocumentLink>>();
            Test.startTest();
            for(ContentDocumentLink oContentDocument: [SELECT ContentDocumentId,Id,LinkedEntityId, LinkedEntity.type, LinkedEntity.recordtypeId, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink where Id IN: setContentLinkIds]){
                LGZipUtility.identifyZippedContent(mapEmailIdContentDocument, oContentDocument);
            }
            for(EmailMessage oEmailMessage: [SELECT Id, ParentId from EmailMessage where Id = : mapEmail.keySet()]){
                LGZipUtility.identifyEmailZippedContent(mapCaseIdContentDocument, mapEmailIdContentDocument.get(oEmailMessage.Id), oEmailMessage);
            }
            LGZipUtility.createZipContent(mapCaseIdContentDocument);              
            Test.stopTest();
            List<ZipContent__c> listZipContent = [SELECT Id, Status__c FROM ZipContent__c];
            System.assertEquals(listZipContent.size(), 5);
            System.assertEquals(listZipContent[0].Status__c, 'New');
        }
        
        /*
         * This Method is used for testclass for ContentVersionService for Linking unzipped File to case
         * @name:createCaseContentVersion
         * Created Date: 04 Mar 2020
         * @Author : Deloitte Consulting
         * @description : User Story 2433
        */ 
        @isTest
        public static void createContentDocLinkUnzippedFilesTest(){
        
            Case ocaseRecord = [select id,Account.name,origin  from case LIMIT 1];
            system.assertEquals(ocaseRecord.origin, 'Email');
            system.assertNotEquals(ocaseRecord.Account.name, 'Apple123');
            Test.startTest();
            List<ContentVersion> listContentVersion = TestDataFactory.createContentVersionList(5);
            listContentVersion[0].CaseId__c = ocaseRecord.Id;
            insert listContentVersion;
            ContentVersion oConVersion = [select id, Title, ContentDocumentId,CaseId__c  from ContentVersion LIMIT 1];
            system.assertEquals(oConVersion.Title, 'ABC');
            system.assertEquals(oConVersion.CaseId__c,ocaseRecord.Id);
            ContentDocumentLink oDocLink = [Select Id,LinkedEntityId,LinkedEntity.Type FROM ContentDocumentLink WHERE LinkedEntityId =: ocaseRecord.Id LIMIT 1];
            system.assertEquals(oDocLink.LinkedEntityId, ocaseRecord.Id);
            system.assertEquals(oDocLink.LinkedEntity.Type,staticVariableClass.STRING_CASE );
            Test.stopTest();
        }
        /*
         * This Method is used for testclass for ContentVersionService for Linking unzipped File to case
         * @name:createCaseContentVersion
         * Created Date: 04 Mar 2020
         * @Author : Deloitte Consulting
         * @description : User Story 2433   
        */ 
        @isTest
        public static void shareFilesToServiceInternalUseTest(){
            Case oCaseRec = [select id,Account.name,origin  from case LIMIT 1];
            system.assertEquals(oCaseRec.origin, 'Email');
            system.assertNotEquals(oCaseRec.Account.name, 'Apple123');
            Test.startTest();
            List<ContentVersion> listContentVersion = TestDataFactory.createContentVersionList(5);
            insert listContentVersion;
            ContentVersion oConVersion = [select id, Title, ContentDocumentId,CaseId__c  from ContentVersion LIMIT 1];
            system.assertEquals(oConVersion.Title, 'ABC');
            ContentDocumentLink oConDocLink = [Select Id,LinkedEntityId,LinkedEntity.Type FROM ContentDocumentLink WHERE LinkedEntityId =: LGZipUtility.fetchServiceInternalUserId() LIMIT 1];
            system.assertEquals(oConDocLink.LinkedEntityId, LGZipUtility.fetchServiceInternalUserId());
            Test.stopTest();
        }
}
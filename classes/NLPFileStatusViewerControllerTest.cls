@isTest
private class NLPFileStatusViewerControllerTest {
    private static final String INVALID_STATUS_CODE = '9999';
    
    @testSetup
    static void setup()
    {
        // TestDataFactory.createcases method returns n+1 case records
        List<Case> cases = TestDataFactory.createcases(true, 0);
    
        List<Request_Tracking__c> requestTrackings = new List<Request_Tracking__c>();
        requestTrackings.add(
            new Request_Tracking__c(
                CaseID__c = cases[0].Id,
                Status__c = '200',
                RequestID__c = '0'
            )
        );
        requestTrackings.add(
            new Request_Tracking__c(
                CaseID__c = cases[0].Id,
                Status__c = '201',
                RequestID__c = '1'
            )
        );
        requestTrackings.add(
            new Request_Tracking__c(
                CaseID__c = cases[0].Id,
                Status__c = '1001',
                RequestID__c = '2'
            )
        );
        requestTrackings.add(
            new Request_Tracking__c(
                CaseID__c = cases[0].Id,
                Status__c = '200',
                RequestID__c = '3'
            )
        );
        requestTrackings.add(
            new Request_Tracking__c(
                CaseID__c = cases[0].Id,
                Status__c = '',
                RequestID__c = '4'
            )
        );
        insert requestTrackings;
        
        List<ContentVersion> contentVersions = new List<ContentVersion>();
        contentVersions.add (
            new ContentVersion(
                ContentLocation = 'S',
                Title = 'Success File',
                PathOnClient = 'Success.txt',
                VersionData = Blob.valueOf('This is a sample text file'),
                IsMajorVersion = true,
                Response_Status__c = '200',
                Request_Tracking_ID__c = requestTrackings[0].Id
            )
        );
        contentVersions.add (
            new ContentVersion(
                ContentLocation = 'S',
                Title = 'In Progress File',
                PathOnClient = 'InProgress.txt',
                VersionData = Blob.valueOf('This is a sample text file'),
                IsMajorVersion = true,
                Response_Status__c = '201',
                Request_Tracking_ID__c = requestTrackings[1].Id
            )
        );
        contentVersions.add (
            new ContentVersion(
                ContentLocation = 'S',
                Title = 'Error File',
                PathOnClient = 'Error.txt',
                VersionData = Blob.valueOf('This is a sample text file'),
                IsMajorVersion = true,
                Response_Status__c = '',
                Request_Tracking_ID__c = requestTrackings[2].Id
            )
        );
        contentVersions.add (
            new ContentVersion(
                ContentLocation = 'S',
                Title = 'Invalid Status File',
                PathOnClient = 'InvalidStatus.txt',
                VersionData = Blob.valueOf('This is a sample text file'),
                IsMajorVersion = true,
                Response_Status__c = INVALID_STATUS_CODE,
                Request_Tracking_ID__c = requestTrackings[3].Id
            )
        );
        contentVersions.add (
            new ContentVersion(
                ContentLocation = 'S',
                Title = 'Empty Status File',
                PathOnClient = 'EmptyStatus.txt',
                VersionData = Blob.valueOf('This is a sample text file'),
                IsMajorVersion = true,
                Response_Status__c = '',
                Request_Tracking_ID__c = requestTrackings[4].Id
            )
        );
        insert contentVersions;
        
        contentVersions = [
            SELECT Id, ContentDocumentId
            FROM ContentVersion
            LIMIT 10
        ];

        contentVersions[0].Response_Status__c = '200';
        contentVersions[2].Response_Status__c = '';
        contentVersions[3].Response_Status__c = '';
        contentVersions[4].Response_Status__c = '';
        update contentVersions;
        
        List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
        contentDocumentLinks.add(
            new ContentDocumentLink(
                ContentDocumentId = contentVersions[0].ContentDocumentId,
                LinkedEntityId = cases[0].Id,
                ShareType = 'I',
                Visibility = 'InternalUsers'
            )
        );
        contentDocumentLinks.add(
            new ContentDocumentLink(
                ContentDocumentId = contentVersions[1].ContentDocumentId,
                LinkedEntityId = cases[0].Id,
                ShareType = 'I',
                Visibility = 'InternalUsers'
            )
        );
        contentDocumentLinks.add(
            new ContentDocumentLink(
                ContentDocumentId = contentVersions[2].ContentDocumentId,
                LinkedEntityId = cases[0].Id,
                ShareType = 'I',
                Visibility = 'InternalUsers'
            )
        );
        contentDocumentLinks.add(
            new ContentDocumentLink(
                ContentDocumentId = contentVersions[3].ContentDocumentId,
                LinkedEntityId = cases[0].Id,
                ShareType = 'I',
                Visibility = 'InternalUsers'
            )
        );
        contentDocumentLinks.add(
            new ContentDocumentLink(
                ContentDocumentId = contentVersions[4].ContentDocumentId,
                LinkedEntityId = cases[0].Id,
                ShareType = 'I',
                Visibility = 'InternalUsers'
            )
        );
        insert contentDocumentLinks;
    }
    
    @isTest
    static void positiveTest()
    {
        List<Case> cases = [SELECT Id FROM Case LIMIT 1];

        List<ContentVersion> contentVersions = [
            select Id, Response_Status__c
            FROM ContentVersion
        ];
        for(ContentVersion item :contentVersions)
        {
            System.debug('Ethan: ' + item.Response_Status__c);
        }

        Test.startTest();
        List<ContentVersion> items = NLPFileStatusViewerController.getNLPFileStatus(cases[0].Id);
        Test.stopTest();

        System.assertNotEquals(null, items);
        for(ContentVersion contentVersion :items)
        {
            // all Content Version record should have status updated
            System.assertEquals(false, String.isBlank(contentVersion.Response_Status__c));
        }
    }
}
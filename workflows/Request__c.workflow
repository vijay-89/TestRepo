<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_of_Request_Description_change_to_Dev_Lead</fullName>
        <description>Notification of Request Description change to Dev Lead</description>
        <protected>false</protected>
        <recipients>
            <recipient>dl-sfdc-coe-admins@anthem.com.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>PMO/Request_Description_Created_Updated</template>
    </alerts>
    <rules>
        <fullName>Request Description Created%2FUpdated</fullName>
        <actions>
            <name>Notification_of_Request_Description_change_to_Dev_Lead</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>(IsNew() || ISCHANGED( Request_Description__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
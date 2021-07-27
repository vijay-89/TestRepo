<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Notification_To_Sales_When_Implementer_changes_Status_to_Denied</fullName>
        <description>Email Notification To Sales When Implementer changes Status to Denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notification_for_a_Denied_Revision_Record</template>
    </alerts>
    <alerts>
        <fullName>Sends_an_email_to_Sales_when_status_is_Pending_Response_from_Sales_AM</fullName>
        <description>Sends an email to Sales when  status is Pending Response from Sales/AM</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notification_for_a_Revision_Record_Pending_Response_from_Sales_AM</template>
    </alerts>
    <fieldUpdates>
        <fullName>Capture_Status</fullName>
        <field>Status_Capture__c</field>
        <formula>Capture_Impl_Case_status__c</formula>
        <name>Capture Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email Notification To Sales When Implementer changes Status to Denied</fullName>
        <actions>
            <name>Email_Notification_To_Sales_When_Implementer_changes_Status_to_Denied</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Impl_Revision__c.Revision_Record_Status__c</field>
            <operation>equals</operation>
            <value>Denied</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification To Sales When Status to Pending Resp from Sales AM</fullName>
        <actions>
            <name>Sends_an_email_to_Sales_when_status_is_Pending_Response_from_Sales_AM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Impl_Revision__c.Revision_Record_Status__c</field>
            <operation>equals</operation>
            <value>Pending Response From Sales/AM</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Rev01_Capture Status</fullName>
        <actions>
            <name>Capture_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Capture_Impl_Case_status__c  =  TEXT(Implementation_Case_Id__r.Implementation_Status__c)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
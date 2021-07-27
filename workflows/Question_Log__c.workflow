<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_to_Assigned_to_user</fullName>
        <description>Email to Assigned to user</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>PMO/Send_Email_To_Owner_Of_the_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Submitter_of_Question_Log</fullName>
        <description>Email to Submitter of Question Log</description>
        <protected>false</protected>
        <recipients>
            <field>Submitter__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>PMO/Send_Email_To_Submitter_of_the_Question</template>
    </alerts>
    <alerts>
        <fullName>Question_Log_Send_Email_on_Query_Assignment_to_Reportee</fullName>
        <description>Question Log - Send Email on Query Assignment</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Submitter__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>PMO/Question_Log_Send_Email_on_Query_Assignment</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_question_log_request_owner</fullName>
        <description>Send email to question log request owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>PMO/Send_Email_To_Owner_Of_the_Request</template>
    </alerts>
    <rules>
        <fullName>Email to Assigned to User</fullName>
        <actions>
            <name>Email_to_Assigned_to_user</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email to Assigned to User when Question has been created or Assigned To is changed.</description>
        <formula>OR(ISNEW(), ISCHANGED(Assigned_To__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate EMail for Request owner</fullName>
        <actions>
            <name>Send_email_to_question_log_request_owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Question_Log__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Question_Log__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>SaaS Delivery Question Log</value>
        </criteriaItems>
        <description>Ability to make the question log generate an auto e-mail to the owner of the request</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Question Log Clarification is Provided</fullName>
        <actions>
            <name>Email_to_Submitter_of_Question_Log</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Question_Log__c.Status__c</field>
            <operation>equals</operation>
            <value>Clarification Provided</value>
        </criteriaItems>
        <description>When Question Log Clarification has been provided.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Notification_to_SBC_Team</fullName>
        <ccEmails>dl-sbccognizantteam@anthem.com</ccEmails>
        <ccEmails>localtriage@anthem.com</ccEmails>
        <description>Email Notification to SBC Team</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ALERT_Email_Notification_to_SBC_Team_New</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Date_SBC_Requested</fullName>
        <field>Date_SBC_Requested__c</field>
        <formula>NOW()</formula>
        <name>Update Date SBC Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Estimated_SBC_Completion_Date</fullName>
        <field>Estimated_SBC_Completion_Date__c</field>
        <formula>CASE(MOD(TODAY() - DATE(1900, 1, 7), 7), 0,NOW() + 9, 1, NOW() + 9, 2,
    NOW() + 9, 3, NOW() + 9, 4, NOW() + 11, 5, NOW() + 11, NOW() + 10)</formula>
        <name>Update Estimated SBC Completion Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Date Fields</fullName>
        <actions>
            <name>Email_Notification_to_SBC_Team</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Date_SBC_Requested</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Estimated_SBC_Completion_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SBC_SOB_Request__c.Custom_SBC_Requested__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>If Sales User Selects Yes on Custom SBC Requested, set current date to Date SBC Requested and set today + 7 business days out (taking into account weekends) into Estimated SBC completion date and send email to SBC team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
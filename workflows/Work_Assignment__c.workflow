<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_notification_to_work_assigned_User</fullName>
        <description>Send notification to work assigned User</description>
        <protected>false</protected>
        <recipients>
            <field>Name__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Work_Assignment_Template</template>
    </alerts>
    <rules>
        <fullName>Work assignment Rule</fullName>
        <actions>
            <name>Send_notification_to_work_assigned_User</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISNEW() || ISCHANGED(Name__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
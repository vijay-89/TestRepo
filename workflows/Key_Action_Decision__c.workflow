<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_notification_to_Key_Action_assigned_User</fullName>
        <description>Send notification to Key Action assigned User</description>
        <protected>false</protected>
        <recipients>
            <field>AssignedTo__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/KeyAction_Action_Item_Template</template>
    </alerts>
    <rules>
        <fullName>Send Notificaiton on Key Action%2FDecision assigned</fullName>
        <actions>
            <name>Send_notification_to_Key_Action_assigned_User</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>OR(ISNEW(), ISCHANGED( AssignedTo__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
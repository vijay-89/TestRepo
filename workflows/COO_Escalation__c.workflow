<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_CEP_Escalation_Created</fullName>
        <description>New CEP/Escalation Created</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>aa71493@wellpoint.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>delafmn@wellpoint.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CEP_Escalation_Created</template>
    </alerts>
    <alerts>
        <fullName>New_CEP_Escalation_Edited</fullName>
        <description>New CEP/Escalation Edited</description>
        <protected>false</protected>
        <recipients>
            <recipient>aa71493@wellpoint.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>delafmn@wellpoint.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Escalated_by__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CEP_Escalation_Edited</template>
    </alerts>
    <rules>
        <fullName>Notify User of Modified CEP%2FEscalation Record</fullName>
        <actions>
            <name>New_CEP_Escalation_Edited</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>COO_Escalation__c.Issue_Status__c</field>
            <operation>equals</operation>
            <value>Resolved/Closed</value>
        </criteriaItems>
        <description>Notify user when new record is Edited</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify User of New CEP%2FEscalation Record</fullName>
        <actions>
            <name>New_CEP_Escalation_Created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify user when new record is created</description>
        <formula>ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
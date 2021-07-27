<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_alert_on_Defect_Creation</fullName>
        <description>Email alert on Defect Creation</description>
        <protected>false</protected>
        <recipients>
            <field>Developer_Assigned__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>PMO/Defect_Creation_Notification</template>
    </alerts>
    <rules>
        <fullName>Send email for defect creation</fullName>
        <actions>
            <name>Email_alert_on_Defect_Creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Defect__c.Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>Defect__c.Developer_Assigned__c</field>
            <operation>notEqual</operation>
            <value>null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
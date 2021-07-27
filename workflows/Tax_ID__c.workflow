<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Reminder_HCRA_2</fullName>
        <description>Alert Reminder HCRA #2</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Implementer</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Alert_Reminder_HCRA_1_HTML</template>
    </alerts>
    <rules>
        <fullName>Alert Reminder HCRA %232</fullName>
        <actions>
            <name>Alert_Reminder_HCRA_2</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>PRDCRM-27574</description>
        <formula>ISCHANGED(Tax_ID__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
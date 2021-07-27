<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Automated_Email_Reminder_to_SME_USER_DATA</fullName>
        <description>Automated Email Reminder to SME USER DATA</description>
        <protected>false</protected>
        <recipients>
            <field>SME_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Automated_Email_Reminder_to_SME</template>
    </alerts>
</Workflow>
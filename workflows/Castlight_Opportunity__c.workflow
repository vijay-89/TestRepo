<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Castlight_Opportunity_Email_Alert</fullName>
        <description>Castlight Opportunity Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>email__c</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Non_Completion_of_CIForm</template>
    </alerts>
</Workflow>
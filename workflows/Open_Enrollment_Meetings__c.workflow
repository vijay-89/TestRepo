<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>OE_Alternate_Submission</fullName>
        <description>OE Alternate Submission</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Coordinator_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Alternate_Submission_Alert</template>
    </alerts>
    <fieldUpdates>
        <fullName>CalPER_s_8am_8pm_default</fullName>
        <description>If &quot;Local - CA Large Group&quot; = 8:00am -8:00pm defualt time</description>
        <field>Member_Customer_Service_Hrs_of_Operation__c</field>
        <formula>&quot;8:00am - 8:00pm&quot;</formula>
        <name>CalPER&apos;s 8am-8pm default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Local - CA Large Group Default Time</fullName>
        <actions>
            <name>CalPER_s_8am_8pm_default</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Open_Enrollment_Meetings__c.Anthem_Entity__c</field>
            <operation>equals</operation>
            <value>Local/Large Group</value>
        </criteriaItems>
        <criteriaItems>
            <field>Open_Enrollment_Meetings__c.Situs_State__c</field>
            <operation>equals</operation>
            <value>California</value>
        </criteriaItems>
        <description>If &quot;Local - CA Large Group&quot; = 8:00am - 8:00pm default, non-editable</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OE Alternate Submission</fullName>
        <actions>
            <name>OE_Alternate_Submission</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Open_Enrollment_Meetings__c.X10__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send the OE Coordinator an email when the Alternate submission checkbox has been checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
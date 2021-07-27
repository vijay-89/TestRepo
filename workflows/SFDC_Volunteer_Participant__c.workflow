<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_to_Ambassador</fullName>
        <description>Email Alert to Ambassador</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Ambassador_Volunteer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Thanks_but_no_thanks_Non_secured_Ambassadors_Email</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Consultant</fullName>
        <description>Email Alert to Consultant</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Ambassador_Volunteer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Thanks_but_no_thanks_Non_secured_Consultant_Email</template>
    </alerts>
    <alerts>
        <fullName>OE_Ambassador_Volunteer_Thank_you</fullName>
        <description>OE Ambassador Volunteer Thank-you</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Ambassador_Volunteer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Thank_you_for_volunteering_for_a_meeting_Automatic_Email</template>
    </alerts>
    <alerts>
        <fullName>OE_Consultant_Thank_you_for_Volunteering_alert</fullName>
        <description>OE Consultant Thank you for Volunteering alert</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Ambassador_Volunteer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Thank_you_for_volunteering_for_a_meeting_Automatic_Email_Consultants</template>
    </alerts>
    <alerts>
        <fullName>OE_Consultant_Thanks_but_No_Thanks_alert</fullName>
        <description>OE Consultant Thanks but No Thanks alert</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Ambassador_Volunteer__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Thanks_but_no_thanks_Non_secured_Ambassadors_Email</template>
    </alerts>
    <rules>
        <fullName>OE Consultant Thanks but No Thanks</fullName>
        <actions>
            <name>OE_Consultant_Thanks_but_No_Thanks_alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Thanks_but_No_Thanks_email_sent</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Sends an email to thank the consultant volunteer, but to let them know they will not be needed.</description>
        <formula>AND(TEXT(OE_Ambassador_Volunteer__r.Facilitator_Type__c) = &apos;Consultant&apos; , Thanks_but_No_Thanks__c = TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OE Meeting Consultant New Volunteer Thank you</fullName>
        <actions>
            <name>OE_Consultant_Thank_you_for_Volunteering_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This workflow will send an email to thank the Consultant volunteer</description>
        <formula>AND(NOT ISBLANK(OE_Ambassador_Volunteer__c ), TEXT( OE_Ambassador_Volunteer__r.Facilitator_Type__c ) = &apos;Consultant&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>OE New Meeting Ambassador Volunteer</fullName>
        <actions>
            <name>OE_Ambassador_Volunteer_Thank_you</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This workflow will send two emails, One to thank the volunteer and the other to alert the coordinator</description>
        <formula>AND (NOT ISBLANK(OE_Ambassador_Volunteer__c ), TEXT( OE_Ambassador_Volunteer__r.Facilitator_Type__c ) = &apos;OE Ambassador&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Thanks_but_No_Thanks_email_sent</fullName>
        <assignedTo>dl-sfdc-coe-admins@anthem.com.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <description>The Thank you but no Thank you email was sent to this volunteer.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Thanks but No Thanks email sent</subject>
    </tasks>
</Workflow>
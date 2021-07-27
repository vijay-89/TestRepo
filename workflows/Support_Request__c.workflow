<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>COE_User_Management_Team_Alert</fullName>
        <ccEmails>dl-sfdc-coe-admins@anthem.com</ccEmails>
        <ccEmails>jayakiran.pagadala@anthem.com</ccEmails>
        <ccEmails>Madhavi.Indurti@anthem.com</ccEmails>
        <ccEmails>andre.thomas@anthem.com</ccEmails>
        <description>COE User Management Team Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/COE_User_Management_Team_Alert</template>
    </alerts>
    <alerts>
        <fullName>New_Support_Request_LG1</fullName>
        <description>New Support Request LG1</description>
        <protected>false</protected>
        <recipients>
            <recipient>twana.hardy@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORT_New_assignment_BA_non_ANA</template>
    </alerts>
    <alerts>
        <fullName>New_Support_Request_LG2</fullName>
        <description>New Support Request LG2</description>
        <protected>false</protected>
        <recipients>
            <recipient>lizette.marzett@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORT_New_assignment_BA_non_ANA</template>
    </alerts>
    <alerts>
        <fullName>New_Support_Request_LG3</fullName>
        <description>New Support Request LG3</description>
        <protected>false</protected>
        <recipients>
            <recipient>jonathan.weinberger@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORT_New_assignment_BA_non_ANA</template>
    </alerts>
    <alerts>
        <fullName>New_Support_Request_LG4</fullName>
        <description>New Support Request LG4</description>
        <protected>false</protected>
        <recipients>
            <recipient>kenon.richardson@anthem.com2.prod</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORT_New_assignment_BA_non_ANA</template>
    </alerts>
    <alerts>
        <fullName>New_Support_Request_has_been_Submitted</fullName>
        <description>New Support Request has been Submitted ANA</description>
        <protected>false</protected>
        <recipients>
            <recipient>jonathan.weinberger@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kenon.richardson@anthem.com2.prod</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lizette.marzett@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>twana.hardy@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Support_Request_Templates/SUPPORTNewassignmentnotificationBAs</template>
    </alerts>
    <rules>
        <fullName>COE User Management Team Alert</fullName>
        <actions>
            <name>COE_User_Management_Team_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>OR(   ISPICKVAL(Request_Reason__c, &quot;User Access Request&quot;),  ISPICKVAL(Request_Reason__c, &quot;Existing User Access Change&quot;))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Supp Req Create Notify ANA</fullName>
        <actions>
            <name>New_Support_Request_has_been_Submitted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>When a support request is created for ANA, Carrie is notified</description>
        <formula>NOT(ISBLANK(CreatedDate))</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Support_Request__c.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
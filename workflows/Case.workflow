<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Case_closed</fullName>
        <description>Case closed</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORT_Case_closed</template>
    </alerts>
    <alerts>
        <fullName>E2C_Auto_Response_Email</fullName>
        <description>E2C Auto Response Email</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/New_Case_Creation_Response</template>
    </alerts>
    <alerts>
        <fullName>RFPCaseAutoResponse</fullName>
        <description>RFP Intake Case - Case creation auto-email</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderAddress>rfpsupport@anthem.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Support_Request_Templates/RFPIntake_Case_Auto_Response_Template</template>
    </alerts>
    <alerts>
        <fullName>Send_Auto_Response_on_Email_to_Case</fullName>
        <description>Send Auto-Response on Email-to-Case</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Case_Creation_Response</template>
    </alerts>
    <fieldUpdates>
        <fullName>RFPIntakeUpdateCheckbox</fullName>
        <field>Case_Creation_Notification_Sent__c</field>
        <literalValue>1</literalValue>
        <name>RFPIntakeUpdateCheckbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Group_Name</fullName>
        <field>Group_Name__c</field>
        <formula>Account.Name</formula>
        <name>Set Group Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Mailbox_to_Mailbox_Origin</fullName>
        <field>Mailbox__c</field>
        <formula>SUBSTITUTE(Mailbox_Origin__c, &quot;@anthem.com&quot;, &quot;&quot;)</formula>
        <name>Set Mailbox to Mailbox Origin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Pending_End</fullName>
        <field>Pending_End__c</field>
        <formula>NOW()</formula>
        <name>Set Pending End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Pending_End_to_Null</fullName>
        <field>Pending_End__c</field>
        <name>Set Pending End to Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Pending_Start</fullName>
        <field>Pending_Start__c</field>
        <formula>NOW()</formula>
        <name>Set Pending Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>E2C Auto Response Email</fullName>
        <actions>
            <name>E2C_Auto_Response_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Broker Services,L&amp;D E&amp;B,L&amp;D VSH</value>
        </criteriaItems>
        <description>Sends an auto response email when a case is created for the following record types: L&amp;D VSH, Broker Services, L&amp;D E&amp;B</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>RFPIntakeCaseAutoEmail</fullName>
        <actions>
            <name>RFPCaseAutoResponse</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>RFPIntakeUpdateCheckbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>RFP Intake Case - Case creation auto-email</description>
        <formula>ContactId  &lt;&gt; NULL &amp;&amp; (Contact.RecordType.DeveloperName  == &apos;LG_Broker&apos;) &amp;&amp; Case_Creation_Notification_Sent__c  = FALSE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Pending End</fullName>
        <actions>
            <name>Set_Pending_End</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISPICKVAL(Status,&quot;Pending&quot;)) &amp;&amp; ISPICKVAL(PRIORVALUE(Status),&quot;Pending&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Pending Start</fullName>
        <actions>
            <name>Set_Pending_End_to_Null</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Pending_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
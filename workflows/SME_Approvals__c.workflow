<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Automated_Email_Reminder_to_Subject_Matter_Expert_SME</fullName>
        <ccEmails>karthik.kasapa@anthem.com</ccEmails>
        <description>Automated Email Reminder to Subject Matter Expert SME</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Automated_Email_Reminder_to_Subject_Matter_Expert</template>
    </alerts>
    <alerts>
        <fullName>SMEAppr01_Email_to_Sales_Support_on_SME_Approval_Record_upon_status_change</fullName>
        <description>SMEAppr01 Email to Sales Support on SME Approval Record upon status change</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SME_Approval_Record_Sales_Notification</template>
    </alerts>
    <alerts>
        <fullName>SME_Approvals_For_Status_Denied</fullName>
        <description>SME Approvals Status Denied</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Implementer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SME_Approval_For_Status</template>
    </alerts>
    <alerts>
        <fullName>SME_Notification_of_a_SME_Approval_Record_Status_Update</fullName>
        <description>SME Notification of a SME Approval Record Status Update</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Implementer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SME_Notification_of_a_SME_Approval_Record_Status_Update_html</template>
    </alerts>
    <fieldUpdates>
        <fullName>FieldUpdate_KeyAccountRecordTypeUpdate</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Key_Account_SME_Approval</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>FieldUpdate_KeyAccountRecordTypeUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Initiated_to_Approved</fullName>
        <field>Approved_Date__c</field>
        <formula>TODAY()</formula>
        <name>Initiated to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SME_Assigned_Implementer_Field_Update</fullName>
        <field>Assigned_Implementer_Email__c</field>
        <formula>Implementation_Record_ID__r.Assigned_Implementer__r.Email</formula>
        <name>SME Assigned Implementer Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_End_Date_Time_Null_SME</fullName>
        <field>Status_End_Date_Time__c</field>
        <name>Status End Date/Time Null SME</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_End_Date_Time_SME</fullName>
        <field>Status_End_Date_Time__c</field>
        <formula>NOW()</formula>
        <name>Status End Date/Time SME</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Start_Date_Time_Null_SME</fullName>
        <field>Status_Start_Date_Time__c</field>
        <name>Status Start Date/Time Null SME</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Start_Date_Time_SME</fullName>
        <field>Status_Start_Date_Time__c</field>
        <formula>NOW()</formula>
        <name>Status Start Date/Time SME</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateAccountRecordType</fullName>
        <field>AccountRecordTypeSMEAppr__c</field>
        <formula>Implementation_Record_ID__r.Account.RecordType.DeveloperName</formula>
        <name>UpdateAccountRecordType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Automated Email Reminder to Subject Matter Expert SME</fullName>
        <actions>
            <name>Automated_Email_Reminder_to_Subject_Matter_Expert_SME</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND(  Status_End_Date_Time__c - Status_Start_Date_Time__c &gt; 2,  OR(ISPICKVAL(Status__c, &apos;Initiated&apos;),  ISPICKVAL(Status__c, &apos;Pending&apos;) )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SME Approvals For Status</fullName>
        <actions>
            <name>SME_Approvals_For_Status_Denied</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Denied</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SME Notification of a SME Approval Record Status Update</fullName>
        <actions>
            <name>SME_Notification_of_a_SME_Approval_Record_Status_Update</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3) AND 4</booleanFilter>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved with Deviations</value>
        </criteriaItems>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Denied</value>
        </criteriaItems>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>SME</value>
        </criteriaItems>
        <description>SME Notification of a SME Approval Record Status Update</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SME Update Assigned Implementer Email from Implementation Case</fullName>
        <actions>
            <name>SME_Assigned_Implementer_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3</booleanFilter>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved with Deviations</value>
        </criteriaItems>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Denied</value>
        </criteriaItems>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SMEAppr_WF1_AccountRecordType1</fullName>
        <actions>
            <name>UpdateAccountRecordType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>SME_Approvals__c.Implementation_Case_Name__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>SMEAppr_WF2_KeyAccountRecordTypeUpdate</fullName>
        <actions>
            <name>FieldUpdate_KeyAccountRecordTypeUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SME_Approvals__c.Group_Size__c</field>
            <operation>equals</operation>
            <value>51 - 99</value>
        </criteriaItems>
        <description>This WF rule is to change the SME Approval Record Type to Key Account SME Approval when the Account Group Size is equal to 51 - 99</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SMEAppr_WF3_Email Notification for SME Approval Record</fullName>
        <actions>
            <name>SMEAppr01_Email_to_Sales_Support_on_SME_Approval_Record_upon_status_change</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(RecordType.Name = &quot;Key Account SME Approval&quot;,OR(  ISPICKVAL(Status__c,&quot;Pending&quot;), ISPICKVAL(Status__c,&quot;Denied&quot;), ISPICKVAL(Status__c,&quot;Approved with Deviations&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status End Date%2FTime Null SME</fullName>
        <actions>
            <name>Status_Start_Date_Time_Null_SME</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED(Status__c),  OR(  ISPICKVAL(Status__c, &apos;Approved&apos;),  ISPICKVAL(Status__c, &apos;Approved for Castlight (EBA Only)&apos;),  ISPICKVAL(Status__c, &apos;Approved with Deviations&apos;),  ISPICKVAL(Status__c, &apos;Denied&apos;),  ISPICKVAL(Status__c, &apos;N/A&apos;)  ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status End Date%2FTime SME</fullName>
        <actions>
            <name>Status_End_Date_Time_SME</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED(Status__c),  OR( ISPICKVAL(Status__c, &apos;Approved&apos;),  ISPICKVAL(Status__c, &apos;Approved for Castlight (EBA Only)&apos;),  ISPICKVAL(Status__c, &apos;Approved with Deviations&apos;),  ISPICKVAL(Status__c, &apos;Denied&apos;),  ISPICKVAL(Status__c, &apos;N/A&apos;)  ),  OR( ISPICKVAL(PRIORVALUE(Status__c), &quot;Initiated&quot;),  ISPICKVAL(PRIORVALUE(Status__c), &apos;Pending&apos;) )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Start Date%2FTime Null SME</fullName>
        <actions>
            <name>Status_Start_Date_Time_Null_SME</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED(Status__c),  OR(  ISPICKVAL(Status__c, &apos;Approved&apos;),  ISPICKVAL(Status__c, &apos;Approved for Castlight (EBA Only)&apos;),  ISPICKVAL(Status__c, &apos;Approved with Deviations&apos;),  ISPICKVAL(Status__c, &apos;Denied&apos;),  ISPICKVAL(Status__c, &apos;N/A&apos;)  ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Status Start Date%2FTime SME</fullName>
        <actions>
            <name>Status_Start_Date_Time_SME</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( AND( ISNEW(), OR(  ISPICKVAL(Status__c, &apos;Initiated&apos;),  ISPICKVAL(Status__c, &apos;Pending&apos;) ) ), AND(  ISBLANK( Status_Start_Date_Time__c ),  ISCHANGED(Status__c),  OR(  ISPICKVAL(Status__c, &apos;Initiated&apos;),  ISPICKVAL(Status__c, &apos;Pending&apos;)  ) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF01_SMEAPPR_Approved_Date</fullName>
        <actions>
            <name>Initiated_to_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SME_Approvals__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved,Approved for Castlight (EBA Only),Approved with Deviations,Denied</value>
        </criteriaItems>
        <criteriaItems>
            <field>SME_Approvals__c.Group_Size__c</field>
            <operation>equals</operation>
            <value>51 - 99</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
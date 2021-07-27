<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AM_Approved_Email_to_EBA_Lead</fullName>
        <description>AM Approved Email to EBA Lead</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/AM_Approves_The_BPD_Record</template>
    </alerts>
    <alerts>
        <fullName>AM_Rejected_Email_to_EBA_Lead</fullName>
        <description>AM Rejected Email to EBA Lead</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Sales_AM_Rejects_The_BPD_Record</template>
    </alerts>
    <alerts>
        <fullName>Approved_by_Impl_Email_Notification_to_EBA_Lead</fullName>
        <description>Approved by Impl Email Notification to EBA Lead</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/submits_BPD_record_to_AM_for_approval</template>
    </alerts>
    <alerts>
        <fullName>BPD_EBA_Lead_Approval_Email</fullName>
        <description>BPD EBA Lead Approval Email</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BPD_EBA_Lead_Approval_Email</template>
    </alerts>
    <alerts>
        <fullName>EBA_Lead_Email_on_Rejection</fullName>
        <description>EBA Lead Email  on Rejection</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BPD_EBA_Lead_Rejection_Email</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_to_EBA_when_ESR_Approves</fullName>
        <description>Email Notification to EBA when ESR Approves</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EBA_Email_Notification_when_ESR_Approves</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_to_EBA_when_ESR_Rejects</fullName>
        <description>Email Notification to EBA when ESR Rejects</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EBA_Email_Notification_when_ESR_Rejects</template>
    </alerts>
    <alerts>
        <fullName>Implementations_Rejected_email_to_EBA_Lead</fullName>
        <description>Implementations Rejected email to EBA Lead</description>
        <protected>false</protected>
        <recipients>
            <field>EBA_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Initially_Rejects_The_BPD_Record</template>
    </alerts>
    <fieldUpdates>
        <fullName>AI_rejected</fullName>
        <field>Approval_Process_Field_Updates__c</field>
        <literalValue>AI Rejected</literalValue>
        <name>AI rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AM_Approved</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>AM Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AM_Rejected_Chatter_to_AI</fullName>
        <field>Approval_Process_Field_Updates__c</field>
        <literalValue>AM Rejected to Implementer1</literalValue>
        <name>AM Rejected Chatter to AI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AP_Fieldupdate_To_None</fullName>
        <field>Approval_Process_Field_Updates__c</field>
        <name>AP Fieldupdate To None</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BPD_Status_AM_Rejected</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>BPD Status AM Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BPD_status_to_Approved</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>BPD status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BPD_status_to_Pending_from_Sales</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Pending Response from Sales/AM</literalValue>
        <name>BPD status to Pending from Sales</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BPD_status_to_Rejected</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>BPD status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Disabler_Checkbox_PBO3</fullName>
        <field>Disabler_Enabler_Checkbox_of_PBO2__c</field>
        <literalValue>1</literalValue>
        <name>Disabler Checkbox PBO3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Disabler_Checkbox_of_PBO2</fullName>
        <field>Disabler_Enabler_Checkbox_of_PBO2__c</field>
        <literalValue>1</literalValue>
        <name>Disabler Checkbox of PBO2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Disabler_Checkbox_of_PBO3</fullName>
        <field>Disabler_Enabler_Checkbox_of_PBO2__c</field>
        <literalValue>1</literalValue>
        <name>Disabler Checkbox of PBO3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Enabler_Checkbox</fullName>
        <field>EnablerCheckbox_for_PB__c</field>
        <literalValue>1</literalValue>
        <name>Enabler Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Enabler_Checkbox_for_PBO2</fullName>
        <field>Disabler_Enabler_Checkbox_of_PBO2__c</field>
        <literalValue>0</literalValue>
        <name>Enabler Checkbox for PBO2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FIeldUpdate_BPD_Was_Updated</fullName>
        <field>BPD_Edit_Counting__c</field>
        <formula>BPD_Edit_Counting__c + 1</formula>
        <name>FIeldUpdate_BPD Was Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Initial_Submission_BPDstatus</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Initiated In Implementations Review</literalValue>
        <name>Initial Submission BPDstatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lock_the_Record_for_ESR</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Lock the Record for ESR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Logic_to_Send_One_Not_to_AI</fullName>
        <field>Logic_to_Send_One_Not_to_AI__c</field>
        <literalValue>1</literalValue>
        <name>Logic to Send One Not to AI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_by_AM_Flag</fullName>
        <field>Rejected_by_AM__c</field>
        <literalValue>1</literalValue>
        <name>Rejected by AM Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Resubmission_to_true</fullName>
        <field>Resubmitting_for_Approval__c</field>
        <literalValue>1</literalValue>
        <name>Resubmission to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Resubmission_true</fullName>
        <field>Resubmitting_for_Approval__c</field>
        <literalValue>1</literalValue>
        <name>Resubmission true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Resubmit_to_true</fullName>
        <field>Resubmitting_for_Approval__c</field>
        <literalValue>1</literalValue>
        <name>Resubmit to true</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Skip_Implementer_Approval_AMRejection</fullName>
        <field>Skip_Implementer_Approval_BPD__c</field>
        <literalValue>1</literalValue>
        <name>Skip Implementer Approval_AMRejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Skip_Implementer_Approval_ESRRejection</fullName>
        <field>Skip_Implementer_Approval_BPD__c</field>
        <literalValue>1</literalValue>
        <name>Skip Implementer Approval_ESRRejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Skip_Implementer_Approval_EqualsToFalse</fullName>
        <field>Skip_Implementer_Approval_BPD__c</field>
        <literalValue>0</literalValue>
        <name>Skip Implementer Approval_EqualsToFalse</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Rejected</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Rejected_for_Resubmission</fullName>
        <field>Tech_Rejected__c</field>
        <literalValue>ESR Rejected</literalValue>
        <name>Status Rejected for Resubmission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Rejected_for_Resubmission_for_AM</fullName>
        <field>Tech_Rejected__c</field>
        <literalValue>AM Rejected</literalValue>
        <name>Status Rejected for Resubmission for AM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_To_Rejected</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Status To Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Approved</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_none</fullName>
        <field>BPD_Status__c</field>
        <name>Status to none</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_update</fullName>
        <field>BPD_Status__c</field>
        <name>Status update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_update_to_Initiated</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Initiated In Implementations Review</literalValue>
        <name>Status update to Initiated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_update_to_Pending</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Pending Response from ESR</literalValue>
        <name>Status update to Pending from ESR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_update_to_Rejected</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Status update to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tech_AM_Rejected1</fullName>
        <field>Tech_Rejected__c</field>
        <literalValue>AM Rejected</literalValue>
        <name>Tech AM Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tech_Implementer_Rejected</fullName>
        <field>Tech_Rejected__c</field>
        <literalValue>Implementer Rejected</literalValue>
        <name>Tech Implementer Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tech_rejected_to_None</fullName>
        <field>Tech_Rejected__c</field>
        <name>Tech rejected to None</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Tech_rejected_to_None_AM_Approves</fullName>
        <field>Tech_Rejected__c</field>
        <name>Tech rejected to None_AM Approves</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_BPD_Status_To_IMRejected</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update BPD Status To IMRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_BPD_Status_to_Pending</fullName>
        <field>BPD_Status__c</field>
        <literalValue>Pending Response from Sales/AM</literalValue>
        <name>Update BPD Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_BPD_Is_Approved</fullName>
        <field>Approved_BPD__c</field>
        <formula>TODAY()</formula>
        <name>Update Date BPD Is Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_BPD_Sent_To_AM</fullName>
        <field>Pending_BPD__c</field>
        <formula>TODAY()</formula>
        <name>Update Date BPD Sent To_AM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_BPD_Sent_To_AM1</fullName>
        <field>Pending_BPD__c</field>
        <formula>TODAY()</formula>
        <name>Update Date BPD Sent To_AM1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_When_BPD_Was_Approved</fullName>
        <field>Approved_BPD__c</field>
        <formula>Today()</formula>
        <name>Update Date When BPD Was Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Initial_Date_EBA_Sent_BPD_To_Imp</fullName>
        <field>Initial_Date_EBA_Sent_BPD_To_Imp__c</field>
        <formula>IF(
ISBLANK( Initial_Date_EBA_Sent_BPD_To_Imp__c ),

TODAY(), Initial_Date_EBA_Sent_BPD_To_Imp__c

)</formula>
        <name>Update Initial Date EBA Sent BPD To Imp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Initial_Date_ESR_Sent_BPD_To_Acct</fullName>
        <field>Initial_Date_ESR_Sent_BPD_To_Acct_Mgmt__c</field>
        <formula>IF(
ISBLANK(  Initial_Date_ESR_Sent_BPD_To_Acct_Mgmt__c  ),

TODAY(), null

)</formula>
        <name>Update Initial Date ESR Sent BPD To Acct</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Master_Duplicate</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email to EBA Lead on Rejection</fullName>
        <actions>
            <name>EBA_Lead_Email_on_Rejection</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>BPD__c.BPD_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF1_BPD_Number Of Times BPD Was Updated</fullName>
        <actions>
            <name>FIeldUpdate_BPD_Was_Updated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This will calculate the number of the BPD record is edited</description>
        <formula>AND(ISPICKVAL(PRIORVALUE(BPD_Status__c),&quot;Rejected&quot;),            ISPICKVAL(BPD_Status__c,&quot;Initiated In Implementations Review&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
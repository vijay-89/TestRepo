<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EmailToAssignedImplementer</fullName>
        <description>EmailToAssignedImplementer</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Implementer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EmailToAssignedImplementer</template>
    </alerts>
    <alerts>
        <fullName>Notification_For_ID_Cards</fullName>
        <description>Notification For ID Cards</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notifications_For_ID_Cards</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_AM</fullName>
        <description>Send email to AM</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notifications_For_ID_Cards</template>
    </alerts>
    <fieldUpdates>
        <fullName>Blank_value_to_P1_Digital_ID_Counts</fullName>
        <field>P1_Digital_ID_Counts__c</field>
        <name>Blank value to &apos;P1 Digital ID Counts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_value_to_P2_Digital_ID_Counts</fullName>
        <field>P2_Digital_ID_Counts__c</field>
        <name>Blank value to &apos;P2 Digital ID Counts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_value_to_P3_Digital_ID_Counts</fullName>
        <field>P3_Digital_ID_Counts__c</field>
        <name>Blank value to &apos;P3 Digital ID Counts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_value_to_P4_Digital_ID_Counts</fullName>
        <field>P4_Digital_ID_Counts__c</field>
        <name>Blank value to &apos;P4 Digital ID Counts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blank_value_to_P5_Digital_ID_Counts</fullName>
        <field>P5_Digital_ID_Counts__c</field>
        <name>Blank value to &apos;P5 Digital ID Counts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_10</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field Update to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_11</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field Update to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_16</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field Update to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_17</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field Update to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_2</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field Update to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_4</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field Update to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_7</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field Update to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_8</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field Update to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_to_False_Mock_Peer</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field Update to False Mock Peer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_to_True0</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field Update to True0</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_to_True_Mock_Peer</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field Update to True Mock Peer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_update_18</fullName>
        <field>Field_Update__c</field>
        <literalValue>0</literalValue>
        <name>Field update to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_update_to_True1</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field update to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_update_to_True15</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field update to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_update_to_True2</fullName>
        <field>Field_Update__c</field>
        <literalValue>1</literalValue>
        <name>Field update to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ID_Req_Rejected</fullName>
        <field>ID_Requirements_Approved__c</field>
        <literalValue>0</literalValue>
        <name>ID Req Rejected is false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ID_Requirements_Approved</fullName>
        <field>ID_Requirements_Approved__c</field>
        <literalValue>1</literalValue>
        <name>ID Requirements Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ID_Requirements_Rejected</fullName>
        <field>ID_Requirements_Approved__c</field>
        <literalValue>0</literalValue>
        <name>ID Requirements Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Id_Card_Approved_Date3</fullName>
        <description>Approval date is captured in Idcards Object</description>
        <field>ID_card_Approved_Date__c</field>
        <formula>Now()</formula>
        <name>Id Card Approved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Id_Card_Approved_Date4</fullName>
        <field>ID_card_Approved_Date__c</field>
        <formula>Now()</formula>
        <name>Id Card Approved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LG_IDCardsOwnerAssignment</fullName>
        <field>OwnerId</field>
        <lookupValue>ID_Cards_Local</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>LG_IDCardsOwnerAssignment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notif_for_Approval2</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>To AI Approved</literalValue>
        <name>Notif for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notif_for_approval1</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Approved1</literalValue>
        <name>Notif for approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notif_for_approval3</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>To_AM_Approved</literalValue>
        <name>Notif for approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notif_for_rejection1</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Rejected1</literalValue>
        <name>Notif for rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notif_for_rejection2</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>To AI Rejected</literalValue>
        <name>Notif for rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notif_for_rejection3</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>To_AM_Rejected</literalValue>
        <name>Notif for rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notify_Approved2</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Approved2</literalValue>
        <name>Notify Approved2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notify_Approved2Peer</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Approved2Peer</literalValue>
        <name>Notify Approved2Peer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notify_Rejected2</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Rejected2</literalValue>
        <name>Notify Rejected2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Notify_Rejected2Peer</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Rejected2Peer</literalValue>
        <name>Notify Rejected2Peer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>P2_Job_ID_Number_update</fullName>
        <field>P2_Job_ID_Number__c</field>
        <name>P2 Job ID Number update &apos;&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Approved</fullName>
        <field>Record_Approved__c</field>
        <literalValue>1</literalValue>
        <name>Record Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_not_approved</fullName>
        <field>Record_Approved__c</field>
        <literalValue>0</literalValue>
        <name>Record not approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit_to_PA</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Submitted to PA</literalValue>
        <name>Submit to PA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_to_AI_Field_Update</fullName>
        <field>ApprovalStatus__c</field>
        <literalValue>Submitted to AI 2nd approval</literalValue>
        <name>Submitted to AI Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P1_Number_of_Imps_Prod_Card_Apprd</fullName>
        <field>P1_Number_of_Imps_Prod_Card_Approved__c</field>
        <name>Update P1 Number of Imps Prod Card Apprd</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P1_Number_of_Imps_Prod_Card_Audit</fullName>
        <field>P1_Number_of_Imps_Prod_Card_Audited__c</field>
        <name>Update P1 Number of Imps Prod Card Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P2_Number_of_Imps_Prod_Card_Apprd</fullName>
        <field>P2_Number_of_Imps_Prod_Card_Approved__c</field>
        <name>Update P2 Number of Imps Prod Card Apprd</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P2_Number_of_Imps_Prod_Card_Audit</fullName>
        <field>P2_Number_of_Imps_Prod_Card_Audited__c</field>
        <name>Update P2 Number of Imps Prod Card Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P3_Number_of_Imps_Prod_Card_Appr</fullName>
        <field>P3_Number_of_Imps_Prod_Card_Approved__c</field>
        <name>Update P3 Number of Imps Prod Card Appr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P3_Number_of_Imps_Prod_Card_Audit</fullName>
        <field>P3_Number_of_Imps_Prod_Card_Audited__c</field>
        <name>Update P3 Number of Imps Prod Card Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P4_Number_of_Imps_Prod_Card_Appr</fullName>
        <field>P4_Number_of_Imps_Prod_Card_Approved__c</field>
        <name>Update P4 Number of Imps Prod Card Appr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P4_Number_of_Imps_Prod_Card_Audit</fullName>
        <field>P4_Number_of_Imps_Prod_Card_Audited__c</field>
        <name>Update P4 Number of Imps Prod Card Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P5_Number_of_Imps_Prod_Card_Appr</fullName>
        <field>P5_Number_of_Imps_Prod_Card_Approved__c</field>
        <name>Update P5 Number of Imps Prod Card Appr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_P5_Number_of_Imps_Prod_Card_Audit</fullName>
        <field>P5_Number_of_Imps_Prod_Card_Audited__c</field>
        <name>Update P5 Number of Imps Prod Card Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_N_A_value_to_P1_Job_ID_Number</fullName>
        <field>P1_Job_ID_Number__c</field>
        <formula>&apos;N/A&apos;</formula>
        <name>update &apos;N/A&apos; value to &apos;P1 Job ID Number&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_N_A_value_to_P2_Job_ID_Number</fullName>
        <field>P2_Job_ID_Number__c</field>
        <formula>&apos;N/A&apos;</formula>
        <name>update &apos;N/A&apos; value to &apos;P2 Job ID Number&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_N_A_value_to_P3_Job_ID_Number</fullName>
        <field>P3_Job_ID_Number__c</field>
        <formula>&apos;N/A&apos;</formula>
        <name>update &apos;N/A&apos; value to &apos;P3 Job ID Number&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_N_A_value_to_P4_Job_ID_Number</fullName>
        <field>P4_Job_ID_Number__c</field>
        <formula>&apos;N/A&apos;</formula>
        <name>update &apos;N/A&apos; value to &apos;P4 Job ID Number&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_N_A_value_to_P5_Job_ID_Number</fullName>
        <field>P5_Job_ID_Number__c</field>
        <formula>&apos;N/A&apos;</formula>
        <name>update &apos;N/A&apos; value to &apos;P5 Job ID Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_blank_value_to_P1_Job_ID_Number</fullName>
        <field>P1_Job_ID_Number__c</field>
        <name>update blank value to &apos;P1 Job ID Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_blank_value_to_P3_Job_ID_Number</fullName>
        <field>P3_Job_ID_Number__c</field>
        <name>update blank value to P3 Job ID Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_blank_value_to_P4_Job_ID_Number</fullName>
        <field>P4_Job_ID_Number__c</field>
        <name>update blank value to P4 Job ID Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_blank_value_to_P5_Job_ID_Number</fullName>
        <field>P5_Job_ID_Number__c</field>
        <name>update blank value to P5 Job ID Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>%27is production ID cards P1 applicable%27 equals Yes and Job P1 equals N%2FA</fullName>
        <actions>
            <name>Blank_value_to_P1_Digital_ID_Counts</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P1_Number_of_Imps_Prod_Card_Apprd</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P1_Number_of_Imps_Prod_Card_Audit</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_blank_value_to_P1_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P1_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>ID_Cards__c.P1_Job_ID_Number__c</field>
            <operation>equals</operation>
            <value>N/A</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>%27is production ID cards P2 applicable%27 equals Yes and Job P2 equals N%2FA</fullName>
        <actions>
            <name>Blank_value_to_P2_Digital_ID_Counts</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>P2_Job_ID_Number_update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P2_Number_of_Imps_Prod_Card_Apprd</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P2_Number_of_Imps_Prod_Card_Audit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P2_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>ID_Cards__c.P2_Job_ID_Number__c</field>
            <operation>equals</operation>
            <value>N/A</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>%27is production ID cards P3 applicable%27 equals Yes and Job P3 equals N%2FA</fullName>
        <actions>
            <name>Blank_value_to_P3_Digital_ID_Counts</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P3_Number_of_Imps_Prod_Card_Appr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P3_Number_of_Imps_Prod_Card_Audit</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_blank_value_to_P3_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P3_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>ID_Cards__c.P3_Job_ID_Number__c</field>
            <operation>equals</operation>
            <value>N/A</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>%27is production ID cards P4 applicable%27 equals Yes and Job P4 equals N%2FA</fullName>
        <actions>
            <name>Blank_value_to_P4_Digital_ID_Counts</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P4_Number_of_Imps_Prod_Card_Appr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P4_Number_of_Imps_Prod_Card_Audit</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_blank_value_to_P4_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P4_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>ID_Cards__c.P4_Job_ID_Number__c</field>
            <operation>equals</operation>
            <value>N/A</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>%27is production ID cards P5 applicable%27 equals Yes and Job P5 equals N%2FA</fullName>
        <actions>
            <name>Blank_value_to_P5_Digital_ID_Counts</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P5_Number_of_Imps_Prod_Card_Appr</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_P5_Number_of_Imps_Prod_Card_Audit</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_blank_value_to_P5_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P5_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>ID_Cards__c.P5_Job_ID_Number__c</field>
            <operation>equals</operation>
            <value>N/A</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LG_IdCardsOwnerAssignment</fullName>
        <actions>
            <name>LG_IDCardsOwnerAssignment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISBLANK(Id)), RecordType.Name == &apos;Local&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>P1 Job ID Number update %27N%2FA%27</fullName>
        <actions>
            <name>update_N_A_value_to_P1_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P1_Applicable__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>&apos;is production ID cards P1 applicable&apos; equals No
update &apos;N/A&apos; value to &apos;P1 Job ID Number&apos;.
otherwise
field can be blank and user can enter a value .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P2 Job ID Number update %27N%2FA%27</fullName>
        <actions>
            <name>update_N_A_value_to_P2_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P2_Applicable__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>&apos;is production ID cards P2 applicable&apos; equals No
update &apos;N/A&apos; value to &apos;P2 Job ID Number&apos;.
otherwise
field can be blank and user can enter a value .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P3 Job ID Number update %27N%2FA%27</fullName>
        <actions>
            <name>update_N_A_value_to_P3_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P3_Applicable__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>&apos;is production ID cards P3 applicable&apos; equals No
update &apos;N/A&apos; value to &apos;P3 Job ID Number&apos;.
otherwise
field can be blank and user can enter a value .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P4 Job ID Number update %27N%2FA%27</fullName>
        <actions>
            <name>update_N_A_value_to_P4_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P4_Applicable__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>&apos;is production ID cards P4 applicable&apos; equals No
update &apos;N/A&apos; value to &apos;P4 Job ID Number&apos;.
otherwise
field can be blank and user can enter a value .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>P5 Job ID Number update %27N%2FA%27</fullName>
        <actions>
            <name>update_N_A_value_to_P5_Job_ID_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ID_Cards__c.Is_Production_ID_Cards_P5_Applicable__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>&apos;is production ID cards P5 applicable&apos; equals No
update &apos;N/A&apos; value to &apos;P5 Job ID Number&apos;.
otherwise
field can be blank and user can enter a value .</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SendEmailToAssignedImplementer</fullName>
        <actions>
            <name>EmailToAssignedImplementer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Created for Jira #39701</description>
        <formula>ISPICKVAL(Stage__c,&quot;04 Pending Card Review&quot;) &amp;&amp; Implementation_Case_Name__c!=&apos;&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Group_Structure_Approved</fullName>
        <description>Group Structure Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Assigned_Implementer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Group_Structure_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_By_Implementator</fullName>
        <field>Submitted_For_Implementer__c</field>
        <literalValue>1</literalValue>
        <name>Approved By Implementator</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_to_Pending</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Change Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Implementer_Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Implementer Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Implementer_Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Implementer Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revert_Submit_For_Implementer_on_Reject</fullName>
        <field>Submitted_For_Implementer__c</field>
        <literalValue>0</literalValue>
        <name>Revert Submit For Implementer on Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revert_Submitted_For_Implementer</fullName>
        <field>Submitted_For_Implementer__c</field>
        <literalValue>0</literalValue>
        <name>Revert Submitted For Implementer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Manager_Email</fullName>
        <field>Account_Manager_Email__c</field>
        <formula>Implementation_Tracking_ID__r.Implementation_Record_ID__r.Account_Manager__r.Email</formula>
        <name>Update Account Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Group Structure Approved</fullName>
        <actions>
            <name>Group_Structure_Approved</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Account_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>PRDCRM-27575 &amp; PRDCRM-33203</description>
        <formula>AND(  ISCHANGED(Group_Structure_Approved__c),   YEAR(Group_Structure_Approved__c)  &gt;= 2000)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
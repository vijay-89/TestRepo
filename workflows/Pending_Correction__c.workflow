<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>LG_Pending_Correction_Email_Notification_for_Rx</fullName>
        <description>LG Pending Correction Email Notification for Rx</description>
        <protected>false</protected>
        <recipients>
            <field>Rx_Owner__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LG_Pending_Correction_Email_Notification_for_Rx</template>
    </alerts>
    <alerts>
        <fullName>Pending_Correction_Notification_For_Assigned_Implementer_when_Approved</fullName>
        <description>Pending Correction Notification For Assigned Implementer when Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Implementer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pending_Correction_Notification_for_Approved</template>
    </alerts>
    <alerts>
        <fullName>Pending_Correction_Notification_For_Assigned_Implementer_when_Declined</fullName>
        <description>Pending Correction Notification For Assigned Implementer when Declined</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Implementer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pending_Correction_Notification_for_Declined</template>
    </alerts>
    <alerts>
        <fullName>Pending_Correction_Notification_For_SME</fullName>
        <description>Pending Correction Notification For SME</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pending_Correction_Sales_Notification</template>
    </alerts>
    <alerts>
        <fullName>Pending_Correction_Sales_Notification</fullName>
        <description>Pending Correction Sales Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Sales_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Pending_Correction_Sales_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Email_Update</fullName>
        <field>Sales_Email__c</field>
        <formula>Implementation_Case__r.CreatedBy.Email</formula>
        <name>Email Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stamp_Assigned_Implementer_Email_id</fullName>
        <field>Assigned_Implementer_Email__c</field>
        <formula>Implementation_Case__r.Assigned_Implementer__r.Email</formula>
        <name>Stamp Assigned Implementer Email id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Pending Correction Sales Notification</fullName>
        <actions>
            <name>Pending_Correction_Sales_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(ISPICKVAL( Implementation_Case__r.Account.Group_Size__c , &quot;51 - 99&quot;),ISPICKVAL(  Stage__c , &quot;Pending Response From Implementations/Sales&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Stamp Assigned Implementer Email id in Pending Correction</fullName>
        <actions>
            <name>Stamp_Assigned_Implementer_Email_id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1&lt;&gt;0</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
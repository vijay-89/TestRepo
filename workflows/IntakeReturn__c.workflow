<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Intake_Return_Stage_Age</fullName>
        <description>Intake Return Stage Age</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Implementer_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Intake_Return_Stage_Age</template>
    </alerts>
    <alerts>
        <fullName>LG_Notification_to_Sales_on_Intake_Return</fullName>
        <description>LG Notification to Sales on Intake Return</description>
        <protected>false</protected>
        <recipients>
            <field>Case_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_Sales_on_IR</template>
    </alerts>
    <alerts>
        <fullName>LG_Notification_to_Sales_on_Intake_Return_Follow_Up</fullName>
        <description>LG Notification to Sales on Intake Return Follow Up</description>
        <protected>false</protected>
        <recipients>
            <field>Case_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_Sales_on_IR_FollowUp</template>
    </alerts>
    <alerts>
        <fullName>Notification_to_Sales_on_Intake_Return</fullName>
        <description>Notification to Sales on Intake Return</description>
        <protected>false</protected>
        <recipients>
            <field>Case_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notification_to_Sales_on_Intake_Return</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Assigned_Implementer_Email</fullName>
        <field>Assigned_Implementer_Email__c</field>
        <formula>OrderId__r.Assigned_Implementer__r.Email</formula>
        <name>Update Assigned Implementer Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Intake Return Stage Age</fullName>
        <active>false</active>
        <criteriaItems>
            <field>IntakeReturn__c.Stage__c</field>
            <operation>equals</operation>
            <value>Pending Response from Sales/ Account Management</value>
        </criteriaItems>
        <description>Sends email 48 hours after Intake Return Stage set to &quot;Pending Response from Sales/Account Management&apos; for 48 hours.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Intake_Return_Stage_Age</name>
                <type>Alert</type>
            </actions>
            <timeLength>48</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Assigned Implementer</fullName>
        <actions>
            <name>Update_Assigned_Implementer_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Assigned_Implementer__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates field Assigned Implementer Email</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
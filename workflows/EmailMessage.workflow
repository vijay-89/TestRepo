<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Increment_Email_Count</fullName>
        <field>Email_Count__c</field>
        <formula>Parent.Email_Count__c + 1</formula>
        <name>Increment Email Count</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Email_Count_to_Zero</fullName>
        <field>Email_Count__c</field>
        <formula>0</formula>
        <name>Set Email Count to Zero</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Mailbox_Origin</fullName>
        <field>Mailbox_Origin__c</field>
        <formula>IF(ISNULL(ToAddress), CcAddress, ToAddress &amp; &quot;; &quot; &amp;  CcAddress)</formula>
        <name>Set Mailbox Origin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Response_Date</fullName>
        <field>Response_Date__c</field>
        <formula>NOW()</formula>
        <name>Set Response Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_to_Response_Received</fullName>
        <field>Status</field>
        <literalValue>Response Received</literalValue>
        <name>Set Status to Response Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status_change</fullName>
        <description>upon receiving an inbound email the case status should change to Response received</description>
        <field>Status</field>
        <literalValue>Response received</literalValue>
        <name>status change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Email Status change</fullName>
        <actions>
            <name>status_change</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>upon receiving an inbound email the case status should change to Response received</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Email Response</fullName>
        <actions>
            <name>Increment_Email_Count</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Response_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Status_to_Response_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Email_Count__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>When Email is received, set Status to Response Received and Response Date to NOW</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Mailbox Origin on Case</fullName>
        <actions>
            <name>Set_Email_Count_to_Zero</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Mailbox_Origin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Email_Count__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Set the Mailbox Origin on the Case to the Mailbox that the Case is generated from</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
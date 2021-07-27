<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Account_Client_CAG_Start_Date</fullName>
        <field>ClientCAGStartDate__c</field>
        <formula>Client_CAG_Start_Date__c</formula>
        <name>Set Account Client CAG Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Account__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Update Account Client CAG Start Date</fullName>
        <actions>
            <name>Set_Account_Client_CAG_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ContactRelationship__c.Client_CAG_Start_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
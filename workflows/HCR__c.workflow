<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>HCRPopulate_Account_recordType</fullName>
        <field>AccountRecordTypeHCR__c</field>
        <formula>Group__r.Account__r.RecordType.DeveloperName</formula>
        <name>HCRPopulate Account recordType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>HCR_WF_AccountRecordType</fullName>
        <actions>
            <name>HCRPopulate_Account_recordType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>HCR__c.Account_Name__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Account_Record_Type</fullName>
        <field>AccountRecordTypeExtVen__c</field>
        <formula>Implementation_Case__r.Account.RecordType.DeveloperName</formula>
        <name>Populate Account Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ExtVendorFFTI_WF1_AccountRecordType</fullName>
        <actions>
            <name>Populate_Account_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>External_Vendor_File_Feeds_To_Implement__c.ImpCaseName__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
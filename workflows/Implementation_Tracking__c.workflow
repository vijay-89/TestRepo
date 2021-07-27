<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Imp_Trcking_PopulateAccountRecordtype</fullName>
        <field>AccountRecordTypeImpTracking__c</field>
        <formula>Account_Legal_Name__r.RecordType.DeveloperName</formula>
        <name>Imp_Trcking_PopulateAccountRecordtype</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Imp_Tracking_WF_AccountRecordType</fullName>
        <actions>
            <name>Imp_Trcking_PopulateAccountRecordtype</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Implementation_Tracking__c.AccountLegalNameForWF1__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
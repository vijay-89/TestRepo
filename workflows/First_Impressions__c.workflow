<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>LG_FirstImpressionsOwnerAssignment</fullName>
        <field>OwnerId</field>
        <lookupValue>First_Impression_Local</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>LG_FirstImpressionsOwnerAssignment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Not_Started_Dt</fullName>
        <field>Not_Started_Date_Completed__c</field>
        <formula>NOW()</formula>
        <name>Update Not Started Dt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>LG_FirstImpressionsOwnerAssignment</fullName>
        <actions>
            <name>LG_FirstImpressionsOwnerAssignment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(Id))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Not Started Dt</fullName>
        <actions>
            <name>Update_Not_Started_Dt</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>First_Impressions__c.First_Impressions_Stage__c</field>
            <operation>equals</operation>
            <value>01 Not Started</value>
        </criteriaItems>
        <criteriaItems>
            <field>First_Impressions__c.Not_Started_Date_Completed__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
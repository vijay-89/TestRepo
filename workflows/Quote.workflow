<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>FU_Quote_Mark_as_JAA_False</fullName>
        <field>JAAIndicator__c</field>
        <literalValue>0</literalValue>
        <name>FU - Quote - Mark as JAA False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_Quote_Mark_as_JAA_True</fullName>
        <field>JAAIndicator__c</field>
        <literalValue>1</literalValue>
        <name>FU - Quote - Mark as JAA True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WF01_Quote_JAA-Adding</fullName>
        <actions>
            <name>FU_Quote_Mark_as_JAA_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Quote.Is_JAA__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF01_Quote_JAA-Removing</fullName>
        <actions>
            <name>FU_Quote_Mark_as_JAA_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Quote.Is_JAA__c</field>
            <operation>lessOrEqual</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
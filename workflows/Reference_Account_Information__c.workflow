<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>RAI01_Logo</fullName>
        <description>Mark as True if &quot;All&quot; is true</description>
        <field>Logos__c</field>
        <literalValue>1</literalValue>
        <name>RAI01- Logo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RAI02_UpdatePresentations</fullName>
        <description>When the All Checkbox is selected, select all Checkboxes for Referencable Accounts</description>
        <field>Presentations__c</field>
        <literalValue>1</literalValue>
        <name>RAI02- UpdatePresentations</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RAI03_UpdateProposals</fullName>
        <description>When the All Checkbox is selected, select all Checkboxes for Referencable Accounts</description>
        <field>Proposals__c</field>
        <literalValue>1</literalValue>
        <name>RAI03- Update Proposals</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RAI04_UpdateSpeeches</fullName>
        <description>Reference Account Information: Speeches</description>
        <field>Speeches__c</field>
        <literalValue>1</literalValue>
        <name>RAI04- Update Speeches</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>ANA_WF_RAI01_Referencable Account- Select All</fullName>
        <actions>
            <name>RAI01_Logo</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>RAI02_UpdatePresentations</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>RAI03_UpdateProposals</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>RAI04_UpdateSpeeches</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Reference_Account_Information__c.All__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.BypassWorkflow__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>When the All Checkbox is selected, select all Checkboxes for Referencable Accounts</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
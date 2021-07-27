<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Let_Opp_Know_of_Sales_Comp</fullName>
        <field>Has_Sales_Comp_Attached__c</field>
        <literalValue>1</literalValue>
        <name>Let Opp Know of Sales Comp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Opportunity__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Count Sales Comps</fullName>
        <actions>
            <name>Let_Opp_Know_of_Sales_Comp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Sales_Compensation__c.WF_Fired__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
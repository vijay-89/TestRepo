<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_OE_Materials_Delivered</fullName>
        <field>Materials_Delivered__c</field>
        <literalValue>1</literalValue>
        <name>Update OE Materials Delivered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Open_Enrollment__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>OE Mark Delivered Checkbox</fullName>
        <actions>
            <name>Update_OE_Materials_Delivered</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Total_Fulfillments__c  &gt; 0 &amp;&amp;( Delivered_Order_Fulfillments__c = Total_Fulfillments__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
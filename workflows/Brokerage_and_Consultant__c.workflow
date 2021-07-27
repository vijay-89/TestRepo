<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>BRKC01_UpdateNameofBrokerage</fullName>
        <description>Update Name of Brokerage field on Brokerage and Consultant</description>
        <field>NameofBrokerage__c</field>
        <formula>If(ISBLANK(Brokerage__c),Brokerage_LG__r.Name,Brokerage__r.Name )</formula>
        <name>BRKC01_Update Name of Brokerage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>BRKC02_UpdateNameofConsultant</fullName>
        <description>Consultant__r.FirstName&amp;&quot; &quot;&amp;Consultant__r.LastName</description>
        <field>NameofConsultant__c</field>
        <formula>If(ISBLANK(Consultant__c),Consultant_LG__r.FirstName__c &amp;&quot; &quot;&amp; Consultant_LG__r.LastName__c ,Consultant__r.FirstName__c &amp;&quot; &quot;&amp; Consultant__r.LastName__c )</formula>
        <name>BRKC02_Update Name of Consultant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ANA_WF_BRKC01_Brokerage and Consultant - Update Name of Brokerage</fullName>
        <actions>
            <name>BRKC01_UpdateNameofBrokerage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Pushes the name of the Brokerage to a text field for reporting uses</description>
        <formula>AND( NOT( $User.BypassWorkflow__c) , ISBLANK( Id )=FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_WF_BRKC02_Brokerage and Consultant - Update Name of Consultant</fullName>
        <actions>
            <name>BRKC02_UpdateNameofConsultant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Evaluate the rule when a record is created, and every time it&apos;s edited</description>
        <formula>AND(  NOT($User.BypassWorkflow__c) , ISBLANK( Id )=FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Cert_Sent_Date_Vision</fullName>
        <field>Cert_Sent_Date__c</field>
        <name>Cert Sent Date Vision</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cert_Team_Received_Date_Vision</fullName>
        <field>Cert_Team_Received_Date__c</field>
        <name>Cert Team Received Date Vision</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Off_cycle_Owners</fullName>
        <field>OwnerId</field>
        <lookupValue>Renewals_and_Offcycle_Changes_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Off cycle Owners</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TS_Cert_Team_Received_Date_Vision</fullName>
        <field>Cert_Team_Received_Date__c</field>
        <formula>TODAY()</formula>
        <name>TS Cert Team Received Date Vision</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Approved</fullName>
        <field>Date_Approved__c</field>
        <formula>IF(ISPICKVAL( Stage__c , &apos;04 Approved&apos;) , NOW() ,null)</formula>
        <name>Update Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>New_groups_and_Upsells_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Queue</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_the_Date_Assigned</fullName>
        <field>LG_Date_Assigned__c</field>
        <formula>today()</formula>
        <name>Update the Date Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Clear Cert Team Received Date Vision</fullName>
        <actions>
            <name>Cert_Sent_Date_Vision</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Cert_Team_Received_Date_Vision</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Vision__c.Ready_for_Cert__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LG_Update _Vision_Date assigned WR</fullName>
        <actions>
            <name>Update_the_Date_Assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is to update the Date Assigned field whenever the Owner is changed from Queue to User</description>
        <formula>NOT(ISNEW())&amp;&amp; ISChanged(OwnerId) &amp;&amp; BEGINS(OwnerId, $Label.Owner_IsUser_Local)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Owner update on Implementation Type New Business</fullName>
        <actions>
            <name>Update_Owner_to_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is to update owner of the Vision record to New business queue if the Implementation type is (New Business, Upsell, Pre Work) or Upsell value is &apos;Yes&apos;</description>
        <formula>OR( Implementation_Type__c == &apos;New Business&apos;, Implementation_Type__c == &apos;Upsell&apos;,Implementation_Type__c == &apos;Pre Work&apos;,  TEXT(Upsell__c) == &apos;Yes&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Owner update on Implementation Type Offcycle</fullName>
        <actions>
            <name>Off_cycle_Owners</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is to update owner of Vision record to the Offcycle queue if the Implementation type is (Renewal, Change Request Off Cycle)</description>
        <formula>OR( Implementation_Type__c == &apos;Renewal&apos;, Implementation_Type__c == &apos;Change Request Off Cycle&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Cert Team Received Date Vision</fullName>
        <actions>
            <name>TS_Cert_Team_Received_Date_Vision</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Vision__c.Ready_for_Cert__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Populates the present time for &quot;Cert Team Received Date&quot; when the &quot;Ready for Cert&quot; is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Date Approved</fullName>
        <actions>
            <name>Update_Date_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule to update Date Approved field when the Stage is &apos;Approved&apos;</description>
        <formula>ISCHANGED( Stage__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
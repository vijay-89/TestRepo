<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Impact_Packages_Field_Populated_with_N_A</fullName>
        <field>Impacted_Packages_Suffixes_Sections__c</field>
        <formula>&quot;N/A&quot;</formula>
        <name>Impact/Packages Field Populated with N/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revision_Reason_lock</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Reason_LockAll</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Revision Reason lock</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Revision Reason lock</fullName>
        <actions>
            <name>Revision_Reason_lock</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Impl_Revision__c.Revision_Record_Status__c</field>
            <operation>equals</operation>
            <value>Ready for Implementations</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Revision_Reason_Impacted</fullName>
        <actions>
            <name>Impact_Packages_Field_Populated_with_N_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Impl_Revision__c.Record_Type__c</field>
            <operation>equals</operation>
            <value>New Business</value>
        </criteriaItems>
        <criteriaItems>
            <field>Revision_Reason__c.PreWork_Type__c</field>
            <operation>equals</operation>
            <value>RFP</value>
        </criteriaItems>
        <description>For New Business and PW type = RFP the field &quot;Impacted Packages/Suffixes/Sections&quot; will be defaulted to &quot;N/A&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
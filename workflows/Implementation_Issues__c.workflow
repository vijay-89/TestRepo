<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Nulify_DIT_analyst_name</fullName>
        <field>If_DIT_Issue_Analyst_Name__c</field>
        <name>Nulify DIT analyst name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>nullify_Groupservices_issue_analyst_name</fullName>
        <description>nullify Groupservices issue analyst name</description>
        <field>If_Group_Service_Issue_Analyst_Name__c</field>
        <name>nullify Groupservices issue analyst name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>nullify_IDcard_analyst_name</fullName>
        <description>nullify IDcard analyst name</description>
        <field>If_ID_Card_Issue_Analyst_Name__c</field>
        <name>nullify IDcard analyst name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WF Update Dit analyst name</fullName>
        <actions>
            <name>Nulify_DIT_analyst_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Implementation_Issues__c.Is_Post_Implementation_Issue_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Implementation_Issues__c.If_DIT_Issue_Analyst_Name__c</field>
            <operation>equals</operation>
            <value>n/a</value>
        </criteriaItems>
        <description>WF Update Dit analyst name</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF Update IDcard analyst name</fullName>
        <actions>
            <name>nullify_IDcard_analyst_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Implementation_Issues__c.Is_Post_Implementation_Issue_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Implementation_Issues__c.If_ID_Card_Issue_Analyst_Name__c</field>
            <operation>equals</operation>
            <value>n/a</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_nullify Group Services analyst name</fullName>
        <actions>
            <name>nullify_Groupservices_issue_analyst_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Implementation_Issues__c.Is_Post_Implementation_Issue_Applicable__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Implementation_Issues__c.If_Group_Service_Issue_Analyst_Name__c</field>
            <operation>equals</operation>
            <value>n/a</value>
        </criteriaItems>
        <description>nullify Group Services analyst name</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Approved_or_Declined</fullName>
        <description>Today&apos;s Date Captured In The Field Approved Or Declined Date</description>
        <field>Approved_or_Declined_Date__c</field>
        <formula>TODAY()</formula>
        <name>Approved or Declined</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LG_CaseInstallationOwnerAssignment</fullName>
        <field>OwnerId</field>
        <lookupValue>Issue_Controls_Local</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>LG_CaseInstallationOwnerAssignment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Not_Started</fullName>
        <description>Today&apos;s Date Captured In The Field Not Started Date</description>
        <field>Not_Started_Date__c</field>
        <formula>TODAY()</formula>
        <name>Not Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Correction</fullName>
        <description>Today&apos;s Date Captured In The Field Pending Correction Date</description>
        <field>Pending_Correction_Date__c</field>
        <formula>TODAY()</formula>
        <name>Pending Correction</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Correction_to_Approved_Decline</fullName>
        <description>Updates Field With Today&apos;s Date, If Stage value change from &quot;03 Pending Correction&quot; to &quot;04 Approved&quot; or &quot;05 Declined&quot;</description>
        <field>Pending_Correction_to_Approved_Declined__c</field>
        <formula>TODAY()</formula>
        <name>Pending Correction to Approved/Decline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>LG_CaseInstallationOwnerAssignment</fullName>
        <actions>
            <name>LG_CaseInstallationOwnerAssignment</name>
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
            <field>Issue_Control__c.Stage__c</field>
            <operation>equals</operation>
            <value>01 Not Started</value>
        </criteriaItems>
        <criteriaItems>
            <field>Issue_Control__c.Not_Started_Date_Completed__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF01_Issue_Control_Approved_Declined_Date</fullName>
        <actions>
            <name>Approved_or_Declined</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Control__c.Stage__c</field>
            <operation>equals</operation>
            <value>04 Approved,05 Declined</value>
        </criteriaItems>
        <description>Updates Field With Today&apos;s Date, If Its Approved Or Declined When Stage Equals 04 Approved,05 Declined.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF02_Issue_Control_Not_Started_Date</fullName>
        <actions>
            <name>Not_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Control__c.Stage__c</field>
            <operation>equals</operation>
            <value>01 Not Started</value>
        </criteriaItems>
        <description>Updates Field With Today&apos;s Date, If Its Not Started When Stage Equals 01 Not Started.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF03_Issue_Control_Pending_Correction_Date</fullName>
        <actions>
            <name>Pending_Correction</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue_Control__c.Stage__c</field>
            <operation>equals</operation>
            <value>03 Pending Correction</value>
        </criteriaItems>
        <description>Updates Field With Today&apos;s Date, If Its Pending Correction When Stage Equals 03 Pending Correction.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF05_Issue_Control_Pending_To_Approved_Declined</fullName>
        <actions>
            <name>Pending_Correction_to_Approved_Decline</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Field With Today&apos;s Date, If  Stage value change from &quot;03 Pending Correction&quot; to &quot;04 Approved&quot; or &quot;05 Declined&quot;</description>
        <formula>AND(ISCHANGED(Stage__c),ISPICKVAL(PRIORVALUE(Stage__c),&apos;03 Pending Correction&apos;),  OR(ISPICKVAL(Stage__c , &apos;04 Approved&apos;),ISPICKVAL(Stage__c , &apos;05 Declined&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
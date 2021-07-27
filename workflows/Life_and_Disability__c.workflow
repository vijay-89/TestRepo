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
        <fullName>Cert_Sent_Date</fullName>
        <field>Cert_Sent_Date__c</field>
        <name>Cert Sent Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cert_Team_Received_Date</fullName>
        <field>Cert_Team_Received_Date__c</field>
        <name>Cert Team Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Keep_Original_Dental_Check_Date</fullName>
        <field>Life_and_Disability_Original_Check_Date__c</field>
        <formula>PRIORVALUE( Original_L_D_Complete_Date__c)</formula>
        <name>Keep Original LD Check Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Life_and_Disability_Original_Check_Date</fullName>
        <field>Life_and_Disability_Original_Check_Date__c</field>
        <formula>TODAY()</formula>
        <name>Life and Disability Original Check Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>Pending_Correction_to_Not_Started</fullName>
        <description>Updates Field With Today&apos;s Date, If Stage value change from &quot;03 Pending Correction&quot; to &quot;01 Not Started&quot;</description>
        <field>Pending_Correction_to_Not_Started__c</field>
        <formula>TODAY()</formula>
        <name>Pending Correction to Not Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TS_Cert_Team_Received_Date</fullName>
        <field>Cert_Team_Received_Date__c</field>
        <formula>TODAY()</formula>
        <name>TS Cert Team Received Date</name>
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
        <fullName>Update_Date_Assigned_Field</fullName>
        <field>LG_Date_Assigned__c</field>
        <formula>today()</formula>
        <name>Update Date Assigned Field</name>
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
    <rules>
        <fullName>Clear Cert Team Received Date</fullName>
        <actions>
            <name>Cert_Sent_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Cert_Team_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Life_and_Disability__c.Ready_for_Cert__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LG_Update _LD_Date assigned WR</fullName>
        <actions>
            <name>Update_Date_Assigned_Field</name>
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
        <description>This workflow is to update owner of the L&amp;D record to New business queue if the Implementation type is (New Business, Upsell, Pre Work) or Upsell value is &apos;Yes&apos;</description>
        <formula>AND(OR( Implementation_Type__c == &apos;New Business&apos;, Implementation_Type__c == &apos;Upsell&apos;,Implementation_Type__c == &apos;Pre Work&apos;,  TEXT(Upsell__c) == &apos;Yes&apos;),Implementation_Type__c !=&apos;Full group Term&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Owner update on Implementation Type Offcycle</fullName>
        <actions>
            <name>Off_cycle_Owners</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is to update owner of L&amp;D record to the Offcycle queue if the Implementation type is (Renewal, Change Request Off Cycle)</description>
        <formula>OR( Implementation_Type__c == &apos;Renewal&apos;, Implementation_Type__c == &apos;Change Request Off Cycle&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Cert Team Received Date</fullName>
        <actions>
            <name>TS_Cert_Team_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Life_and_Disability__c.Ready_for_Cert__c</field>
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
    <rules>
        <fullName>WF01_Life_Disability_Approved_Declined_Date</fullName>
        <actions>
            <name>Approved_or_Declined</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Life_and_Disability__c.Stage__c</field>
            <operation>equals</operation>
            <value>04 Approved,05 Declined</value>
        </criteriaItems>
        <description>Updates Field With Today&apos;s Date, If Its Approved Or Declined When Stage Equals 04 Approved,05 Declined.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF02_Life_Disability_Not_Started_Date</fullName>
        <actions>
            <name>Not_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Life_and_Disability__c.Stage__c</field>
            <operation>equals</operation>
            <value>01 Not Started</value>
        </criteriaItems>
        <description>Updates Field With Today&apos;s Date, If Its Not Started When Stage Equals 01 Not Started.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF03_Life_Disability_Pending_Correction_Date</fullName>
        <actions>
            <name>Pending_Correction</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Life_and_Disability__c.Stage__c</field>
            <operation>equals</operation>
            <value>03 Pending Correction</value>
        </criteriaItems>
        <description>Updates Field With Today&apos;s Date, If Its Pending Correction When Stage Equals 03 Pending Correction.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF04_Life_Disability_Original_Check_Date2</fullName>
        <actions>
            <name>Keep_Original_Dental_Check_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Keeps Original Date Of The Previous Dept Check.</description>
        <formula>PRIORVALUE(Original_L_D_Complete_Date__c) &lt;&gt; TODAY()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF05_Life_and_Disability_Pending_To_Approved_Declined</fullName>
        <actions>
            <name>Pending_Correction_to_Approved_Decline</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Field With Today&apos;s Date, If  Stage value change from &quot;03 Pending Correction&quot; to &quot;04 Approved&quot; or &quot;05 Declined&quot;</description>
        <formula>AND(ISCHANGED(Stage__c),ISPICKVAL(PRIORVALUE(Stage__c),&apos;03 Pending Correction&apos;),  OR(ISPICKVAL(Stage__c , &apos;04 Approved&apos;),ISPICKVAL(Stage__c , &apos;05 Declined&apos;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF06_Life_and_Disability_Pending_To_Not_Started</fullName>
        <actions>
            <name>Pending_Correction_to_Not_Started</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Field With Today&apos;s Date, If Stage value change from &quot;03 Pending Correction&quot; to &quot;01 Not Started&quot;</description>
        <formula>AND(ISCHANGED(Stage__c),ISPICKVAL(PRIORVALUE(Stage__c),&apos;03 Pending Correction&apos;), ISPICKVAL(Stage__c , &apos;01 Not Started&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF07_Life and Disability Original Check Date</fullName>
        <actions>
            <name>Life_and_Disability_Original_Check_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Captures Date When Previous Dept. Are Approved</description>
        <formula>AND( Implementation_Tracking_ID__r.SBC_Approved__c, Implementation_Tracking_ID__r.UW_Approved__c, Implementation_Tracking_ID__r.UW_Life_Disability_Approved__c, Implementation_Tracking_ID__r.UW_Medical_Approved__c, Implementation_Tracking_ID__r.UW_Vision_Approved__c, Implementation_Tracking_ID__r.InterPlan_Approved__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
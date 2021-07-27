<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>PG_Billing_Info_Status_Update</fullName>
        <description>Status update to Complete</description>
        <field>Status__c</field>
        <literalValue>Complete</literalValue>
        <name>PG Billing Info Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PG_Billing_Update_Completed_date</fullName>
        <field>Completed_Date__c</field>
        <formula>LastModifiedDate</formula>
        <name>PG Billing Update Completed date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_in_Process_Date</fullName>
        <description>Updates &apos;Billing in Process Date&apos; to the date that the status is moved to &apos;Billing in Process&apos;.</description>
        <field>Billing_in_Process_Date__c</field>
        <formula>TODAY()</formula>
        <name>Update Billing in Process Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Billing_in_Process</fullName>
        <description>Updating &apos;Status&apos; to Billing in Process</description>
        <field>Status__c</field>
        <literalValue>Billing in Process</literalValue>
        <name>Update Status to &apos;Billing in Process&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PG Billing Info Status Update</fullName>
        <actions>
            <name>PG_Billing_Info_Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PG_Billing_Info__c.Billing_Upload_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PG_Billing_Info__c.Confirmed_Signed_Contract__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>PG_Billing_Info__c.Did_You_Get_UW_VP_Approval__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This will update the &quot;PG Billing info&quot; status to Complete when &quot;Billing Upload Date&quot; is not null</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PG Billing Info Status change to %27Billing in Process%27</fullName>
        <actions>
            <name>Update_Billing_in_Process_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Billing_in_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This will update the &quot;PG Billing info&quot; status to &apos;Billing in Process&apos;</description>
        <formula>OR(( (ISBLANK(Billing_Upload_Date__c )) &amp;&amp; ( Generic_1_Amount__c &lt; 500 ) &amp;&amp; (NOT(ISBLANK(UW_RVP_Approver__c ))) &amp;&amp; OR((ISPICKVAL(Confirmed_Signed_Contract__c, &quot;Yes&quot;)),(ISPICKVAL(Confirmed_Signed_Contract__c, &quot;No&quot;)))),  ((ISBLANK(Billing_Upload_Date__c )) &amp;&amp; ( Generic_1_Amount__c &gt;= 500 ) &amp;&amp; (OR(NOT(ISBLANK(UW_RVP_Approver__c )),  NOT(ISBLANK(Additional_Required_Approvals__c)) )) &amp;&amp; OR((ISPICKVAL(Confirmed_Signed_Contract__c, &quot;Yes&quot;)), (ISPICKVAL(Confirmed_Signed_Contract__c, &quot;No&quot;))) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PG Billing Update Completed date</fullName>
        <actions>
            <name>PG_Billing_Update_Completed_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PG_Billing_Info__c.Status__c</field>
            <operation>equals</operation>
            <value>Complete</value>
        </criteriaItems>
        <description>This rule is created to update the completed date when the status changes to complete.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
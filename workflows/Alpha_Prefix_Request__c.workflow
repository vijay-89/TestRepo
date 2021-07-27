<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>APR01SendAPRCompleteEmailConfirmation</fullName>
        <description>APR01_Send APR Complete Email Confirmation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/APR_PrefixConfirmedFromIP</template>
    </alerts>
    <alerts>
        <fullName>APR_Approved_Email_Alert</fullName>
        <description>APR Approved Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/APR_Approved_Email</template>
    </alerts>
    <alerts>
        <fullName>APR_Rejected_Email_Alert2</fullName>
        <description>APR Rejected Email Alert2</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/APR_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>APR_02UpdateProdNetworkCount</fullName>
        <description>Updates the Prod/Network Count field so that we can verify that the # of Products Added matches the # of Prefixes added to close out the request.</description>
        <field>Prod_Network_Count__c</field>
        <formula>of_Products_Networks_Requested__c</formula>
        <name>APR_02Update Prod/Network Count</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APR_PopulateAccountRecordType</fullName>
        <field>AccountRecordTypeAlphaNum__c</field>
        <formula>Group__r.Account__r.RecordType.DeveloperName</formula>
        <name>APR_PopulateAccountRecordType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Submitted</fullName>
        <description>Updates the Date Submitted field on the Alpha Prefix detail page. This field is read only and indicates when the Alpha Prefix request was submitted.</description>
        <field>Date_Submitted__c</field>
        <formula>NOW()</formula>
        <name>Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_to_Submitted_To_InterPlan</fullName>
        <field>Status__c</field>
        <literalValue>Submitted to InterPlan</literalValue>
        <name>Status to Submitted To InterPlan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Set_APR_Status_to_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Set APR Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Set_APR_Status_to_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Set APR Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ANA_WF_APR01_ Request Complete</fullName>
        <actions>
            <name>APR01SendAPRCompleteEmailConfirmation</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Alpha_Prefix_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Request Complete,Prefix Assigned</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.BypassWorkflow__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA_WF_APR_02Count %23 Of Products When Submitted</fullName>
        <actions>
            <name>APR_02UpdateProdNetworkCount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Alpha_Prefix_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted to InterPlan</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.BypassWorkflow__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Counts the number of Products added when Submitted to InterPlan (locks it).</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>AlphPrefixRequest_WF_AccountRecordType</fullName>
        <actions>
            <name>APR_PopulateAccountRecordType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Alpha_Prefix_Request__c.AccountLegalName__c</field>
            <operation>notEqual</operation>
            <value>Null</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
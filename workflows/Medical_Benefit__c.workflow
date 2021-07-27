<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>LG_MedicalBenefit_SME_Email_Alert</fullName>
        <description>LG_MedicalBenefit_SME_Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Pending_Correction_Creator__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LG_EmailAlert_Template_BenefitAnalyst</template>
    </alerts>
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
        <fullName>LG_SendEmailAlert_To_BenefitAnalyst</fullName>
        <actions>
            <name>LG_MedicalBenefit_SME_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Medical_Benefit__c.Stage__c</field>
            <operation>equals</operation>
            <value>03 Pending Correction Returned</value>
        </criteriaItems>
        <criteriaItems>
            <field>Medical_Benefit__c.Pending_Correction_Creator__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Medical_Benefit__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Medical Benefit_Local</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Not Started Dt</fullName>
        <actions>
            <name>Update_Not_Started_Dt</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Medical_Benefit__c.Stage__c</field>
            <operation>equals</operation>
            <value>01 Not Started</value>
        </criteriaItems>
        <criteriaItems>
            <field>Medical_Benefit__c.Not_Started_Date_Completed__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
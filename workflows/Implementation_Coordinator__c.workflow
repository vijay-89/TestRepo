<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>IMPLCoordinatorNotificationAlert</fullName>
        <ccEmails>ahrproductsupport@anthem.com</ccEmails>
        <description>IMPLCoordinatorNotificationAlert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/IMPLCoordinatorNotificationTemplate</template>
    </alerts>
    <rules>
        <fullName>IMPLCoordinatorNotificationRule</fullName>
        <actions>
            <name>IMPLCoordinatorNotificationAlert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notification of Group Structure Change to Clinical Team (PRDCRM-52806)</description>
        <formula>AND(OR(ISCHANGED(Is_Group_Structure_Applicable__c),ISCHANGED(Group_Structure_Approval_ACD__c))  ,AND(          ISPICKVAL(Implementation_Tracking_ID__r.Implementation_Record_ID__r.Quote.Opportunity.Account.Anthem_Entity__c, &apos;National Accounts&apos;)        ,Implementation_Type__c = &quot;Change Request Off Cycle&quot;        ,OR ( Claim_System__c = &apos;WGS 2.0&apos;,Claim_System__c =  &apos;NASCO&apos;)              ,ISPICKVAL(Is_Group_Structure_Applicable__c,&apos;Yes&apos;)        ,AND ( !ISNULL(Group_Structure_Approval_ACD__c), Group_Structure_Approval_ACD__c &lt;&gt; DATE(1700, 01, 01),Group_Structure_Approval_ACD__c &lt;&gt; DATE(1900, 01, 01))       )    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
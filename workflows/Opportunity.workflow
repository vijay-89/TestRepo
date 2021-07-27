<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EOB_Custom_Appeal</fullName>
        <ccEmails>eobmailbox@anthem.com</ccEmails>
        <description>EOB Custom Appeal</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EOB_Grievance_Appeal</template>
    </alerts>
    <alerts>
        <fullName>OPP01_Notification120dayspriorOpptyEffDate</fullName>
        <description>OPP01_Notification 120 days prior Oppty Eff. Date</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Executive</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/OPP_ReminderEmailOpptynotComplete</template>
    </alerts>
    <alerts>
        <fullName>OPP01_Notification_120_days_prior_Oppty_Eff_Date</fullName>
        <description>OPP01_Notification 120 days prior Oppty Eff. Date</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Executive</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/OPP_ReminderEmailOpptynotComplete</template>
    </alerts>
    <alerts>
        <fullName>OPP02_Notification90dayspriorOpptyEffDate</fullName>
        <description>OPP02_Notification 90 days prior Oppty Eff. Date</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Executive</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/OPP_ReminderEmailOpptynotComplete</template>
    </alerts>
    <alerts>
        <fullName>OPP02_Notification_90_days_prior_Oppty_Eff_Date</fullName>
        <description>OPP02_Notification 90 days prior Oppty Eff. Date</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Executive</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/OPP_ReminderEmailOpptynotComplete</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Underwriters</fullName>
        <description>Send Email to Underwriters</description>
        <protected>false</protected>
        <recipients>
            <recipient>Underwriters_Nevada</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/UW_Received_Date_Notification_Email_Nevada</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Underwriters_Ohio</fullName>
        <description>Send Email to Underwriters Ohio</description>
        <protected>false</protected>
        <recipients>
            <recipient>Underwriters_Ohio</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/UW_Received_Date_Notification_Email_Ohio</template>
    </alerts>
    <fieldUpdates>
        <fullName>OPP01_UpdateEffectiveDatetoPriorDate</fullName>
        <description>This Field Update will change the Effective Date to the Date it was prior to setting the opportunity to closed won or renewal finalized</description>
        <field>CloseDate</field>
        <formula>PRIORVALUE( CloseDate )</formula>
        <name>OPP01_UpdateEffective Date to Prior Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ANA WF OPP Email Notification based on Oppty Effective Date</fullName>
        <active>true</active>
        <description>Timebased Email Notification 90/120 days prior to Opportunity Effective Date to Account Executive if email is not closed.</description>
        <formula>AND(!$User.BypassWorkflow__c, RecordType.Name=&quot;Renewal&quot;,OR( ISPICKVAL(StageName, &quot;Initiated&quot;),ISPICKVAL(StageName, &quot;Quoting&quot;),ISPICKVAL(StageName, &quot;Submitted to Customer&quot;),ISPICKVAL(StageName, &quot;Jeopardy&quot;),ISPICKVAL(StageName, &quot;Finalist&quot;),ISPICKVAL(StageName, &quot;Verbal Commitment&quot;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OPP02_Notification90dayspriorOpptyEffDate</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>OPP01_Notification120dayspriorOpptyEffDate</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-120</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ANA WF OPP Email Notification based on Oppty Effective Date Local Sales</fullName>
        <active>false</active>
        <description>Timebased Email Notification 90/120 days prior to Opportunity Effective Date to Account Executive if email is not closed.</description>
        <formula>AND(!$User.BypassWorkflow__c,  $Profile.Name= &apos;Local Sales&apos;, RecordType.Name=&quot;Renewal Local&quot;,OR( ISPICKVAL(StageName, &quot;Initiated&quot;),ISPICKVAL(StageName, &quot;Quoting&quot;),ISPICKVAL(StageName, &quot;Submitted to Customer&quot;),ISPICKVAL(StageName, &quot;Jeopardy&quot;),ISPICKVAL(StageName, &quot;Finalist&quot;),ISPICKVAL(StageName, &quot;Verbal Commitment&quot;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OPP02_Notification90dayspriorOpptyEffDate</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>OPP01_Notification120dayspriorOpptyEffDate</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-120</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>ANA_OPP01_Set Effective Date to Prior Date on Win</fullName>
        <actions>
            <name>OPP01_UpdateEffectiveDatetoPriorDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won,Renewal Finalized</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.CloseDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.BypassWorkflow__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Salesforce defaults the &quot;closed date&quot; to today when an opportunity is closed/won. We use the field as effective date and don&apos;t want it changed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF OPP Email Notification based on Oppty Effective Date Local Sales</fullName>
        <active>true</active>
        <description>Timebased Email Notification 90/120 days prior to Opportunity Effective Date to Account Executive if email is not closed.</description>
        <formula>AND(!$User.BypassWorkflow__c, OR($Profile.Name =&apos;Local sales&apos;,$Profile.Name =&apos;Local sales Dual&apos;), RecordType.Name=&quot;Renewal Local&quot;,OR( ISPICKVAL(StageName, &quot;Initiated&quot;),ISPICKVAL(StageName, &quot;Quoting&quot;), ISPICKVAL(StageName, &quot;Submitted to Customer&quot;),ISPICKVAL(StageName, &quot;Jeopardy&quot;), ISPICKVAL(StageName, &quot;Finalist&quot;),ISPICKVAL(StageName, &quot;Verbal Commitment&quot;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OPP02_Notification_90_days_prior_Oppty_Eff_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>OPP01_Notification_120_days_prior_Oppty_Eff_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>-120</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Opp Custom Appeal Email Alert</fullName>
        <actions>
            <name>EOB_Custom_Appeal</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Custom_first_level_grievance_and_appeal__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>UW Received Date Email Nevada</fullName>
        <actions>
            <name>Send_Email_to_Underwriters</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Quote_sent_to_UW__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Anthem_Entity__c</field>
            <operation>equals</operation>
            <value>Local/Large Group</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Situs_State__c</field>
            <operation>equals</operation>
            <value>Nevada</value>
        </criteriaItems>
        <description>A notification email is sent out to the underwriters when UW Received Date is populated on an opportunity for Local/Large Group for states Nevada</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>UW Received Date Email Ohio</fullName>
        <actions>
            <name>Send_Email_to_Underwriters_Ohio</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Quote_sent_to_UW__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Anthem_Entity__c</field>
            <operation>equals</operation>
            <value>Local/Large Group</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Situs_State__c</field>
            <operation>equals</operation>
            <value>Ohio</value>
        </criteriaItems>
        <description>A notification email is sent out to the underwriters when UW Received Date is populated on an opportunity for Local/Large Group for states Ohio</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
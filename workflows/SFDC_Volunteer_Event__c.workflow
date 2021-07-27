<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AE_Sales_Survey_Reminder</fullName>
        <description>AE Sales Survey Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Executive_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/AE_Sales_Feedback_Survey_Email</template>
    </alerts>
    <alerts>
        <fullName>AM_Sales_Survey_Reminder</fullName>
        <description>AM Sales Survey Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/AM_Sales_Feedback_Survey_Email</template>
    </alerts>
    <alerts>
        <fullName>Client_SAR_Survey_Reminder</fullName>
        <description>Client SAR Survey Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Client_Engagement_Consultant_SAR_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Client_Engagement_SAR_Feedback_Survey_Email</template>
    </alerts>
    <alerts>
        <fullName>OE_Contractor_Coordinator_Accepted_email</fullName>
        <description>OE Contractor Coordinator Acceptedemail</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Consultant_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>OE_Coordinator_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Consultant_Accepted</template>
    </alerts>
    <alerts>
        <fullName>OE_Contractor_Coordinator_Decline_email</fullName>
        <description>OE Contractor Coordinator Decline email</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Consultant_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>OE_Coordinator_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Consultant_DEcline</template>
    </alerts>
    <alerts>
        <fullName>OE_Contractor_Rescinded</fullName>
        <description>OE Contractor Rescinded</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Consultant_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>OE_Coordinator_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Consultant_Rescinded</template>
    </alerts>
    <alerts>
        <fullName>OE_Coordinator_consultant_action_is_selected</fullName>
        <description>OE email to the OE Coordinator and the OE manager when a consultant action is selected</description>
        <protected>false</protected>
        <recipients>
            <field>OE_Consultant_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>OE_Coordinator_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Consultant_Action</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_Feedback_Reminder1</fullName>
        <description>OE Meeting Feedback Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator1__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Open_Enrollment_Email_Templates/Feedback_Survey_Reminder_Email</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_Feedback_Reminder2</fullName>
        <description>OE Meeting Feedback Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator1__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Open_Enrollment_Email_Templates/Local_Sales_Feedback_Survey_Reminder_Email</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_Invite_Facilitator_1</fullName>
        <description>OE Meeting Invite Facilitator 1</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator1__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Calendar_Invite1</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_Invite_Facilitator_2</fullName>
        <description>OE Meeting Invite Facilitator 2</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator_Two__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Calendar_Invite1</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_Invite_Facilitator_3</fullName>
        <description>OE Meeting Invite Facilitator 3</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator_Three__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/OE_Calendar_Invite1</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_not_Submitted_15_day_alert</fullName>
        <description>OE Meeting not Submitted 15 day alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Alert_Email_for_Meetings_in_Draft</template>
    </alerts>
    <alerts>
        <fullName>OE_Meeting_not_submitted_Alert</fullName>
        <description>OE Meeting not submitted Alert</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Alert_Email_for_Meetings_in_Draft</template>
    </alerts>
    <alerts>
        <fullName>SAR_Sales_Survey_Reminder</fullName>
        <description>SAR Sales Survey Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>SAR_AcctMgt_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/SAR_Sales_Feedback_Survey_Email</template>
    </alerts>
    <alerts>
        <fullName>facilitator</fullName>
        <description>OE Facilitator reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator1__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Facilitator_Three__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Facilitator_Two__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Facilitator_Reminder_Email1</template>
    </alerts>
    <alerts>
        <fullName>facilitator1</fullName>
        <description>OE Facilitator reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Facilitator1__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Facilitator_Three__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <field>Facilitator_Two__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Open_Enrollment_Email_Templates/Local_Sales_Facilitator_Reminder_Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>Facilitator_1_Calendar_Invite_Stamp</fullName>
        <description>Updates Send Facilitator 1 Calendar Invite field to True</description>
        <field>Send_Facilitator_1_Calendar_Invite__c</field>
        <literalValue>1</literalValue>
        <name>Facilitator 1 Calendar Invite Stamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Facilitator_2Calendar_Invite_Stamp</fullName>
        <description>Updates Send Facilitator 2 Calendar Invite field to True</description>
        <field>Send_Facilitator_2_Calendar_Invite__c</field>
        <literalValue>1</literalValue>
        <name>Facilitator 2Calendar Invite Stamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Facilitator_3_Calendar_Invite_Stamp</fullName>
        <field>Send_Facilitator_3_Calendar_Invite__c</field>
        <literalValue>1</literalValue>
        <name>Facilitator 3 Calendar Invite Stamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Feedback_Not_Received_Within_14_Day</fullName>
        <description>Feedback Not Received Within 14 Days</description>
        <field>Feedback_Not_Received_Within_14_Days__c</field>
        <literalValue>1</literalValue>
        <name>Feedback Not Received Within 14 Day</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Feedback_string</fullName>
        <field>Feedback_String__c</field>
        <formula>Feedback_Formula__c</formula>
        <name>Feedback string</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OE_Account_text_field</fullName>
        <description>This field update sets the account name text field to the account name</description>
        <field>Account_Name_Text__c</field>
        <formula>OE_Grouping__r.Account__r.Name</formula>
        <name>OE Account text field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OE_Coordinator_Declined_Check</fullName>
        <description>Check the coordinator declined when the Consultant is declined</description>
        <field>Coordinator_Declined__c</field>
        <literalValue>1</literalValue>
        <name>OE Coordinator Declined Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OE_Coordinator_Declined_UnCheck</fullName>
        <description>Make sure the consultant declined is not checked when a Coordinator Action is added</description>
        <field>Coordinator_Declined__c</field>
        <literalValue>0</literalValue>
        <name>OE Coordinator Declined UnCheck</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OE_Meeting_Stage_to_SUBMITTED</fullName>
        <field>Meeting_Stage__c</field>
        <literalValue>SUBMITTED</literalValue>
        <name>OE Meeting Stage to SUBMITTED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OE_Reason_For_Update_to_blank</fullName>
        <description>Set the Reason for Update to blank when the meeting is submitted, there is no reason for update before it is submitted.</description>
        <field>Reason_for_Update__c</field>
        <name>OE Reason For Update to blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stamp_AE_Email</fullName>
        <field>Account_Executive_Email__c</field>
        <formula>OE_Grouping__r.Account__r.Account_Executive__r.Email</formula>
        <name>Stamp AE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stamp_AM_Email</fullName>
        <field>Account_Manager_Email__c</field>
        <formula>OE_Grouping__r.Account__r.Account_Manager__r.Email</formula>
        <name>Stamp AM Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stamp_Client_SAR_Email</fullName>
        <field>Client_Engagement_Consultant_SAR_Email__c</field>
        <formula>OE_Grouping__r.Account__r.Client_Engagement_Consultant_SAR1__r.Email</formula>
        <name>Stamp Client SAR Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stamp_SAR_Email</fullName>
        <field>SAR_AcctMgt_Email__c</field>
        <formula>OE_Grouping__r.Account__r.SARAcctMgmt__r.Email</formula>
        <name>Stamp SAR Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Waiting_on_Facilitator_Feedback</fullName>
        <field>Waiting_on_Feedback__c</field>
        <literalValue>1</literalValue>
        <name>Update Waiting on Facilitator Feedback</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AE Sales Survey Reminder</fullName>
        <actions>
            <name>Stamp_AE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email to Account Executive one day after the Meeting Date when AE Attending is Yes</description>
        <formula>AND(  NOT ISBLANK(Date__c),   ISPICKVAL(AE_Attending_Picklist__c, &apos;Yes&apos;),  NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;),   NOT ISPICKVAL(Meeting_Status__c, &quot;Cancelled&quot;),   NOT ISBLANK( AE_String__c ), NOT ISBLANK(Account_Exec_Formula__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AE_Sales_Survey_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Sales_Survey_Reminder_AE</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>AM Sales Survey Reminder</fullName>
        <actions>
            <name>Stamp_AM_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email to Account Manager one day after the Meeting Date when AM Attending is Yes</description>
        <formula>AND(  NOT ISBLANK(Date__c),  ISPICKVAL(AM_Attending_Picklist__c, &apos;Yes&apos;), NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;),  NOT ISPICKVAL(Meeting_Status__c, &quot;Cancelled&quot;),  NOT ISBLANK( AM_String__c ), NOT ISBLANK(Account_Manager_Formula__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>AM_Sales_Survey_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Sales_Survey_Reminder_AM</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Client Engagement SAR Sales Survey Reminder</fullName>
        <actions>
            <name>Stamp_Client_SAR_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email to Client Engagement Consultant SAR one day after the Meeting Date when Client Engagement Consult SAR Attending  is Yes</description>
        <formula>AND(  NOT (ISBLANK(Date__c)),   ISPICKVAL( Client_Engagement_Consult_SAR_Attending__c, &apos;Yes&apos;),NOT (ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;)), NOT (ISPICKVAL(Meeting_Status__c, &quot;Cancelled&quot;)), NOT (ISBLANK( Client_Engagement_Consultant_SAR_String__c )), NOT (ISBLANK(Client_Engagement_Consultant_SAR__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Client_SAR_Survey_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Sales_Survey_Reminder_Client_Engagement</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Facilitator 1 Calendar Invite</fullName>
        <actions>
            <name>OE_Meeting_Invite_Facilitator_1</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>iCalendar_Invite_Facilitator_1</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email to Facilitator 1 when Send Facilitator 1 Calendar Invite is not checked</description>
        <formula>IF(ISNEW(), 	(OR(NOT(ISBLANK(Facilitator1__c)), 		ISCHANGED(Facilitator1__c))),   ( 	OR( 		AND((Send_Facilitator_1_Calendar_Invite__c==false), 			NOT(ISBLANK(Facilitator1__c))), 	   ISCHANGED(Facilitator1__c) 	   ) 	)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Facilitator 1 Calendar Invite Stamp</fullName>
        <actions>
            <name>Facilitator_1_Calendar_Invite_Stamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Send Facilitator 1 Calendar Invite field to True</description>
        <formula>NOT (ISBLANK(  Facilitator1__c  ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Facilitator 2 Calendar Invite</fullName>
        <actions>
            <name>OE_Meeting_Invite_Facilitator_2</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>iCalendar_Invite_Facilitator_2</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email to Facilitator 2 when Send Facilitator 2 Calendar Invite is not checked</description>
        <formula>IF(ISNEW(), 	(OR(NOT(ISBLANK(Facilitator_Two__c)), 		ISCHANGED(Facilitator_Two__c))),   ( 	OR( 		AND((Send_Facilitator_2_Calendar_Invite__c ==false), 			NOT(ISBLANK(Facilitator_Two__c))), 	   ISCHANGED(Facilitator_Two__c) 	   ) 	)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Facilitator 2 Calendar Invite Stamp</fullName>
        <actions>
            <name>Facilitator_2Calendar_Invite_Stamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Send Facilitator 2 Calendar Invite field to True</description>
        <formula>NOT (ISBLANK(  Facilitator_Two__c  ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Facilitator 3 Calendar Invite</fullName>
        <actions>
            <name>OE_Meeting_Invite_Facilitator_3</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>iCalendar_Invite_Facilitator_3</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email to Facilitator 3 when Send Facilitator 3 Calendar Invite is not checked</description>
        <formula>IF(ISNEW(), 	(OR(NOT(ISBLANK(Facilitator_Three__c)), 		ISCHANGED(Facilitator_Three__c))),   ( 	OR( 		AND((Send_Facilitator_3_Calendar_Invite__c==false), 			NOT(ISBLANK(Facilitator_Three__c))), 	   ISCHANGED(Facilitator_Three__c) 	   ) 	)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Facilitator 3 Calendar Invite Stamp</fullName>
        <actions>
            <name>Facilitator_3_Calendar_Invite_Stamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Send Facilitator 3 Calendar Invite field to True</description>
        <formula>NOT (ISBLANK( Facilitator_Three__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Feedback Not Received Within 14 Days is set to True</fullName>
        <actions>
            <name>Feedback_Not_Received_Within_14_Day</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Feedback Not Received Within 14 Days field to True</description>
        <formula>and( Feedback_Not_Received_Within_14_Days__c = False,Facilitator_Secured__c = True,NOT ISPICKVAL(Meeting_Status__c,&apos;Completed-Cancelled&apos;),(Date__c = TODAY()-13), Facilitator_Feedback_Received__c =FAlSE, ISPICKVAL(Recruitment_of_Facilitator_Needed__c,&apos;Yes&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Feedback string Update</fullName>
        <actions>
            <name>Feedback_string</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(Facilitator1__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OE Consultant Action Decline</fullName>
        <actions>
            <name>OE_Contractor_Coordinator_Decline_email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>OE_Coordinator_Declined_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will send an email alert to the OE Consultant Coordinator when the OE Coordinator Action is decline</description>
        <formula>AND (TEXT(OE_Coordinator_Action__c )= &apos;Decline&apos;, NOT  ISBLANK( OE_Consultant__c ),  NOT Coordinator_Declined__c  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OE Consultant Action Rescinded</fullName>
        <actions>
            <name>OE_Contractor_Rescinded</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This workflow will send an email alert to the OE Coordinator when the OE manager wants them to secure a consultant for a meeting.</description>
        <formula>AND (TEXT(OE_Coordinator_Action__c )= &apos;Rescinded&apos;, NOT  ISBLANK( OE_Consultant__c ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OE Consultant Assign</fullName>
        <actions>
            <name>OE_Coordinator_consultant_action_is_selected</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>OE_Coordinator_Declined_UnCheck</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Coordinator_Action_email_sent</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>This workflow will send an email alert to the OE Coordinator when the OE manager wants them to secure a consultant for a meeting.</description>
        <formula>AND (TEXT(OE_Coordinator_Action__c )= &apos;Assign&apos;, NOT  ISBLANK( OE_Consultant__c ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OE Facilitator Meeting Reminder_Local Sales</fullName>
        <active>true</active>
        <description>This workflow will send a reminder to the Facilitator 1,2,3 that the meeting they are facilitating will be in 7 days for Anthem Entities Local/Large Group or Labor and Trust.</description>
        <formula>AND ( NOT Omit_Event_Reminder__c , NOT ISBLANK(Date__c), OR( NOT ISBLANK( Facilitator1__c), NOT ISBLANK (Facilitator_Two__c), NOT ISBLANK (Facilitator_Three__c)), NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;), NOT ISPICKVAL (Meeting_Status__c, &quot;Cancelled&quot;), NOT ISPICKVAL( Meeting_Stage__c , &quot;DRAFT&quot;), Date__c &gt; TODAY(),OR ( ISPICKVAL (OE_Grouping__r.Account__r.Anthem_Entity__c, &quot;Local/Large Group&quot;), ISPICKVAL (OE_Grouping__r.Account__r.Anthem_Entity__c, &quot;Labor and Trust&quot;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>facilitator1</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>OE_Meeting_Email_Alert_Sent_to_Facilitator2</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OE Facilitator Meeting Reminder_National Sales</fullName>
        <active>true</active>
        <description>This workflow will send a reminder to the Facilitator 1,2,3 that the meeting they are facilitating will be in 7 days for Anthem Entity National Accounts.</description>
        <formula>AND ( NOT Omit_Event_Reminder__c , NOT ISBLANK(Date__c), OR( NOT ISBLANK( Facilitator1__c), NOT ISBLANK (Facilitator_Two__c), NOT ISBLANK (Facilitator_Three__c)), NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;), NOT ISPICKVAL (Meeting_Status__c, &quot;Cancelled&quot;), NOT ISPICKVAL( Meeting_Stage__c , &quot;DRAFT&quot;), Date__c &gt; TODAY() ,ISPICKVAL (OE_Grouping__r.Account__r.Anthem_Entity__c,  &quot;National Accounts&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>facilitator</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>OE_Meeting_Email_Alert_Sent_to_Facilitator1</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OE Facilitator1 Feedback Reminder_Local Sales</fullName>
        <active>true</active>
        <description>This workflow will send a reminder to the Facilitator that the feedback for their meeting has not been submitted 7 days after the meeting if it hasn&apos;t for Anthem Entities Local/Large Group or Labor and Trust.</description>
        <formula>AND ( NOT Omit_Feedback_Reminder__c, NOT ISBLANK(Date__c), NOT ISBLANK(Facilitator1__c), NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;), NOT ISPICKVAL(Meeting_Status__c, &quot;Cancelled&quot;), NOT Facilitator_Feedback_Received__c , (Date__c &gt; DATE(2014,7,31)), NOT ISBLANK(Feedback_String__c), OR ( ISPICKVAL (OE_Grouping__r.Account__r.Anthem_Entity__c, &quot;Local/Large Group&quot;), ISPICKVAL (OE_Grouping__r.Account__r.Anthem_Entity__c, &quot;Labor and Trust&quot;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OE_Meeting_Feedback_Reminder2</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>OE_Facilitator1_Feedback_Reminder_sent2</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OE Facilitator1 Feedback Reminder_National Sales</fullName>
        <active>true</active>
        <description>This workflow will send a reminder to the Facilitator that the feedback for their meeting has not been submitted 7 days after the meeting if it hasn&apos;t for Anthem Entity National Accounts.</description>
        <formula>AND ( NOT Omit_Feedback_Reminder__c, NOT ISBLANK(Date__c), NOT ISBLANK(Facilitator1__c), NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;), NOT ISPICKVAL(Meeting_Status__c, &quot;Cancelled&quot;), NOT Facilitator_Feedback_Received__c , (Date__c &gt; DATE(2014,7,31)), NOT ISBLANK(Feedback_String__c), ISPICKVAL(OE_Grouping__r.Account__r.Anthem_Entity__c, &quot;National Accounts&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OE_Meeting_Feedback_Reminder1</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>OE_Facilitator1_Feedback_Reminder_sent</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>OE Meeting Stage Submitted</fullName>
        <actions>
            <name>OE_Account_text_field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OE_Meeting_Stage_to_SUBMITTED</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OE_Reason_For_Update_to_blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow sets the meeting stage to submitted when the submit is checked</description>
        <formula>Submit__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OE Meeting in Draft Status</fullName>
        <active>true</active>
        <criteriaItems>
            <field>SFDC_Volunteer_Event__c.Submit__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Volunteer_Event__c.Date__c</field>
            <operation>greaterOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Volunteer_Event__c.Meeting_Stage__c</field>
            <operation>equals</operation>
            <value>DRAFT</value>
        </criteriaItems>
        <criteriaItems>
            <field>SFDC_Volunteer_Event__c.Situs_State__c</field>
            <operation>notEqual</operation>
            <value>Georgia</value>
        </criteriaItems>
        <description>This workflow will kick off an email alert to the person who last modified the meeting 3 days and to both the AM and the person who last modified 15 days after the meeting has been modified if the if the meeting stage is still DRAFT</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>OE_Meeting_not_submitted_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.CreatedDate</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>OE_Meeting_not_Submitted_15_day_alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.CreatedDate</offsetFromField>
            <timeLength>15</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>SAR Sales Survey Reminder</fullName>
        <actions>
            <name>Stamp_SAR_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  NOT ISBLANK(Date__c),  ISPICKVAL(SAR_Attending__c, &apos;Yes&apos;), NOT ISPICKVAL(Meeting_Status__c, &quot;NEW REQUEST&quot;),  NOT ISPICKVAL(Meeting_Status__c, &quot;Cancelled&quot;),  NOT ISBLANK( SAR_String__c ), NOT ISBLANK(SAR_AcctMgt__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>SAR_Sales_Survey_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Sales_Survey_Reminder_SAR</name>
                <type>Task</type>
            </actions>
            <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Waiting on Facilitator Feedback Update</fullName>
        <actions>
            <name>Update_Waiting_on_Facilitator_Feedback</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Waiting on Facilitator Feedback checkbox</description>
        <formula>and(Submit__c = True,Facilitator_Secured__c = True, Facilitator_Feedback_Received__c = False, Facilitator_Being_Recruited__c = False, ISPICKVAL(Recruitment_of_Facilitator_Needed__c,&apos;Yes&apos;), NOT(ISBLANK(Facilitator1__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Coordinator_Action_email_sent</fullName>
        <assignedTo>mehaboobpasha.kallur@legatohealth.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Coordinator Action email sent to OE Coordinator.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>SFDC_Volunteer_Event__c.Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Coordinator Action email sent</subject>
    </tasks>
    <tasks>
        <fullName>OE_Facilitator1_Feedback_Reminder_sent</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Facilitator Feedback Survey Reminder</subject>
    </tasks>
    <tasks>
        <fullName>OE_Facilitator1_Feedback_Reminder_sent2</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Facilitator Feedback Survey Reminder</subject>
    </tasks>
    <tasks>
        <fullName>OE_Meeting_Email_Alert_Sent_to_Facilitator1</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Facilitator Meeting Reminder</subject>
    </tasks>
    <tasks>
        <fullName>OE_Meeting_Email_Alert_Sent_to_Facilitator2</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Facilitator Meeting Reminder</subject>
    </tasks>
    <tasks>
        <fullName>Sales_Survey_Reminder_AE</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Sales Survey Reminder - AE</subject>
    </tasks>
    <tasks>
        <fullName>Sales_Survey_Reminder_AM</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Sales Survey Reminder - AM</subject>
    </tasks>
    <tasks>
        <fullName>Sales_Survey_Reminder_Client_Engagement</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Sales Survey Reminder – Client Engagement</subject>
    </tasks>
    <tasks>
        <fullName>Sales_Survey_Reminder_SAR</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Sales Survey Reminder - SAR</subject>
    </tasks>
    <tasks>
        <fullName>iCalendar_Invite_Facilitator_1</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>iCalendar Invite – Facilitator 1</subject>
    </tasks>
    <tasks>
        <fullName>iCalendar_Invite_Facilitator_2</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>iCalendar Invite – Facilitator 2</subject>
    </tasks>
    <tasks>
        <fullName>iCalendar_Invite_Facilitator_3</fullName>
        <assignedTo>api.user@anthem.com2</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>iCalendar Invite – Facilitator 3</subject>
    </tasks>
</Workflow>
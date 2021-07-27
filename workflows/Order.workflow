<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Reminder_HCRA_1</fullName>
        <description>Alert Reminder HCRA #1</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Assigned_Implementer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Alert_Reminder_HCRA_1_HTML</template>
    </alerts>
    <alerts>
        <fullName>Automated_Email_to_Provider_Services_for_New_Groups</fullName>
        <description>Automated Email to Provider Services for New Groups</description>
        <protected>false</protected>
        <recipients>
            <recipient>danielle.abert@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Assigned_Implementer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Automated_Email_to_Provider_Services_for_New_Groups</template>
    </alerts>
    <alerts>
        <fullName>Automated_Email_to_Provider_Services_for_New_Groups_1</fullName>
        <description>Automated Email to Provider Services for New Groups 1</description>
        <protected>false</protected>
        <recipients>
            <recipient>colopms@wellpoint.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>harritm@wellpoint.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Assigned_Implementer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Automated_Email_to_Provider_Services_for_New_Groups</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_For_Sales_On_IMPL_Withdraw</fullName>
        <description>Email Notification For Sales On IMPL Withdraw</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Sales_On_IMPL_Withdraw_HTML</template>
    </alerts>
    <alerts>
        <fullName>Enhancement_Automated_Reminder_for_Virtual_Second_Opinion</fullName>
        <description>Enhancement Automated Reminder for Virtual Second Opinion</description>
        <protected>false</protected>
        <recipients>
            <recipient>aa72833@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jean.phillips@anthem.com2sme</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Assigned_Implementer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Enhancement_Automated_Reminder_for_Virtual_Second_Opinion</template>
    </alerts>
    <alerts>
        <fullName>New_Subrogation_Email_Notification</fullName>
        <ccEmails>dl-subroimplementations@meridianresource.com</ccEmails>
        <description>New Subrogation Email Notification for New Business/Group Terms/Group Number Changes/Claim System Changes</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Subrogation_Email_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved_Implementation_in_Progress</fullName>
        <field>Approved_Implementation_in_Progress__c</field>
        <formula>IF(ISBLANK(PRIORVALUE(Approved_Implementation_in_Progress__c)),0,PRIORVALUE(Approved_Implementation_in_Progress__c))+( 

CASE(MOD( DATEVALUE(Approved_Implementation_in_Progress_St__c) - DATE(1985,6,24),7), 

0 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Approved_Implementation_in_Progress_St__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Approved_Implementation_in_Progress_St__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Approved_Implementation_in_Progress_St__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Approved_Implementation_in_Progress_St__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Approved_Implementation_in_Progress_St__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Approved_Implementation_in_Progress_St__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Approved_Implementation_in_Progress_St__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(Approved_Implementation_in_Progress_St__c))/7)*5) 

)</formula>
        <name>Approved – Implementation in Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved_Implementation_in_Progress_St</fullName>
        <field>Approved_Implementation_in_Progress_St__c</field>
        <formula>NOW()</formula>
        <name>Approved – Implementation in Progress St</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Progress</fullName>
        <field>In_Progress__c</field>
        <formula>IF(ISBLANK(PRIORVALUE(In_Progress__c)),0,PRIORVALUE(In_Progress__c))+( 



CASE(MOD( DATEVALUE(In_Progress_Status__c) - DATE(1985,6,24),7), 

0 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(In_Progress_Status__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(In_Progress_Status__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(In_Progress_Status__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(In_Progress_Status__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(In_Progress_Status__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(In_Progress_Status__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(In_Progress_Status__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(In_Progress_Status__c))/7)*5) 

)</formula>
        <name>In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>In_Progress_Status</fullName>
        <field>In_Progress_Status__c</field>
        <formula>NOW()</formula>
        <name>In Progress Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LG_CarveOutProcessRecord_Update</fullName>
        <field>Carve_Out_Process_Records__c</field>
        <literalValue>0</literalValue>
        <name>LG_CarveOutProcessRecord_Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_SME_Review</fullName>
        <field>Pending_SME_Review__c</field>
        <formula>IF(ISBLANK(PRIORVALUE(Pending_SME_Review__c)),0,PRIORVALUE(Pending_SME_Review__c))+( 

CASE(MOD( DATEVALUE(Pending_SME_Review_St__c) - DATE(1985,6,24),7), 

0 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Pending_SME_Review_St__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_SME_Review_St__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Pending_SME_Review_St__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_SME_Review_St__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_SME_Review_St__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_SME_Review_St__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_SME_Review_St__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(Pending_SME_Review_St__c))/7)*5) 

)</formula>
        <name>Pending SME Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_SME_Review_St</fullName>
        <field>Pending_SME_Review_St__c</field>
        <formula>NOW()</formula>
        <name>Pending SME Review St</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Sales_Account_Management</fullName>
        <field>Pending_Sales_Account_Management__c</field>
        <formula>IF( ISBLANK(Pending_Sales_Account_Management__c), 
(CASE(MOD( DATEVALUE(Pending_Sales_Account_Management_Status__c) - DATE(1985,6,24),7), 

0, CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Pending_Sales_Account_Management_Status__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(Pending_Sales_Account_Management_Status__c))/7)*5) 

), 
(CASE(MOD( DATEVALUE(Pending_Sales_Account_Management_Status__c) - DATE(1985,6,24),7), 

0, CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Pending_Sales_Account_Management_Status__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Pending_Sales_Account_Management_Status__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(Pending_Sales_Account_Management_Status__c))/7)*5)+ Pending_Sales_Account_Management__c 

) 
)</formula>
        <name>Pending Sales/ Account Management</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending_Sales_Account_Management_St</fullName>
        <field>Pending_Sales_Account_Management_Status__c</field>
        <formula>NOW()</formula>
        <name>Pending Sales/ Account Management St</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_Implementation</fullName>
        <field>Ready_For_Implementations__c</field>
        <formula>IF( 
ISBLANK(Pending_Sales_Account_Management__c) , 
(CASE(MOD( DATEVALUE(Ready_for_Implementations_Status__c) - DATE(1985,6,24),7), 

0 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Ready_for_Implementations_Status__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Ready_for_Implementations_Status__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(Ready_for_Implementations_Status__c))/7)*5) 
), 
( (CASE(MOD( DATEVALUE(Ready_for_Implementations_Status__c) - DATE(1985,6,24),7), 

0 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Ready_for_Implementations_Status__c) ,7),1,2,2,3,3,4,4,5,5,5,6,5,1), 
1 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,2,2,3,3,4,4,4,5,4,6,5,1), 
2 , CASE( MOD( DATEVALUE(NOW()) - DATEVALUE(Ready_for_Implementations_Status__c),7),1,2,2,3,3,3,4,3,5,4,6,5,1), 
3 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,2,2,2,3,2,4,3,5,4,6,5,1), 
4 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,1,2,1,3,2,4,3,5,4,6,5,1), 
5 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c),7),1,0,2,1,3,2,4,3,5,4,6,5,0), 
6 , CASE( MOD( DATEVALUE(NOW())- DATEVALUE(Ready_for_Implementations_Status__c) ,7),1,1,2,2,3,3,4,4,5,5,6,5,0), 
999) 
+ 
(FLOOR(( DATEVALUE(NOW()) - DATEVALUE(Ready_for_Implementations_Status__c))/7)*5) 
)) - Pending_Sales_Account_Management__c 

)</formula>
        <name>Ready for Implementation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_Implementations_p</fullName>
        <field>Ready_for_Implementations_Status__c</field>
        <formula>NOW()</formula>
        <name>Ready for Implementations p</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SME_Status_Checkbox_update</fullName>
        <field>Is_Order_Status_Pending_SME_Review__c</field>
        <literalValue>1</literalValue>
        <name>SME Status Checkbox update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_Ready_for_Imps_Date</fullName>
        <field>Start_Ready_for_Imps__c</field>
        <formula>NOW()</formula>
        <name>Start Ready for Imps Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdEnd_Pend_Res_S_A</fullName>
        <field>End_Pend_Res_S_A__c</field>
        <formula>NOW()</formula>
        <name>UpdEnd Pend Res S/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_DurPendRes_S_A</fullName>
        <field>Dur_PendRes_S_A__c</field>
        <formula>IF( ISBLANK ( PRIORVALUE(Dur_PendRes_S_A__c)),0.00,PRIORVALUE(Dur_PendRes_S_A__c))+ (NOW() - Strt_Pend_Res_S_A__c)</formula>
        <name>Upd DurPendRes S/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_DurRevPend_S_A</fullName>
        <field>Dur_RevPend_S_A__c</field>
        <formula>IF( ISBLANK ( PRIORVALUE(Dur_RevPend_S_A__c)),0.00,PRIORVALUE(Dur_RevPend_S_A__c))+ (NOW() - Strt_Rev_Pend_S_A__c)</formula>
        <name>Upd DurRevPend S/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_Dur_pend_SME</fullName>
        <field>Dur_pend_SME__c</field>
        <formula>IF( ISBLANK ( PRIORVALUE(Dur_pend_SME__c)),0.00,PRIORVALUE(Dur_pend_SME__c))+ (NOW() - Strt_Pend_SME__c)</formula>
        <name>Upd Dur pend SME</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_End_Rev_Pend_S_A</fullName>
        <field>End_Rev_Pend_S_A__c</field>
        <formula>NOW()</formula>
        <name>Upd End Rev Pend S/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_Strt_Pend_Res_S_A</fullName>
        <field>Strt_Pend_Res_S_A__c</field>
        <formula>NOW()</formula>
        <name>Upd Strt Pend Res S/A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_end_pend_review_time</fullName>
        <field>End_Pend_SME__c</field>
        <formula>NOW()</formula>
        <name>Upd end pend review time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_strt_Pend_SME_review</fullName>
        <field>Strt_Pend_SME__c</field>
        <formula>NOW()</formula>
        <name>Upd strt Pend SME review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_time</fullName>
        <field>Strt_Rev_Pend_S_A__c</field>
        <formula>NOW()</formula>
        <name>Upd time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_End_Ready_for_Imps_Date</fullName>
        <field>End_Ready_for_Implementation__c</field>
        <formula>NOW()</formula>
        <name>Update End Ready for Imps Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_End_Ready_for_Revision_Pend_Rev</fullName>
        <field>End_Revision_Pending_Implementations_Rev__c</field>
        <formula>NOW()</formula>
        <name>Update End Ready for Revision Pend Rev</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Start_Ready_for_Imps_Date</fullName>
        <field>Start_Ready_for_Imps__c</field>
        <formula>Now()</formula>
        <name>Update Start Ready for Imps Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Start_Revision_Pending_Implementa</fullName>
        <field>Start_Revision_Pending_Implementations_R__c</field>
        <formula>NOW()</formula>
        <name>Update Start Revision Pending Implementa</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_status_Ready_for_Imps</fullName>
        <field>Status_Ready_for_Imps__c</field>
        <literalValue>1</literalValue>
        <name>Update status Ready for Imps</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_the_Duration</fullName>
        <field>Duration_of_Ready_for_Imps__c</field>
        <formula>IF( ISBLANK ( PRIORVALUE( Duration_of_Ready_for_Imps__c )),0.00,PRIORVALUE(Duration_of_Ready_for_Imps__c))+ (NOW() - Start_Ready_for_Imps__c )</formula>
        <name>Update the Duration</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_the_Status_priovalue</fullName>
        <field>Set_Status_PriorValue__c</field>
        <formula>TEXT(PRIORVALUE(Implementation_Status__c))</formula>
        <name>Update the Status priovalue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_the_duration_field_for_Revision</fullName>
        <field>Duration_Revision_Pending_Implementation__c</field>
        <formula>IF( ISBLANK ( PRIORVALUE( Duration_Revision_Pending_Implementation__c )),0.00,PRIORVALUE(Duration_Revision_Pending_Implementation__c))+ (NOW() - Start_Revision_Pending_Implementations_R__c )</formula>
        <name>Update the duration field for Revision</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Alert Reminder HCRA %231</fullName>
        <actions>
            <name>Alert_Reminder_HCRA_1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>PRDCRM-27574</description>
        <formula>AND( 	Anthem_Entity__c = &apos;National Accounts&apos;,  ISPICKVAL(Account.Does_NY_HCRA_Apply__c,&quot;Yes&quot;),  ISCHANGED(Implementation_Status__c), 	ISPICKVAL(Implementation_Status__c ,&quot;Approved&quot;), 	ISPICKVAL(Implementation_Type__c ,&quot;New Business&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Approved Implementation in Progress</fullName>
        <actions>
            <name>Approved_Implementation_in_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Implementation_Status__c),ISPICKVAL(PRIORVALUE(Implementation_Status__c),&apos;Approved&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Approved Implementation in Progress St</fullName>
        <actions>
            <name>Approved_Implementation_in_Progress_St</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Automated Email to Provider Services for New Groups</fullName>
        <actions>
            <name>Automated_Email_to_Provider_Services_for_New_Groups</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND ( 	Anthem_Entity__c = &apos;National Accounts&apos;, 	 	OR(  		AND( ISCHANGED(Implementation_Type__c), ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISCHANGED(Implementation_Status__c), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;NASCO&apos; ),  		 		AND( ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;NASCO&apos; ),  		 		AND( ISCHANGED(Implementation_Type__c), ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;NASCO&apos; ),  		 		AND( ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISCHANGED(Implementation_Status__c), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;NASCO&apos; )  	) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Automated Email to Provider Services for New Groups 1</fullName>
        <actions>
            <name>Automated_Email_to_Provider_Services_for_New_Groups_1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND ( 	Anthem_Entity__c = &apos;National Accounts&apos;, 	 	OR(  		AND( ISCHANGED(Implementation_Type__c), ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISCHANGED(Implementation_Status__c), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;WGS 2.0&apos; ),  		 		AND( ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;WGS 2.0&apos; ),  		 		AND( ISCHANGED(Implementation_Type__c), ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;WGS 2.0&apos; ),  		 		AND( ISPICKVAL(Implementation_Type__c, &apos;New Business&apos;), ISCHANGED(Implementation_Status__c), ISPICKVAL(Implementation_Status__c, &apos;Approved&apos;), Claim_system__c = &apos;WGS 2.0&apos; )  	) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>In Progress</fullName>
        <actions>
            <name>In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Implementation_Status__c),ISPICKVAL(PRIORVALUE(Implementation_Status__c),&apos;Initiated&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>In Progress Status</fullName>
        <actions>
            <name>In_Progress_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Initiated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LG_CarveOutProcessRecord_Update</fullName>
        <actions>
            <name>LG_CarveOutProcessRecord_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 	NOT(ISNEW()), 	Carve_Out_Process_Records__c == true, 	OR(Anthem_Entity__c == &apos;Local/Large Group&apos;,Anthem_Entity__c == &apos;Labor and Trust&apos;), 	ISCHANGED(Implementation_Status__c), 	OR(ISPICKVAL(Implementation_Status__c, &apos;Ready for Imps&apos;),ISPICKVAL(Implementation_Status__c, &apos;Pending SME Review&apos;)),  $Profile.Name &lt;&gt; &apos;API User&apos;	 )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NewSubrogationEmail</fullName>
        <actions>
            <name>New_Subrogation_Email_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8)</booleanFilter>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Pending SME Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Implementation_Type__c</field>
            <operation>equals</operation>
            <value>New Business</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Intake_Type_Spin_Off__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Intake_Type_Acquisition__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Intake_Type_Existing_Shift_to_JAA__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Intake_Type_Migration__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Intake_Type_Transfer_Market_Segment__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Intake_Type_Group_Term__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Sales On IMPL Withdraw</fullName>
        <actions>
            <name>Email_Notification_For_Sales_On_IMPL_Withdraw</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(Anthem_Entity__c = &apos;Local/Large Group&apos;, ISCHANGED(Implementation_Status__c) ,ISPICKVAL( Implementation_Status__c , &quot;Withdrawn&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Pending SME Review</fullName>
        <actions>
            <name>Pending_SME_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Implementation_Status__c),ISPICKVAL(PRIORVALUE(Implementation_Status__c),&apos;Pending SME Review&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Pending SME Review St</fullName>
        <actions>
            <name>Pending_SME_Review_St</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Pending SME Review</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pending Sales Account Management</fullName>
        <actions>
            <name>Pending_Sales_Account_Management</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Implementation_Status__c),ISPICKVAL(PRIORVALUE(Implementation_Status__c),&apos;Pending Response from AE&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Pending Sales Account Management St</fullName>
        <actions>
            <name>Pending_Sales_Account_Management_St</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Pending Response from AE</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ready For Implementations St</fullName>
        <actions>
            <name>Ready_for_Implementations_p</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Ready for Imps</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Ready_for_Implementations_Status__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ready for Implementation</fullName>
        <actions>
            <name>Ready_for_Implementation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Implementation_Status__c), ISPICKVAL(Implementation_Status__c,&apos;Pending SME Review&apos;),  OR(ISPICKVAL(PRIORVALUE(Implementation_Status__c),&apos;Ready for Imps&apos;), ISPICKVAL(PRIORVALUE(Implementation_Status__c),&apos;Pending Response from AE&apos;)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SME Status Checkbox update</fullName>
        <actions>
            <name>SME_Status_Checkbox_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Pending SME Review</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd Dur pend SME</fullName>
        <actions>
            <name>Upd_Dur_pend_SME</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),(TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Pending SME Review&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd DurPend Res S%2FA</fullName>
        <actions>
            <name>Upd_DurPendRes_S_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),(TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Pending Response from AE&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd DurRevPend S%2FA</fullName>
        <actions>
            <name>Upd_DurRevPend_S_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),(TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Revision Pending Response from Sales/Account Management&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd End Pend Res S%2FA</fullName>
        <actions>
            <name>UpdEnd_Pend_Res_S_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),AND ((TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Pending Response from AE&quot;),NOT(TEXT(Implementation_Status__c) = &quot;Revision Pending Response from Sales/Account Management&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd End Rev Pend S%2FA</fullName>
        <actions>
            <name>Upd_End_Rev_Pend_S_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),AND ((TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Revision Pending Response from Sales/Account Management&quot;),NOT(TEXT(Implementation_Status__c) = &quot;Pending Response from AE&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd Strt Pend Res S%2FA</fullName>
        <actions>
            <name>Upd_Strt_Pend_Res_S_A</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),TEXT(Implementation_Status__c) = &quot;Pending Response from AE&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd Strt Rev Pend S%2FA</fullName>
        <actions>
            <name>Upd_time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),TEXT(Implementation_Status__c) = &quot;Revision Pending Response from Sales/Account Management&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upd end pend review time</fullName>
        <actions>
            <name>Upd_end_pend_review_time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Pending SME Review&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Duration of Ready for Imps</fullName>
        <actions>
            <name>Update_the_Duration</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),(TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Ready for Imps&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update End Ready for Imps Date</fullName>
        <actions>
            <name>Update_End_Ready_for_Imps_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),AND ((TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Ready for Imps&quot;),NOT(TEXT(Implementation_Status__c) = &quot;Revision Pending Implementations Review&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update End Revision Pending Imps Review</fullName>
        <actions>
            <name>Update_End_Ready_for_Revision_Pend_Rev</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),AND ((TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Revision Pending Implementations Review&quot;),NOT(TEXT(Implementation_Status__c) = &quot;Ready for Imps&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Start Ready for Imps Date</fullName>
        <actions>
            <name>Start_Ready_for_Imps_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),TEXT(Implementation_Status__c) = &quot;Ready for Imps&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Start Revision Pending Imps Review Date</fullName>
        <actions>
            <name>Update_Start_Revision_Pending_Implementa</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),TEXT(Implementation_Status__c) = &quot;Revision Pending Implementations Review&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Strt Pend SME</fullName>
        <actions>
            <name>Upd_strt_Pend_SME_review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),TEXT(Implementation_Status__c) = &quot;Pending SME Review&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update status Ready for Imps</fullName>
        <actions>
            <name>Update_status_Ready_for_Imps</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order.Status_Ready_for_Imps__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Order.Implementation_Status__c</field>
            <operation>equals</operation>
            <value>Ready for Imps</value>
        </criteriaItems>
        <description>PRDCRM_26570</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update the Duration for Revision Pend for Rev</fullName>
        <actions>
            <name>Update_the_duration_field_for_Revision</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (ISCHANGED (Implementation_Status__c),(TEXT(PRIORVALUE(Implementation_Status__c)) = &quot;Revision Pending Implementations Review&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update the Imp Status value</fullName>
        <actions>
            <name>Update_the_Status_priovalue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED (Implementation_Status__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
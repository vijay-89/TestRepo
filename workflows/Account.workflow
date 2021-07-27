<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_Legal_Name_Change</fullName>
        <description>Account Legal Name Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>dl-sfdc-coe-admins@anthem.com.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Acc_AccountLegalNameChange</template>
    </alerts>
    <alerts>
        <fullName>Automated_Email_Anthem_Health_Guide_Sold</fullName>
        <ccEmails>edbsupport@anthem.com</ccEmails>
        <description>Automated Email Anthem Health Guide Sold</description>
        <protected>false</protected>
        <recipients>
            <recipient>Implementer</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Automated_Email_AHG_Sold</template>
    </alerts>
    <alerts>
        <fullName>Automated_Email_Anthem_Health_Guide_Sold_1</fullName>
        <ccEmails>edbsupport@anthem.com</ccEmails>
        <description>Automated Email Anthem Health Guide Sold 1</description>
        <protected>false</protected>
        <recipients>
            <recipient>Implementer</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Automated_Email_AHG_Sold_1</template>
    </alerts>
    <alerts>
        <fullName>GS_Alert_for_MBU_Code_Change</fullName>
        <description>GS Alert for MBU Code Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>Implementer</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Acc_MBUCodeChange</template>
    </alerts>
    <fieldUpdates>
        <fullName>ACC01_UpdateCancelDate</fullName>
        <description>Update Cancel Date when Account Status is closed</description>
        <field>Cancel_Date__c</field>
        <formula>TODAY()</formula>
        <name>ACC01_Update Cancel Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ACC02_CheckPastCustomer</fullName>
        <description>Check Past Customer When Account Status is closed.</description>
        <field>Past_Customer__c</field>
        <literalValue>1</literalValue>
        <name>ACC02_Check Past Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ANA_Account_Key_Prospect_Fields</fullName>
        <field>Last_Prospect_Update__c</field>
        <formula>TODAY()</formula>
        <name>ANA - Account - Key Prospect Fields</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Payment_City</fullName>
        <field>Check_Payment_City__c</field>
        <formula>Billing_City__c</formula>
        <name>Check Payment City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Payment_Country</fullName>
        <field>Check_Payment_Country__c</field>
        <formula>Billing_Country__c</formula>
        <name>Check Payment Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Payment_State</fullName>
        <field>Check_Payment_State_Province__c</field>
        <formula>Billing_State_Province__c</formula>
        <name>Check Payment State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Payment_Street</fullName>
        <field>Check_Payment_Street__c</field>
        <formula>Billing_Street__c</formula>
        <name>Check Payment Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_Payment_Zip</fullName>
        <field>Check_Payment_Zip_Postal_Code__c</field>
        <formula>Billing_Zip_Postal_Code__c</formula>
        <name>Check Payment Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_past_customer_flag</fullName>
        <field>Past_Customer__c</field>
        <literalValue>1</literalValue>
        <name>Check past customer flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Convert_to_LG_Prospect</fullName>
        <description>Convert LG Customer to LG prospect record</description>
        <field>RecordTypeId</field>
        <lookupValue>LG_Prospect</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Convert to LG Prospect</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mailing_County</fullName>
        <description>To update the Mailing County from Physical County</description>
        <field>Mailing_County__c</field>
        <formula>Physical_County__c</formula>
        <name>Mailing County</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShippingCountry</fullName>
        <description>Update ShippingCountry</description>
        <field>ShippingCountry</field>
        <formula>BillingCountry</formula>
        <name>ShippingCountry</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShippingStateProvince</fullName>
        <description>Update ShippingStateProvince</description>
        <field>ShippingState</field>
        <formula>BillingState</formula>
        <name>ShippingStateProvince</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShippingStreet</fullName>
        <description>Update ShippingStreet</description>
        <field>ShippingStreet</field>
        <formula>BillingStreet</formula>
        <name>ShippingStreet</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShippingZip</fullName>
        <description>Update ShippingZip</description>
        <field>ShippingPostalCode</field>
        <formula>BillingPostalCode</formula>
        <name>ShippingZip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Shipping_City</fullName>
        <description>Update Shipping City</description>
        <field>ShippingCity</field>
        <formula>BillingCity</formula>
        <name>Shipping City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateMailing_Country</fullName>
        <field>ShippingCountry</field>
        <formula>&apos;United States&apos;</formula>
        <name>UpdateMailing Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billing_Country</fullName>
        <field>BillingCountry</field>
        <formula>&apos;United States&apos;</formula>
        <name>UpdateBilling Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ACC - Update Key Prospect Date</fullName>
        <actions>
            <name>ANA_Account_Key_Prospect_Fields</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Fortune_500_Ranking__c ) &amp;&amp;  ISPICKVAL(Anthem_Entity__c ,&quot;National Accounts&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_WF_ACC01_MBUCodeAlert</fullName>
        <actions>
            <name>GS_Alert_for_MBU_Code_Change</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Alerts GS of a MBU Code Change - updated 2019 to only fire once using ischanged.</description>
        <formula>AND( ISPICKVAL(Anthem_Entity__c,&quot;National Accounts&quot;), ISPICKVAL(WGS_Contracting_Situs_State__c,&quot;NY New York&quot;), NOT(ISPICKVAL(MBU_Codes__c,&quot;Discuss on Discovery Call&quot;)), ISCHANGED(MBU_Codes__c), OR( NOT($Profile.Name=&quot;API User&quot;), NOT($Profile.Name=&quot;System Administrator&quot;) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Automated Email Anthem Health Guide Sold</fullName>
        <actions>
            <name>Automated_Email_Anthem_Health_Guide_Sold</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( ATMember_Date_AHG__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Automated Email Anthem Health Guide Sold 1</fullName>
        <actions>
            <name>Automated_Email_Anthem_Health_Guide_Sold_1</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( ATMember_Date_MHA__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Stop Loss Address Check</fullName>
        <actions>
            <name>Check_Payment_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Check_Payment_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Check_Payment_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Check_Payment_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Check_Payment_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Same_as_Billing_Address__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Term Existing Renewal Oppty</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>LG Customer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Cancel_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>WHEN the user manually update the Account’s Last Cancel Date field and Update the Customer Account Status = Closed 
THEN one day after the Account&apos;s last cancel date, system will automatically switch from LG Customer to LG Prospect.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Check_past_customer_flag</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Convert_to_LG_Prospect</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Account.Cancel_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>UpdateMailingAddress</fullName>
        <actions>
            <name>Mailing_County</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShippingCountry</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShippingStateProvince</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShippingStreet</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShippingZip</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Shipping_City</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>Account.RecordtypeName__c</field>
            <operation>equals</operation>
            <value>LG Prospect</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Mailing_Address_Same_as_Physical_Address__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordtypeName__c</field>
            <operation>equals</operation>
            <value>LG Customer</value>
        </criteriaItems>
        <description>To update mailing address when checkbox is selected</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_ Acc01_Populate %27Cancel Date%27 %26 check %27Past Customer%27 on Prospect account when a customer terms</fullName>
        <actions>
            <name>ACC01_UpdateCancelDate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ACC02_CheckPastCustomer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Prospect</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Populate &apos;Cancel Date&apos; &amp; check &apos;Past Customer&apos; on Prospect account when a customer Account Status is closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ANA_FullOptOut</fullName>
        <description>ANA FullOptOut</description>
        <protected>false</protected>
        <recipients>
            <recipient>ab04262@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ab24082@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ad70229@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cheryl.gibson@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ANA_PI_Full_Opt_Out</template>
    </alerts>
    <alerts>
        <fullName>ANA_SubroCarveOut</fullName>
        <ccEmails>kaye.newsome@anthem.com</ccEmails>
        <description>ANA SubroCarveOut</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ANA_Subrogation_Carve_Out</template>
    </alerts>
    <alerts>
        <fullName>Alert_Product_Stage_Sold_IGAP_Sold</fullName>
        <description>Alert Product Stage: Sold/IGAP Sold</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Implementer_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>claude.douglas@anthem.com.iceprod</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Alert_Product_Stage_Sold_IGAP_Sold</template>
    </alerts>
    <alerts>
        <fullName>Anthem_Health_Rewards_Alert</fullName>
        <description>Anthem Health Rewards Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Implementer</recipient>
            <type>accountTeam</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Anthem_Health_Rewards_Alert</template>
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
        <template>unfiled$public/Automated_Email_Anthem_Health_Guide_Sold</template>
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
        <template>unfiled$public/Automated_Email_Anthem_Health_Guide_Sold_1</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_Voluntary_Site_Of_Care</fullName>
        <ccEmails>margaret.workman@Ingenio-RX.com</ccEmails>
        <ccEmails>Dee.Delapp@Ingenio-Rx.com</ccEmails>
        <ccEmails>SpecialtyPharmacyClinicalStrategies@Ingenio-RX.com</ccEmails>
        <description>Email Alert Voluntary Site Of Care</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Voluntary_Site_Template</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_for_Terming_of_RDRC</fullName>
        <ccEmails>k.jithendra.sankar@accenture.com</ccEmails>
        <ccEmails>ikechukwu.ahams@anthem.com</ccEmails>
        <ccEmails>ikechukwu.c.ahams@accenture.com</ccEmails>
        <description>Email Notification for Terming of RDRC (Right Drug Right Channel)</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_Notification_for_Terming_of_RDRC</template>
    </alerts>
    <alerts>
        <fullName>Enhancement_Automated_Reminder_for_Virtual_Second_Opinion_1</fullName>
        <description>Enhancement Automated Reminder for Virtual Second Opinion 1</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <recipient>aa72833@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jean.phillips@anthem.com2sme</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Enhancement_Automated_Reminder_for_Virtual_Second_Opinion_1</template>
    </alerts>
    <alerts>
        <fullName>LG_EmailAlert_Commercial_Products</fullName>
        <ccEmails>himkumar@deloitte.com</ccEmails>
        <description>LG_EmailAlert_Commercial_Products</description>
        <protected>false</protected>
        <recipients>
            <recipient>ashok.gera2@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LG_QLI_Commercial_Product_Sold_Template</template>
    </alerts>
    <alerts>
        <fullName>QLI01_C3_Product_Sold_Alert</fullName>
        <ccEmails>cheryl.gibson@anthem.com</ccEmails>
        <description>QLI01_C3 Product Sold Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>ac96880@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QLI_C3_Product_Sold_Template</template>
    </alerts>
    <alerts>
        <fullName>QLI01_EngageProductSoldAlert</fullName>
        <ccEmails>cheryl.gibson@anthem.com</ccEmails>
        <ccEmails>Engage.Sold@anthem.com</ccEmails>
        <description>QLI01_Engage Product Sold Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QLI_EngageProductSoldTemplate</template>
    </alerts>
    <alerts>
        <fullName>QLI01_Other_AHG_Product_Alert</fullName>
        <ccEmails>ahgmhaclientintake@anthem.com</ccEmails>
        <ccEmails>cheryl.gibson@anthem.com</ccEmails>
        <description>QLI01_Other AHG Product Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QLI_AHG_Product_Stage_Template</template>
    </alerts>
    <alerts>
        <fullName>QLI01_Unduo_Product_Sold_Alert</fullName>
        <ccEmails>cheryl.gibson@anthem.com</ccEmails>
        <description>QLI01_Unduo Product Sold Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>mindi.matthews@anthem.com2</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QLI_Onduo_Product_Sold_Template</template>
    </alerts>
    <alerts>
        <fullName>QLI_Send_Email_to_Omada_for_Product_Config</fullName>
        <ccEmails>bridget.howard@anthem.com</ccEmails>
        <ccEmails>mindi.matthews@anthem.com</ccEmails>
        <ccEmails>jennifer.sanborn@anthem.com</ccEmails>
        <description>QLI-Send Email to Omada for Product Config</description>
        <protected>false</protected>
        <recipients>
            <field>Omada_Email_for_Product_Config_complete__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QLI_Omada_template_Product_Configuration</template>
    </alerts>
    <alerts>
        <fullName>QLI_Send_Email_to_Solera_for_Product_Config</fullName>
        <ccEmails>bridget.howard@anthem.com</ccEmails>
        <ccEmails>mindi.matthews@anthem.com</ccEmails>
        <ccEmails>jennifer.sanborn@anthem.com</ccEmails>
        <description>QLI-Send Email to Solera for Product Config</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager_Email_Store__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Solera_Email_for_Product_Confi_complete__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/QLI_Solera_Template</template>
    </alerts>
    <alerts>
        <fullName>RDRC_Configuration_Complete</fullName>
        <ccEmails>Dee.Delapp@anthem.com</ccEmails>
        <ccEmails>Margaret.Workman@anthem.com</ccEmails>
        <ccEmails>SpecialtyPharmacyClinicalStrategies@anthem.com</ccEmails>
        <description>RDRC Configuration Complete</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/RDRC_Form</template>
    </alerts>
    <alerts>
        <fullName>RDRC_Form</fullName>
        <ccEmails>Dee.Delapp@anthem.com</ccEmails>
        <ccEmails>Margaret.Workman@anthem.com</ccEmails>
        <ccEmails>SpecialtyPharmacyClinicalStrategies@anthem.com</ccEmails>
        <description>RDRC Form</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/RDRC_Form</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Quote_Owner</fullName>
        <description>Send Email to Quote Owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Create_Engage_Standard_Form</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Quote_Owner_Engage_Scoping_AND_CIF</fullName>
        <description>Send Email to Quote Owner(Engage Scoping AND CIF)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Engage_Scoping_Form_and_CIF</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Quote_Owner_NonCompletion_Of_ESForm</fullName>
        <description>Send Email to Quote Owner(NonCompletion_Of_ESForm)</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Non_Completion_of_ESForm</template>
    </alerts>
    <fieldUpdates>
        <fullName>LG_QLI_Product_Type_Identifier_Update</fullName>
        <description>This update copies the logic of ProductLOB field. Update this value whenever the formula field logic is updated.</description>
        <field>Product_Type_Identifier__c</field>
        <formula>IF(
NOT(ISBLANK(TEXT(Product2.LOB__c))),
TEXT(Product2.LOB__c),
LEFT( TEXT(Product2.LOB_Org__c),LEN(TEXT(Product2.LOB_Org__c))-2 )
)</formula>
        <name>LG QLI Product Type Identifier Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI01_UpdateProdStagetoTermed</fullName>
        <field>ProductStage__c</field>
        <literalValue>Termed</literalValue>
        <name>QLI01  UpdateProdStagetoTermed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI02_Updateprobabilityquote</fullName>
        <field>Probability__c</field>
        <literalValue>0%</literalValue>
        <name>QLI02 Updateprobabilityquote</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI03_UpdateOppType</fullName>
        <description>Updates Opp type to In Group Change.</description>
        <field>OppType__c</field>
        <literalValue>In Group Change</literalValue>
        <name>QLI03 UpdateOppType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI03_UpdateOppType_Local_Sales</fullName>
        <field>OppType__c</field>
        <literalValue>In Group Change Local</literalValue>
        <name>QLI03 UpdateOppType Local Sales</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI03_UpdateProductStage</fullName>
        <description>Updates Product Stage field to Dead.</description>
        <field>ProductStage__c</field>
        <literalValue>Dead</literalValue>
        <name>QLI03 UpdateProductStage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI03_UpdateTermdate</fullName>
        <description>Updates Term date.</description>
        <field>TermDate__c</field>
        <formula>IF(ISNULL(TermDate__c ) &amp;&amp; ISPICKVAL (ProductStage__c, &quot;Termed&quot;), Quote.Opportunity.CloseDate ,TermDate__c)</formula>
        <name>QLI03 UpdateTermdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI03_Update_OppTypequote1</fullName>
        <field>OppType__c</field>
        <literalValue>Renewal</literalValue>
        <name>QLI03 Update OppTypequote1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI04_Update_OppType_Local_Sales</fullName>
        <field>OppType__c</field>
        <literalValue>New Business Local</literalValue>
        <name>QLI04 Update OppType Local Sales</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI05_Update_Product_Stages</fullName>
        <field>ProductStage__c</field>
        <literalValue>Dead</literalValue>
        <name>QLI05 Update Product Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI05_UpdateprodstagetoIGAPDead</fullName>
        <field>ProductStage__c</field>
        <literalValue>IGAP Dead</literalValue>
        <name>QLI05 UpdateprodstagetoIGAPDead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI06_Update_OppType</fullName>
        <description>Updates Opp type to In Group Add Product</description>
        <field>OppType__c</field>
        <literalValue>In Group Add Product</literalValue>
        <name>QLI06 Update OppType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI06_Update_Product_Stages</fullName>
        <description>Update product stages</description>
        <field>ProductStage__c</field>
        <literalValue>IGAP Lost</literalValue>
        <name>QLI06 Update Product Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI07_UpdateOppTypequote2</fullName>
        <field>OppType__c</field>
        <literalValue>Renewal</literalValue>
        <name>QLI07 UpdateOppTypequote2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI07_UpdateOppTypequoteToRenewalLocal</fullName>
        <field>OppType__c</field>
        <literalValue>Renewal Local</literalValue>
        <name>QLI07 UpdateOppTypequoteToRenewalLocal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI07_Update_In_Group_Add_Product_Local</fullName>
        <field>OppType__c</field>
        <literalValue>In Group Add Product Local</literalValue>
        <name>QLI07 Update In Group Add Product Local</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI07_Update_OppType</fullName>
        <description>updating opptype with opportunity record type</description>
        <field>OppType__c</field>
        <literalValue>In Group Add Product</literalValue>
        <name>QLI07 Update OppType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI07_Update_Product_Stages</fullName>
        <description>updating product stage</description>
        <field>ProductStage__c</field>
        <literalValue>IGAP Dead</literalValue>
        <name>QLI07 Update Product Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI08UpdateProductStages</fullName>
        <description>Updates the product stage value to &apos;Sold&apos;</description>
        <field>ProductStage__c</field>
        <literalValue>Sold</literalValue>
        <name>QLI08 Update Product Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI09UpdateProductStages</fullName>
        <description>Updates the product stages to &apos;Lost&apos;</description>
        <field>ProductStage__c</field>
        <literalValue>Lost</literalValue>
        <name>QLI09 Update Product Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI_Omada_checkbox_update_after_email</fullName>
        <description>Created this to update On completion of sending the email, reset the &quot;Omada Configuration Complete&quot; checkbox to False.</description>
        <field>Omada_Configuration_Complete__c</field>
        <literalValue>0</literalValue>
        <name>QLI- Omada checkbox update after email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI_SoleraUpdate_Confirmation_Email_Date</fullName>
        <description>Updating Confirmation Email Date to Today&apos;s Date after sending the email.</description>
        <field>Confirmation_Email_Date__c</field>
        <formula>TODAY()</formula>
        <name>QLI SoleraUpdate Confirmation Email Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI_Solera_Field_update_after_email</fullName>
        <description>Created this to update On completion of sending the email, reset the &quot;Solera Configuration Complete&quot; checkbox to False.</description>
        <field>Solera_Configuration_Complete__c</field>
        <literalValue>0</literalValue>
        <name>QLI- Solera Field update after email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI_Update_Omada_Email_for_Product_Conf</fullName>
        <description>Updating the email field Omada_Email_for_Product_Config_complete__c so that old records will get uodated with the Email field value.
(We have a default value for this field ,but it only works for new records).</description>
        <field>Omada_Email_for_Product_Config_complete__c</field>
        <formula>$Label.QLI_Omada_Email_for_Product_Config_Complete</formula>
        <name>QLI- Update Omada Email for Product Conf</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>QLI_Update_Solera_Email_for_Product_Conf</fullName>
        <description>Updating the email field Omada_Email_for_Product_Config_complete__c so that old records will get uodated with the Email field value. 
(We have a default value for this field ,but it only works for new records).</description>
        <field>Solera_Email_for_Product_Confi_complete__c</field>
        <formula>$Label.QLI_Solera_Email_for_Product_Config_Complete</formula>
        <name>QLI-Update Solera Email for Product Conf</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Manager_Email</fullName>
        <field>Account_Manager_Email__c</field>
        <formula>Quote.Opportunity.Account.Account_Team_Manager_Email__c</formula>
        <name>Update Account Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Team_Implementer_Email</fullName>
        <field>Implementer_Email__c</field>
        <formula>Quote.Opportunity.Account.Account_Team_Implementer_Email__c</formula>
        <name>Update Account Team Implementer Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Completion_Marker</fullName>
        <field>PLComplete__c</field>
        <literalValue>1</literalValue>
        <name>Update Completion Marker</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Confirmation_Email_Date</fullName>
        <description>Updating Confirmation Email Date to Today&apos;s Date after sending the email.</description>
        <field>Confirmation_Email_Date__c</field>
        <formula>TODAY()</formula>
        <name>QLI-Update Confirmation Email Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_OppType</fullName>
        <field>OppType__c</field>
        <literalValue>New Business</literalValue>
        <name>QLI04 Update OppType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_PLComplete</fullName>
        <field>PLComplete__c</field>
        <literalValue>1</literalValue>
        <name>Update PLComplete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_PLNotComplete</fullName>
        <field>PLComplete__c</field>
        <literalValue>0</literalValue>
        <name>Update PLNotComplete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Product_Stages</fullName>
        <description>Update product stages</description>
        <field>ProductStage__c</field>
        <literalValue>Lost</literalValue>
        <name>QLI04 Update Product Stages</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>ANA Full Opt Out</fullName>
        <actions>
            <name>ANA_FullOptOut</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>QuoteLineItem.FullOptOut__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA Subrogation Carve Out</fullName>
        <actions>
            <name>ANA_SubroCarveOut</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QuoteLineItem.Subrogation_Carved_Out__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI01  update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI01_UpdateProdStagetoTermed</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_Update_OppTypequote1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Quote.Opportunity.RecordType.Name = &apos;Renewal&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Customer Termed&quot;),    OR( ISPICKVAL(ProductStage__c ,&quot;In Progress&quot;) ,ISPICKVAL(ProductStage__c , &quot;Jeopardy&quot;), ISPICKVAL(ProductStage__c , &quot;Renewed&quot; )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI01 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI01_UpdateProdStagetoTermed</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_UpdateOppTypequoteToRenewalLocal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND( $Profile.Name= &apos;Local Sales&apos; , Quote.Opportunity.RecordType.Name = &apos;Renewal Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Customer Termed&quot;), OR( ISPICKVAL(ProductStage__c ,&quot;In Progress&quot;) ,ISPICKVAL(ProductStage__c , &quot;Jeopardy&quot;), ISPICKVAL(ProductStage__c , &quot;Renewed&quot; )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI02  update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI05_UpdateprodstagetoIGAPDead</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_UpdateOppTypequote2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Quote.Opportunity.RecordType.Name =&apos;Renewal&apos;, ISCHANGED(TECH_UpdateToInvoke__c),   ISPICKVAL(Quote.Opportunity.StageName,&quot;Customer Termed&quot;), OR(ISPICKVAL(ProductStage__c ,&quot;IGAP In Progress&quot;) ,ISPICKVAL(ProductStage__c , &quot; IGAP Sold&quot;), ISPICKVAL(ProductStage__c , &quot; IGAP Lost &quot; )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI02 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI05_UpdateprodstagetoIGAPDead</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_UpdateOppTypequoteToRenewalLocal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND($Profile.Name= &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;Renewal Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL(Quote.Opportunity.StageName,&quot;Customer Termed&quot;), OR(ISPICKVAL(ProductStage__c ,&quot;IGAP In Progress&quot;) ,ISPICKVAL(ProductStage__c , &quot; IGAP Sold&quot;), ISPICKVAL(ProductStage__c , &quot; IGAP Lost &quot; )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI03 Update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateOppType</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateProductStage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Cancelled&apos;.</description>
        <formula>AND( Quote.Opportunity.RecordType.Name = &apos;In Group Change&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Cancelled&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI03 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateOppType_Local_Sales</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateProductStage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Cancelled&apos;.</description>
        <formula>AND($Profile.Name= &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;In Group Change Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Cancelled&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI04  update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_OppType</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow trigger when stage Pick list field  has value &quot;Closed Lost&quot; for Opportunities with Record Type &apos;New Business&apos;</description>
        <formula>AND( !$User.BypassWorkflow__c,Quote.Opportunity.RecordType.Name = &apos;New Business&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Lost&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI04 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI04_Update_OppType_Local_Sales</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow trigger when stage Pick list field  has value &quot;Closed Lost&quot; for Opportunities with Record Type &apos;New Business&apos;</description>
        <formula>AND( !$User.BypassWorkflow__c, $Profile.Name= &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;New Business Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Lost&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI05 update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI05_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_OppType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow triggers when stage Pick List values has &quot;Closed Dead&quot; &amp; &quot;DTQ&quot; for Opportunities with Record Type &apos;New Business&apos;</description>
        <formula>AND( Quote.Opportunity.RecordType.Name = &apos;New Business&apos;, ISCHANGED(TECH_UpdateToInvoke__c), OR(ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Dead&quot;),ISPICKVAL( Quote.Opportunity.StageName , &quot;DTQ&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI05 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI04_Update_OppType_Local_Sales</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI05_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow triggers when stage Pick List values has &quot;Closed Dead&quot; &amp; &quot;DTQ&quot; for Opportunities with Record Type &apos;New Business&apos;</description>
        <formula>AND( $Profile.Name= &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;New Business Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), OR(ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Dead&quot;),ISPICKVAL( Quote.Opportunity.StageName , &quot;DTQ&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI06 Update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI06_Update_OppType</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI06_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Add Product and opportunity stage name is equal to &apos;Closed Lost&apos;.</description>
        <formula>AND( Quote.Opportunity.RecordType.Name = &apos;In Group Add Product&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Lost&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI06 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI06_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_In_Group_Add_Product_Local</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Add Product and opportunity stage name is equal to &apos;Closed Lost&apos;.</description>
        <formula>AND($Profile.Name = &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;In Group Add Product Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Lost&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI07 update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_OppType</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Add Product and opportunity stage name is equal to &apos;Closed Dead&apos; or &apos;DTQ&apos;.</description>
        <formula>AND( Quote.Opportunity.RecordType.Name =&apos;In Group Add Product&apos;, ISCHANGED(TECH_UpdateToInvoke__c),OR(ISPICKVAL(Quote.Opportunity.StageName , &quot;Closed Dead&quot;),ISPICKVAL(Quote.Opportunity.StageName , &quot;DTQ&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI07 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_In_Group_Add_Product_Local</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Add Product and opportunity stage name is equal to &apos;Closed Dead&apos; or &apos;DTQ&apos;.</description>
        <formula>AND( $Profile.Name = &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;In Group Add Product Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c),OR(ISPICKVAL(Quote.Opportunity.StageName , &quot;Closed Dead&quot;),ISPICKVAL(Quote.Opportunity.StageName , &quot;DTQ&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI08 IdentifyingproductsasComplete</fullName>
        <actions>
            <name>Update_PLComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(!$User.BypassWorkflow__c,Product2.Name =&quot;Health and Wellness - Live Health Online&quot;, ProductSelections__c  &gt;0,NOT(ISPICKVAL(ForASOBenefitsLoaded__c,&quot;&quot;)),NOT(ISPICKVAL(IsBHcarvedoutorbenefitsexcluded__c,&quot;&quot;)),NOT(ISPICKVAL(GrouphasANABHbutOptoutofLHOBH__c,&quot;&quot;)), NOT(IsthisRenewalOpportunityCloned__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI08 IdentifyingproductsasCompleteorNotComplete</fullName>
        <actions>
            <name>Update_PLComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(!$User.BypassWorkflow__c,Product2.Name =&quot;Health and Wellness - Live Health Online&quot;, ProgramLines__c&gt;0,  NOT(ISPICKVAL(ForASOBenefitsLoaded__c,&quot;&quot;)),NOT(ISPICKVAL(IsBHcarvedoutorbenefitsexcluded__c,&quot;&quot;)),NOT(ISPICKVAL(GrouphasANABHbutOptoutofLHOBH__c,&quot;&quot;)),  OR(ISCHANGED(ForASOBenefitsLoaded__c), ISCHANGED(IsBHcarvedoutorbenefitsexcluded__c), ISCHANGED(GrouphasANABHbutOptoutofLHOBH__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI09 IdentifyingproductsasComplete</fullName>
        <actions>
            <name>Update_PLComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(!$User.BypassWorkflow__c,Product2.Name =&quot;Network Based - Non-Par Provider Reimbursement (NCN)&quot;, ProductSelections__c&gt;0,NOT(IsthisRenewalOpportunityCloned__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI09 IdentifyingproductsasCompleteorNotComplete</fullName>
        <actions>
            <name>Update_PLComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(!$User.BypassWorkflow__c,Product2.Name =&quot;Network Based - Non-Par Provider Reimbursement (NCN)&quot;,  ProductSelections__c &gt;0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI10 IdentifyingproductsasComplete</fullName>
        <actions>
            <name>Update_PLComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(!$User.BypassWorkflow__c, OR(Product2.Name = &quot;AIM: A La Carte&quot;,Product2.Name =&quot;Health and Wellness: A La Carte&quot;,Product2.Name =&quot;Castlight – Buy Up Products&quot;,Product2.Name =&quot;Health and Wellness - Worksite Wellness&quot;,((Product2.Name =&quot;Medical - Specialty Pharmacy - A La Carte&quot;  ||  Product2.Name =&quot;Medical - Specialty Pharmacy - Select&quot;  || Product2.Name =&quot;Medical - Specialty Pharmacy - Standard&quot;) &amp;&amp;  VSOC_Configuration_Complete__c  = true )), ProgramLines__c  &gt; 0,NOT(IsthisRenewalOpportunityCloned__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI10 IdentifyingproductsasCompleteorNotComplete</fullName>
        <actions>
            <name>Update_PLComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(!$User.BypassWorkflow__c,Product2.Name = &quot;AIM: A La Carte&quot;, ProgramLines__c  &gt; 0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI12 IdentifyingproductsasNotComplete</fullName>
        <actions>
            <name>Update_PLNotComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND 	(!$User.BypassWorkflow__c, 	Product2.Name =&quot;Health and Wellness - Live Health Online&quot;,  	ProductSelections__c  &lt; 1, 	NOT(IsthisRenewalOpportunityCloned__c ), 	OR( 		ISPICKVAL(ForASOBenefitsLoaded__c,&quot;&quot;), 		ISPICKVAL(IsBHcarvedoutorbenefitsexcluded__c,&quot;&quot;), 		ISPICKVAL(GrouphasANABHbutOptoutofLHOBH__c,&quot;&quot;) 	)	 )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI13 IdentifyingproductsasNotComplete</fullName>
        <actions>
            <name>Update_PLNotComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(!$User.BypassWorkflow__c,Product2.Name =&quot;Network Based - Non-Par Provider Reimbursement (NCN)&quot;,  ProductSelections__c&lt;1,NOT(IsthisRenewalOpportunityCloned__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI14 IdentifyingproductsasNotComplete</fullName>
        <actions>
            <name>Update_PLNotComplete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(!$User.BypassWorkflow__c, OR(Product2.Name = &quot;AIM: A La Carte&quot;,Product2.Name =&quot;Health and Wellness: A La Carte&quot;,Product2.Name =&quot;Castlight – Buy Up Products&quot;,Product2.Name =&quot;Health and Wellness - Worksite Wellness&quot;,Product2.Name =&quot;Medical - Specialty Pharmacy - A La Carte&quot;), OR(ProgramLines__c &lt; 1, ISBLANK(ProgramLines__c) ),NOT(IsthisRenewalOpportunityCloned__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI16 EmailAlertBasedOnProductStageAndProductName</fullName>
        <actions>
            <name>QLI01_EngageProductSoldAlert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email when the (Quote Line Item Product [equals] Engage Essential [or] Engage Elite) AND (Product Stage [equals] &apos;Sold&apos; [or] &apos;IGAP Sold&apos;)</description>
        <formula>AND(  OR(  Product2.Name  = &apos;Engage Essential&apos;, Product2.Name  = &apos;Engage Elite&apos;, Product2.Name  = &apos;Engage Standard&apos;, Product2.Name  = &apos;Engage Essential Plus&apos;, Product2.Name  = &apos;Engage Elite Plus&apos;),    OR( ISPICKVAL( ProductStage__c , &apos;Sold&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Sold&apos;) ) , AnthemEntity__c=&apos;National Accounts&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI16 EmailAlertBasedOnProductStageAndProductName Other AHG</fullName>
        <actions>
            <name>QLI01_Other_AHG_Product_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email when the (Quote Line Item Product [equals] Other-Anthem Health Guide AND (Product Stage [equals] &apos;Sold&apos; [or] &apos;IGAP Sold&apos; [or] 
&apos;Lost&apos; [or] &apos;Dead&apos; [or] &apos;IGAP Lost&apos; [or] &apos;IGAP Dead&apos;)</description>
        <formula>AND(  OR(  Product2.Name  = &apos;Other-Anthem Health Guide&apos;),  OR( ISPICKVAL( ProductStage__c , &apos;Sold&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Sold&apos;), ISPICKVAL( ProductStage__c , &apos;Lost&apos;),  ISPICKVAL( ProductStage__c , &apos;Dead&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Lost&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Dead&apos;) ) , AnthemEntity__c=&apos;National Accounts&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI17 Update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI08UpdateProductStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage if Opportunity record type name is equal to &apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Confirmed&apos; and Add_or_Lose_Lives__c = &quot;Add Lives&quot;.</description>
        <formula>AND(Quote.Opportunity.RecordType.Name = &apos;In Group Change&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Confirmed&quot;), ISPICKVAL(Quote.Opportunity.Add_or_Lose_Lives__c,&quot;Add Lives&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI17 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI08UpdateProductStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates Quote Line Items fields: Product Stage if Opportunity record type name is equal to &apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Confirmed&apos; and Add_or_Lose_Lives__c = &quot;Add Lives&quot;.</description>
        <formula>AND( $Profile.Name = &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;In Group Change Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Confirmed&quot;), ISPICKVAL(Quote.Opportunity.Add_or_Lose_Lives__c,&quot;Add Lives&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI18 Update Product Stages based on Opportunity Stage</fullName>
        <actions>
            <name>QLI09UpdateProductStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage if Opportunity record type name is equal to &apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Confirmed&apos; and Add_or_Lose_Lives__c = &quot;Lose Lives&quot;.</description>
        <formula>AND(Quote.Opportunity.RecordType.Name = &apos;In Group Change&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Confirmed&quot;), ISPICKVAL(Quote.Opportunity.Add_or_Lose_Lives__c,&quot;Lose Lives&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI18 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI09UpdateProductStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Updates Quote Line Items fields: Product Stage if Opportunity record type name is equal to &apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Confirmed&apos; and Add_or_Lose_Lives__c = &quot;Lose Lives&quot;.</description>
        <formula>AND($Profile.Name= &apos;Local Sales&apos;, Quote.Opportunity.RecordType.Name = &apos;In Group Change Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Confirmed&quot;), ISPICKVAL(Quote.Opportunity.Add_or_Lose_Lives__c,&quot;Lose Lives&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI19 EmailAlertBasedOnProductStageAndProductName</fullName>
        <actions>
            <name>QLI01_C3_Product_Sold_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email when the (Quote Line Item Product [equals] C3) AND (Product Stage [equals] &apos;Sold&apos; [or] &apos;IGAP Sold&apos;)</description>
        <formula>AND(  OR(  Product2.Name  = &apos;C3 Concierge Cancer Care&apos;, Product2.Name  = &apos;C3 Concierge Cancer Care&apos;),    OR( ISPICKVAL( ProductStage__c , &apos;Sold&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Sold&apos;) ) , AnthemEntity__c=&apos;National Accounts&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA WF QLI20 EmailAlertBasedOnProductStageAndProductName</fullName>
        <actions>
            <name>QLI01_Unduo_Product_Sold_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email when the (Quote Line Item Product [equals] Unduo) AND (Product Stage [equals] &apos;Sold&apos; [or] &apos;IGAP Sold&apos;)</description>
        <formula>AND(  OR(  Product2.Name  = &apos;Onduo - Virtual Diabetes Clinic&apos;, Product2.Name  = &apos;Onduo - Virtual Diabetes Clinic&apos;),    OR( ISPICKVAL( ProductStage__c , &apos;Sold&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Sold&apos;) ) , AnthemEntity__c=&apos;National Accounts&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI01 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI01_UpdateProdStagetoTermed</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_UpdateOppTypequoteToRenewalLocal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(OR($Profile.Name= &apos;Local Sales&apos; ,$Profile.Name=&apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;Renewal Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Customer Termed&quot;), OR( ISPICKVAL(ProductStage__c ,&quot;In Progress&quot;) ,ISPICKVAL(ProductStage__c , &quot;Jeopardy&quot;), ISPICKVAL(ProductStage__c , &quot;Renewed&quot; )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI02 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI05_UpdateprodstagetoIGAPDead</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_UpdateOppTypequoteToRenewalLocal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;Renewal Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL(Quote.Opportunity.StageName,&quot;Customer Termed&quot;), OR(ISPICKVAL(ProductStage__c ,&quot;IGAP In Progress&quot;) ,ISPICKVAL(ProductStage__c , &quot; IGAP Sold&quot;), ISPICKVAL(ProductStage__c , &quot; IGAP Lost &quot; )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI03 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateOppType_Local_Sales</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateProductStage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Cancelled&apos;.</description>
        <formula>AND(OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;In Group Change Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Cancelled&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI04 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI04_Update_OppType_Local_Sales</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow trigger when stage Pick list field  has value &quot;Closed Lost&quot; for Opportunities with Record Type &apos;New Business&apos;</description>
        <formula>AND( !$User.BypassWorkflow__c, OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;New Business Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Lost&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI05 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI04_Update_OppType_Local_Sales</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI05_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow triggers when stage Pick List values has &quot;Closed Dead&quot; &amp; &quot;DTQ&quot; for Opportunities with Record Type &apos;New Business&apos;</description>
        <formula>AND( OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;),Quote.Opportunity.RecordType.Name = &apos;New Business Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), OR(ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Dead&quot;),ISPICKVAL( Quote.Opportunity.StageName , &quot;DTQ&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI06 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI06_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_In_Group_Add_Product_Local</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Add Product and opportunity stage name is equal to &apos;Closed Lost&apos;.</description>
        <formula>AND(OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;In Group Add Product Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Closed Lost&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI07 update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI02_Updateprobabilityquote</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI03_UpdateTermdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_In_Group_Add_Product_Local</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI07_Update_Product_Stages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage, Probability, Term Date and Opp Type if Opportunity record type name is equal to&apos;In Group Add Product and opportunity stage name is equal to &apos;Closed Dead&apos; or &apos;DTQ&apos;.</description>
        <formula>AND(OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;In Group Add Product Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c),OR(ISPICKVAL(Quote.Opportunity.StageName , &quot;Closed Dead&quot;),ISPICKVAL(Quote.Opportunity.StageName , &quot;DTQ&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI17 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI08UpdateProductStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage if Opportunity record type name is equal to &apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Confirmed&apos; and Add_or_Lose_Lives__c = &quot;Add Lives&quot;.</description>
        <formula>AND( OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;In Group Change Local&apos;, ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Confirmed&quot;), ISPICKVAL(Quote.Opportunity.Add_or_Lose_Lives__c,&quot;Add Lives&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ANA_V1 WF QLI18 Update Product Stages based on Opportunity Stage Local Sales</fullName>
        <actions>
            <name>QLI09UpdateProductStages</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Quote Line Items fields: Product Stage if Opportunity record type name is equal to &apos;In Group Change&apos; and opportunity stage name is equal to &apos;Change Confirmed&apos; and Add_or_Lose_Lives__c = &quot;Lose Lives&quot;.</description>
        <formula>AND(OR($Profile.Name= &apos;Local Sales&apos;,$Profile.Name= &apos;Local Sales Dual&apos;), Quote.Opportunity.RecordType.Name = &apos;In Group Change Local&apos;,ISCHANGED(TECH_UpdateToInvoke__c), ISPICKVAL( Quote.Opportunity.StageName , &quot;Change Confirmed&quot;), ISPICKVAL(Quote.Opportunity.Add_or_Lose_Lives__c,&quot;Lose Lives&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Alert Product Stage%3A Sold%2FIGAP Sold</fullName>
        <actions>
            <name>Alert_Product_Stage_Sold_IGAP_Sold</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Account_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Account_Team_Implementer_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>PRDCRM-27581</description>
        <formula>AND( ISCHANGED(ProductStage__c ),  OR( Product2.Name = &quot;Anthem Health Rewards: Direct Package&quot;, Product2.Name = &quot;Anthem Health Rewards: Direct Outcomes &amp; Claims&quot;, Product2.Name = &quot;Anthem Health Rewards: Direct Outcome Based&quot;, Product2.Name = &quot;Anthem Health Rewards: Direct Claims Based&quot;),  OR(  ISPICKVAL(ProductStage__c , &quot;Sold&quot;), ISPICKVAL(ProductStage__c , &quot;IGAP Sold&quot;))  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Anthem Health Rewards Alert</fullName>
        <active>true</active>
        <description>PRDCRM-27581</description>
        <formula>AND( OR(  Product2.Name = &quot;Anthem Health Rewards:  Direct Claims Based&quot;, Product2.Name = &quot;Anthem Health Rewards:  Direct Outcome Based&quot;, Product2.Name = &quot;Anthem Health Rewards:  Direct Outcomes &amp; Claims&quot;, Product2.Name = &quot;Anthem Health Rewards: Direct Package&quot;), OR( ISPICKVAL(ProductStage__c, &quot;Sold&quot;), ISPICKVAL(ProductStage__c, &quot;IGAP Sold&quot;)),  NOT(ISBLANK(EffectiveDate__c)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Anthem_Health_Rewards_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>QuoteLineItem.EffectiveDate__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Automated Email Anthem Health Guide Sold</fullName>
        <actions>
            <name>Automated_Email_Anthem_Health_Guide_Sold</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>OR( AND( AHGProduct__c = TRUE, OR( ISCHANGED(ProductStage__c), ISPICKVAL(ProductStage__c, &quot;IGAP Sold&quot;)), ISPICKVAL(ProductStage__c, &quot;IGAP Sold&quot;) ), AND( AHGProduct__c = TRUE, OR( ISCHANGED(ProductStage__c), ISPICKVAL(ProductStage__c, &quot;Sold&quot;)), ISPICKVAL(ProductStage__c, &quot;Sold&quot;) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Automated Email Anthem Health Guide Sold 1</fullName>
        <actions>
            <name>Automated_Email_Anthem_Health_Guide_Sold_1</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>OR( AND( MHA_Product__c = TRUE, OR( ISCHANGED(ProductStage__c), ISPICKVAL(ProductStage__c, &quot;IGAP Sold&quot;)), ISPICKVAL(ProductStage__c, &quot;IGAP Sold&quot;) ), AND( MHA_Product__c = TRUE, OR( ISCHANGED(ProductStage__c), ISPICKVAL(ProductStage__c, &quot;Sold&quot;)), ISPICKVAL(ProductStage__c, &quot;Sold&quot;) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>LG EmailAlert Commercial Products</fullName>
        <actions>
            <name>LG_EmailAlert_Commercial_Products</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This rule fires an email when the (Product Types [equals] Commercial Act Wise [or] Commercial AIM [or] Commercial Buy-Ups [or] Commercial Engage [or] Commercial Subrogation [or] FSA) AND (Product Stage [equals] &apos;Sold&apos; [or] &apos;IGAP Sold&apos;)</description>
        <formula>AND (OR( OR(ISPICKVAL( Product2.Product_Type__c, &apos;FSA&apos;), AND((ISPICKVAL( Product2.Product_Type__c, &apos;Medical&apos;)),  OR(ISPICKVAL( Product2.Product_Family__c, &apos;CDHP&apos;),ISPICKVAL( Product2.Product_Family__c, &apos;Medical CDHP&apos;))) ),  AND( AnthemEntity__c=&apos;Local/Large Group&apos; , National_Local_Merged__c =&apos;Yes&apos;)) ,  OR( ISPICKVAL( ProductStage__c , &apos;Sold&apos;), ISPICKVAL( ProductStage__c , &apos;IGAP Sold&apos;) ), (NOT(ISPICKVAL( Product2.Product_Type__c, &apos;Commercial Blue Distinction&apos;))), LastModifiedBy.Profile.Name &lt;&gt; &apos;API User&apos; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LG_Update Product Type Identifier</fullName>
        <actions>
            <name>LG_QLI_Product_Type_Identifier_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Product Type Identifier with the Product LOB value.</description>
        <formula>ISPICKVAL(Quote.Opportunity.Account.Anthem_Entity__c, &apos;Local/Large Group&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>QLI_WF1_NotifySalesUser</fullName>
        <actions>
            <name>Send_Email_to_Quote_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR (2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>QuoteLineItem.ProductStage__c</field>
            <operation>equals</operation>
            <value>IGAP Sold</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Standard</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductStage__c</field>
            <operation>equals</operation>
            <value>Sold</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QLI_WF2_Engage Scoping Form and CIF</fullName>
        <actions>
            <name>Send_Email_to_Quote_Owner_Engage_Scoping_AND_CIF</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4) AND (5 OR 6)</booleanFilter>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Elite</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Essential</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Elite Plus</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Essential Plus</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductStage__c</field>
            <operation>equals</operation>
            <value>Sold</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductStage__c</field>
            <operation>equals</operation>
            <value>IGAP Sold</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>QLI_WF3_NonCompletion_Of_ESForm</fullName>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4) AND (5 OR 6) AND 7</booleanFilter>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Elite</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Elite Plus</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Essential</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Engage Essential Plus</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductStage__c</field>
            <operation>equals</operation>
            <value>Sold</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductStage__c</field>
            <operation>equals</operation>
            <value>IGAP Sold</value>
        </criteriaItems>
        <criteriaItems>
            <field>Quote.Ready_to_Submit_Engage_Scoping_Form__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>The Owner of the Quote will receive an email notification if the user did not complete the Engage Scoping Form</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Email_to_Quote_Owner_NonCompletion_Of_ESForm</name>
                <type>Alert</type>
            </actions>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>QLI_WF3_QLI_RDRC Form</fullName>
        <actions>
            <name>Email_Notification_for_Terming_of_RDRC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>When RDRC Med to Rx or Med to Rx and Rx to Med product stage is Email Notification for Terming of RDRC (Right Drug Right Channel)</description>
        <formula>AND(OR(ISPICKVAL(Product2.QLIRecordType__c,&apos;Medical - Specialty Pharmacy - A La Carte&apos;), ISPICKVAL(Product2.QLIRecordType__c, &apos;Medical - Specialty Pharmacy - Complete&apos;), ISPICKVAL(Product2.QLIRecordType__c, &apos;Medical-Specialty Pharmacy-Complete (FI)&apos;), ISPICKVAL(Product2.QLIRecordType__c, &apos;Medical - Specialty Pharmacy - Select&apos;), ISPICKVAL(Product2.QLIRecordType__c, 	&apos;Medical - Specialty Pharmacy - Standard&apos;)),ISPICKVAL(ProductStage__c,&apos;Termed&apos;), OR(ISPICKVAL(Quote.Med_to_Rx__c,&apos;Yes&apos;),ISPICKVAL(Quote.Med_to_Rx_and_Rx_to_Med__c,&apos;Yes&apos;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email to Omada for Product configuration complete</fullName>
        <actions>
            <name>QLI_Send_Email_to_Omada_for_Product_Config</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>QLI_Omada_checkbox_update_after_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI_Update_Omada_Email_for_Product_Conf</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Completion_Marker</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Confirmation_Email_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QuoteLineItem.Omada_Configuration_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Created this Rule to send an email to ConfirmedAccounts@omadahealth.com  after completing the Product configuration for Omada.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email to Solera for Product configuration complete</fullName>
        <actions>
            <name>QLI_Send_Email_to_Solera_for_Product_Config</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>QLI_SoleraUpdate_Confirmation_Email_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI_Solera_Field_update_after_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>QLI_Update_Solera_Email_for_Product_Conf</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Completion_Marker</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>QuoteLineItem.Solera_Configuration_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Created this Rule to send an email to anthemnewlaunches@soleranetwork.com after completing the Product configuration for Solera.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Voluntary Site Of Care EMail Alert</fullName>
        <actions>
            <name>Email_Alert_Voluntary_Site_Of_Care</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QuoteLineItem.VSOC_Configuration_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF2_QLI_RDRC Form</fullName>
        <actions>
            <name>RDRC_Configuration_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>QuoteLineItem.RDRC_Configuration_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_QLI_RDRC Form</fullName>
        <actions>
            <name>RDRC_Form</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4 OR 5) AND (6 OR 7 OR 8 OR 9 OR 10)</booleanFilter>
        <criteriaItems>
            <field>QuoteLineItem.RecordType__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.RecordType__c</field>
            <operation>equals</operation>
            <value>Medical-Specialty Pharmacy-Complete (FI)</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.RecordType__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - Select</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.RecordType__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - Standard</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.RecordType__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - A La Carte</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - A La Carte</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Medical-Specialty Pharmacy-Complete (FI)</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - Select</value>
        </criteriaItems>
        <criteriaItems>
            <field>QuoteLineItem.ProductName__c</field>
            <operation>equals</operation>
            <value>Medical - Specialty Pharmacy - Standard</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
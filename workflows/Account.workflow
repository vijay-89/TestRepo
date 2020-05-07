<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Lead_record_created</fullName>
        <ccEmails>vijay03969@gmail.com</ccEmails>
        <ccEmails>kumar.k495@yahoo.in</ccEmails>
        <ccEmails>mohan.sfdcdeveloper@gmail.com</ccEmails>
        <description>New Lead record created</description>
        <protected>false</protected>
        <recipients>
            <recipient>kumar.k495@yahoo.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MarketingProductInquiryResponse</template>
    </alerts>
    <alerts>
        <fullName>New_account_record_created</fullName>
        <description>New account record created</description>
        <protected>false</protected>
        <recipients>
            <recipient>kumar.k495@yahoo.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <alerts>
        <fullName>approved_by_vishist</fullName>
        <description>approved by vishist</description>
        <protected>false</protected>
        <recipients>
            <recipient>kumar.k495@yahoo.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <alerts>
        <fullName>selected_in_blue_star</fullName>
        <description>selected in blue star</description>
        <protected>false</protected>
        <recipients>
            <recipient>kumar.k495@yahoo.in</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <fieldUpdates>
        <fullName>Field_Update</fullName>
        <field>CustomerPriority__c</field>
        <literalValue>Low</literalValue>
        <name>Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>test</fullName>
        <apiVersion>38.0</apiVersion>
        <description>hi</description>
        <endpointUrl>http://www.google.com</endpointUrl>
        <fields>BillingStreet</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>kumar.k495@yahoo.in</integrationUser>
        <name>test</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
</Workflow>

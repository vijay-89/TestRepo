/*
 * Class Name: ApplicationEventAction
 * Current Version: 1.0
 * Created Date: October 2019
 * Author: Archima
 * Description: This class has an invocable method that is used by a process
 * to publish LG Application platform events.
 */
public with sharing class ApplicationEventAction {

    @InvocableMethod(label='Create Application Events')
    public static void createApplicationEvents(List<Id> orderIds) {
        List<Order> orders = [
            SELECT
                OpportunityId,
                OrderNumber,
                LG_Broker_Portal_Case_Status__c,
                LG_Broker_Portal_Status_Date__c,
                LG_Broker_Portal_Status_Event_Type__c,
                Account.Situs_State_Abbrev__c
            FROM
                Order
            WHERE
                Id IN :orderIds
        ];

        Set<Id> opportunityIds = new Set<Id>();

        for (Order order : orders) {
            opportunityIds.add(order.OpportunityId);
        }

        List<Brokerage_and_Consultant1__c> brokerageConsultants = [
            SELECT
                Opportunity__c,
                Brokerage_of_Record__c,
                Consultant_of_Record__c,
                Consultant__r.Account__r.ENCRYPTID__c,
                Consultant__r.Contact__r.ENCRYPTID__c
            FROM
                Brokerage_and_Consultant1__c
            WHERE
                Opportunity__c IN :opportunityIds
            AND
                (
                    Brokerage_of_Record__c = true
                    OR
                    Consultant_of_Record__c = true
                )
        ];

        Map<Id, Brokerage_and_Consultant1__c> opportunityBrokerageConsultants = new Map<Id, Brokerage_and_Consultant1__c>();
        Map<Id, Brokerage_and_Consultant1__c> opportunityWritingConsultants = new Map<Id, Brokerage_and_Consultant1__c>();

        for (Brokerage_and_Consultant1__c brokerageConsultant : brokerageConsultants) {
            if (brokerageConsultant.Brokerage_of_Record__c == true) {
                opportunityBrokerageConsultants.put(brokerageConsultant.Opportunity__c, brokerageConsultant);
            }

            if (brokerageConsultant.Consultant_of_Record__c == true) {
                opportunityWritingConsultants.put(brokerageConsultant.Opportunity__c, brokerageConsultant);
            }
        }

        for (Order order : orders) {
            Brokerage_and_Consultant1__c brokerageConsultant = opportunityBrokerageConsultants.get(order.OpportunityId);
            Brokerage_and_Consultant1__c writingConsultant = opportunityWritingConsultants.get(order.OpportunityId);

            AnthemAPI.EventRequest eventRequest = new AnthemAPI.EventRequest();
            eventRequest.eventName = order.LG_Broker_Portal_Status_Event_Type__c;
            eventRequest.eventCorrelation = new AnthemAPI.EventCorrelation();
            eventRequest.eventCorrelation.correlationId = order.OrderNumber;
            eventRequest.eventCorrelation.vendorAppId = order.OrderNumber;
            eventRequest.eventData = new AnthemAPI.EventData();
            eventRequest.eventData.lineOfBusiness = 'LG';
            eventRequest.eventData.agentTins = new List<AnthemAPI.AgentTin>();
            eventRequest.eventData.agentTins.add(new AnthemAPI.AgentTin());
            eventRequest.eventData.agentTins[0].payeeTin = (brokerageConsultant == null ? null : brokerageConsultant.Consultant__r.Account__r.ENCRYPTID__c);
            eventRequest.eventData.agentTins[0].writingTin = (writingConsultant == null ? null : writingConsultant.Consultant__r.Contact__r.ENCRYPTID__c);
            eventRequest.eventData.state = order.Account.Situs_State_Abbrev__c;
            eventRequest.eventData.summary = order.LG_Broker_Portal_Case_Status__c;
            eventRequest.timeStamp = APIApplication.formatDate(order.LG_Broker_Portal_Status_Date__c, 'MM-dd-yyyy');

            AnthemAPI.postEvent(JSON.serialize(eventRequest));
        }

    }

}
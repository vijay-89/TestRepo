/*
 * Class Name: ApplicationEventActionTest
 * Current Version: 1.0
 * Created Date: October 2019
 * Author: Archima
 * Description: This class has the unit tests for the ApplicationEventAction class.
 */
@isTest
private class ApplicationEventActionTest {

    @isTest
    static void testCreateApplicationEvents() {
        AnthemAPITest.setupData();

        Account account = new Account();
        account.Name = 'Test';
        insert account;

        Date nextMonthDate = Date.today().addMonths(1);

        Opportunity opportunity = new Opportunity();
        opportunity.AccountId = account.Id;
        opportunity.Name = 'Test';
        opportunity.StageName = 'Prospecting';
        opportunity.CloseDate = Date.newInstance(nextMonthDate.year(), nextMonthDate.month(), 15);
        insert opportunity;

        Brokerage_and_Consultant1__c brokerageConsultant = new Brokerage_and_Consultant1__c();
        brokerageConsultant.Opportunity__c = opportunity.Id;
        brokerageConsultant.Brokerage_of_Record__c = true;
        brokerageConsultant.Consultant_of_Record__c = true;
        insert brokerageConsultant;

        Order order = new Order();
        order.AccountId = account.Id;
        order.OpportunityId = opportunity.Id;
        order.EffectiveDate = opportunity.CloseDate;
        order.Status = 'Draft';
        insert order;

        HttpResponse httpResponseToken = new HttpResponse();
        httpResponseToken.setBody(LGJiraUtilityMockTest.jiraSuccessResponse);
        httpResponseToken.setStatusCode(200);

        HttpResponse httpResponseEvent = new HttpResponse();
        httpResponseEvent.setStatusCode(200);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new AnthemAPITest.AnthemAPICalloutMock(new List<HttpResponse>{httpResponseToken, httpResponseEvent}));

        // NOTE: ApplicationEventAction.createApplicationEvents() sole purpose is to make an API call - no data is modified in Salesforce.
        try {
            ApplicationEventAction.createApplicationEvents(new List<Id>{order.Id});
        } catch (Exception e) {
            System.assert(false, 'Exception should not have been thrown.');
        }

        Test.stopTest();
    }

}
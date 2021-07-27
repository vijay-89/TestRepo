/**
*******************************************************************************************
* Name           NLPFileResponse_WS_Test
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   04/02/2020
* UsedBy         This is the test class for 'NLPFileResponse_WS' class which will also Invoke BenefitUtility and CensusUtility classes.
*******************************************************************************************/
@isTest
public with sharing class NLPFileResponse_WS_Test{
    /**
    _________________________________________________________________________________________
    *@Description : This method creates test data which is common for all test methods in class
    _________________________________________________________________________________________
    **/
    @TestSetup
    static void createData(){
        
        List<Account> listAccount=  TestDataFactory.createAccountSICList(2,'Testdata',  'Streetdata',  'Citydata',  'Statedata',  'ZIPdata',  'countrydata',  'stateCodedata');
        insert listAccount;
        
        List<Case>  listCase= TestDataFactory.createCaseList(1, listAccount[0]);
        string srecTypeID = Schema.SobjectType.Case.getRecordTypeInfosByDeveloperName().get('RFP_Intake_Case').getRecordTypeId();
        listCase[0].RecordTypeid= srecTypeID;
        insert listCase; 
   
        List<Request_Tracking__c>  listRequestTracking= TestDataFactory.createRequestTracking(1, listCase[0], 'new' );
        insert listRequestTracking;
        
        ContentVersion listContentVersion= TestDataFactory.createContentVersionList(1)[0];
        listContentVersion.Request_Tracking_ID__c = listRequestTracking[0].id;
        insert listContentVersion;
    }
    
    /**
    _________________________________________________________________________________________
    @Description: This method tests about malforming JSON request body coming from NLP response
    _________________________________________________________________________________________
    **/
    @isTest
    static  void malFormingJSONTest(){

        LogSeverityLevelValue__c oLogSeverity =  new LogSeverityLevelValue__c(SetupOwnerId=UserInfo.getOrganizationId(), LoggingLevel__c='Error');
        insert oLogSeverity;

        RestRequest restRequest = new RestRequest();  
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        String sErrorJSON = '{"ErrorJSON"}';
        restRequest.requestBody = Blob.valueOf(sErrorJSON);
        RestContext.request = restRequest;

        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        
        //Checking If there is no benefit record created in the system
        system.assertEquals([Select Id from Benefit__c].size(),0,staticVariableClass.assertEquals);

        //Checking If there is no census record created in the system
        system.assertEquals([Select Id from Census__c].size(),0,staticVariableClass.assertEquals);

        //Checking If there is any exception log record created in the system.
        system.assertEquals([Select Id from ExceptionLog__c].size(),1,staticVariableClass.assertEquals);
    }
    
    /**
    _________________________________________________________________________________________
    @Description: This method tests about document errors from NLP response
    _________________________________________________________________________________________
    **/
     @isTest
    static  void documentErrorsTest(){
        RestRequest restRequest = new RestRequest();  
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        NLPFileResponse_WS.DocumentResponse oDocumentResponse = new NLPFileResponse_WS.DocumentResponse();
        oDocumentResponse.requestId = '1234';
        oDocumentResponse.transactionStatus = '400';

        NLPFileResponse_WS.DocumentInformation oDocumentInformation = new NLPFileResponse_WS.DocumentInformation();
        oDocumentInformation.context = 'Benefit';

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];
                                    
        if(!listCV.isEmpty()){
            oDocumentInformation.Id = listCV[0].Id;
            oDocumentResponse.businessContextId = listCV[0].Request_Tracking_ID__r.CaseID__c;
        }

        NLPFileResponse_WS.DocumentErrorInformation oErrorInformation = new NLPFileResponse_WS.DocumentErrorInformation();
        
        //Giving code more than 255 characters to check failure of content version update 
        oErrorInformation.code = 'E2ENLP.400.2.E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2E2ENLP.400.2';
        oErrorInformation.description = 'File is corrupted.Upload new file';
        
        oDocumentInformation.errors = new List<NLPFileResponse_WS.DocumentErrorInformation>{oErrorInformation};
        oDocumentResponse.document = new List<NLPFileResponse_WS.DocumentInformation>{oDocumentInformation};
                
        restRequest.requestBody = Blob.valueOf(JSON.serialize(oDocumentResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        
        //Checking If there is no benefit record created in the system
        system.assertEquals([Select Id from Benefit__c].size(),0,staticVariableClass.assertEquals);
        //Checking If there is no census record created in the system
        system.assertEquals([Select Id from Census__c].size(),0,staticVariableClass.assertEquals);

        listCV = [Select Id,Response_Status__c,Error_Message__c
                 from ContentVersion LIMIT 1];

        if(!listCV.isEmpty()){
            //Checking If content version record is updated with response status and error message
            system.assertEquals(listCV[0].Response_Status__c,null,staticVariableClass.assertEquals);
            system.assertEquals(listCV[0].Error_Message__c,null,staticVariableClass.assertEquals);
        } 
    }

    /**
    _________________________________________________________________________________________
    @Description :This method tests about benefit document administration mappings
    _________________________________________________________________________________________
    **/
     @isTest
    static void benefitDocumentContext(){
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        //Creating Test Response Data
        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        oBenefitResponse.transactionId = String.valueOf(System.now());
        oBenefitResponse.transactionTime = String.valueOf(System.now());
        oBenefitResponse.transactionStatus = 200;
        oBenefitResponse.requestId = String.valueOf(System.now());
        oBenefitResponse.lobType = StaticVariableClass.Entity;
        oBenefitResponse.transactionId = '200';
        oBenefitResponse.businessContextId = 'CaseId';
        List<ContentVersion> listCV = [SELECT Id, Request_Tracking_ID__r.CaseID__c 
                                       FROM ContentVersion 
                                       LIMIT 1];

        BenefitResponseWrapper.PlanAdminOption oPlanAdminOption = new BenefitResponseWrapper.PlanAdminOption();
        oPlanAdminOption.id = StaticVariableClass.PLAN_NAME;
        oPlanAdminOption.name = StaticVariableClass.PLAN_NAME;
        oPlanAdminOption.type = StaticVariableClass.PLAN_NAME;
        oPlanAdminOption.value = new List<String>{'Aetna PPO'};
            
        BenefitResponseWrapper.PlanAdminOption oPlanAdminOption1 = new BenefitResponseWrapper.PlanAdminOption();
        oPlanAdminOption1.id = StaticVariableClass.PAYER_NAME;
        oPlanAdminOption1.value = new List<String>{'Aetna'};

        BenefitResponseWrapper.PlanAdminOption oPlanAdminOption2 = new BenefitResponseWrapper.PlanAdminOption();
        oPlanAdminOption2.id = StaticVariableClass.PRODUCT_FAMILY_ID;
        oPlanAdminOption2.value = new List<String>{'PPO'};
            
        BenefitResponseWrapper.PlanAdminSection oPlanAdminSection = new BenefitResponseWrapper.PlanAdminSection();
        oPlanAdminSection.id = 'plnInfrmtn';
        oPlanAdminSection.name = 'Plan Information';
        oPlanAdminSection.adminOption = new List<BenefitResponseWrapper.PlanAdminOption>{oPlanAdminOption,oPlanAdminOption1,oPlanAdminOption2};
            
        BenefitResponseWrapper.PlanAdministration oPlanAdministration = new BenefitResponseWrapper.PlanAdministration();
        oPlanAdministration.administrationSection = new List<BenefitResponseWrapper.PlanAdminSection>{oPlanAdminSection};
            
        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.administration = oPlanAdministration;
        
        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }
        oBenefitDocumentInfo.type = 'pdf';
        oBenefitDocumentInfo.data = oBenefitData;
        
        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};
            
        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        
        List<Benefit__c> listBenefit = [Select Id,Plan_Name__c,Competitor_Name__c,Product_Family__c from Benefit__c];
        
        System.assert(listBenefit.size() > 0,staticVariableClass.assertEquals);
        System.assertEquals(listBenefit[0].Plan_Name__c,'Aetna PPO',staticVariableClass.assertEquals);
        System.assertEquals(listBenefit[0].Competitor_Name__c,'Aetna',staticVariableClass.assertEquals);
        System.assertEquals(listBenefit[0].Product_Family__c,'PPO',staticVariableClass.assertEquals);
    }

    /**
    _________________________________________________________________________________________
    @Description :This method tests about medical benefit general administration mappings
    _________________________________________________________________________________________
    **/
     @isTest
    static  void medicalBenefitGAMappings(){
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';

        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();

        BenefitResponseWrapper.PlanAdminOption oPlanAdminOption = new BenefitResponseWrapper.PlanAdminOption();
        oPlanAdminOption.id = StaticVariableClass.PLAN_NAME;
        oPlanAdminOption.value = new List<String>{'Aetna PPO'}; 

        BenefitResponseWrapper.PlanAdminOption oPlanAdminOption1 = new BenefitResponseWrapper.PlanAdminOption();
        oPlanAdminOption1.id = StaticVariableClass.PAYER_NAME;
        oPlanAdminOption1.value = new List<String>{'Aetna'};

        BenefitResponseWrapper.PlanAdminOption oPlanAdminOption2 = new BenefitResponseWrapper.PlanAdminOption();
        oPlanAdminOption2.id = StaticVariableClass.PRODUCT_FAMILY_ID;
        oPlanAdminOption2.value = new List<String>{'PPO'};
	
        BenefitResponseWrapper.PlanAdminSection oPlanAdminSection = new BenefitResponseWrapper.PlanAdminSection();
        oPlanAdminSection.id = 'plnInfrmtn';
        oPlanAdminSection.adminOption = new List<BenefitResponseWrapper.PlanAdminOption>{oPlanAdminOption,oPlanAdminOption1,oPlanAdminOption2};
	
        BenefitResponseWrapper.PlanAdministration oPlanAdministration = new BenefitResponseWrapper.PlanAdministration();
        oPlanAdministration.administrationSection = new List<BenefitResponseWrapper.PlanAdminSection>{oPlanAdminSection};

        List<BenefitResponseWrapper.PlanBenefitOption> listPlanBenefitOptions = new List<BenefitResponseWrapper.PlanBenefitOption>();
        BenefitResponseWrapper.PlanBenefitOption oPlanBenefitOption;

        for(Integer iCounter=0;iCounter < 5;iCounter++){
            oPlanBenefitOption = new BenefitResponseWrapper.PlanBenefitOption();
            oPlanBenefitOption.name=StaticVariableClass.PLAN_CO_INSURANCE;
            oPlanBenefitOption.type=StaticVariableClass.PLAN_CO_INSURANCE;
            oPlanBenefitOption.boa=StaticVariableClass.PLAN_CO_INSURANCE;
            oPlanBenefitOption.uom=StaticVariableClass.PLAN_CO_INSURANCE;
            oPlanBenefitOption.benefitPeriod=StaticVariableClass.PLAN_CO_INSURANCE;
            oPlanBenefitOption.value = new List<String>{'90'};
            listPlanBenefitOptions.add(oPlanBenefitOption);
        }

        listPlanBenefitOptions[0].id=StaticVariableClass.PLAN_CO_INSURANCE;
        listPlanBenefitOptions[1].id=StaticVariableClass.OOP_MAX_INDIVIDUAL;
        listPlanBenefitOptions[2].id=StaticVariableClass.OOP_MAX_FAMILY;
        listPlanBenefitOptions[3].id=StaticVariableClass.DEDUCTIBLE_INDIVIDUAL;
        listPlanBenefitOptions[4].id=StaticVariableClass.DEDUCTIBLE_FAMILY;
        
        BenefitResponseWrapper.PlanGeneralBenefitTier oBenefitTier = new BenefitResponseWrapper.PlanGeneralBenefitTier();
        oBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oBenefitTier.benefitOption = listPlanBenefitOptions;

        BenefitResponseWrapper.PlanGeneralBenefitTier oBenefitTier1 = new BenefitResponseWrapper.PlanGeneralBenefitTier();
        oBenefitTier1.id = StaticVariableClass.OUT_OF_NETWORK;
        oBenefitTier1.name = StaticVariableClass.OUT_OF_NETWORK;
        oBenefitTier1.benefitOption = listPlanBenefitOptions;

        List<BenefitResponseWrapper.PlanGeneralBenefitTier> listPlanBenefitTiers = new 
        List<BenefitResponseWrapper.PlanGeneralBenefitTier>{oBenefitTier,oBenefitTier1};
        
        BenefitResponseWrapper.PlanGeneralBenefit oPlanGeneralBenefit = new BenefitResponseWrapper.PlanGeneralBenefit();

        BenefitResponseWrapper.PlanGeneralBenefit oPlanGeneralBenefit1 = new BenefitResponseWrapper.PlanGeneralBenefit();

        BenefitResponseWrapper.PlanGeneralBenefit oPlanGeneralBenefit2 = new BenefitResponseWrapper.PlanGeneralBenefit();

        //Co-Insurance mappings
        oPlanGeneralBenefit.id = StaticVariableClass.CO_INSURANCE;
        oPlanGeneralBenefit.name = StaticVariableClass.CO_INSURANCE;
        oPlanGeneralBenefit.tier = listPlanBenefitTiers;
        oPlanGeneralBenefit.adminOption = new List<BenefitResponseWrapper.PlanAdminOption>();

        oPlanGeneralBenefit1.id = StaticVariableClass.OUT_OF_POCKET;
        oPlanGeneralBenefit1.name = StaticVariableClass.OUT_OF_POCKET;
        oPlanGeneralBenefit1.tier = listPlanBenefitTiers;

        oPlanGeneralBenefit2.id = StaticVariableClass.DEDUCTIBLE;
        oPlanGeneralBenefit2.name = StaticVariableClass.DEDUCTIBLE;
        oPlanGeneralBenefit2.tier = listPlanBenefitTiers;

        List<BenefitResponseWrapper.PlanGeneralBenefit> listPlanGeneralBenefit = new List<BenefitResponseWrapper.PlanGeneralBenefit>{oPlanGeneralBenefit,oPlanGeneralBenefit1,oPlanGeneralBenefit2};

        BenefitResponseWrapper.PlanGeneralAdmin oPlanAdmin = new BenefitResponseWrapper.PlanGeneralAdmin();
        oPlanAdmin.generalBenefit = listPlanGeneralBenefit;

        BenefitResponseWrapper.MedicalPlan oMedicalPlan = new BenefitResponseWrapper.MedicalPlan();
        oMedicalPlan.generalBasisOfAdministration = oPlanAdmin;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.medical = oMedicalPlan;
        oBenefitPlan.administration = oPlanAdministration;

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];
        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }
        oBenefitDocumentInfo.data = oBenefitData;
        
        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();

        //Method called to check upsert logic
        NLPFileResponse_WS.parseAndPersistNLPResponse();

        List<Benefit__c> listBenefits = [Select In_Network_Coinsurance__c,
                                        Out_of_Network_Coinsurance__c,In_Network_Deductible_Single__c,Out_of_Network_Deductible_Single__c,In_Network_Deductible_Family__c,Out_of_Network_Deductible_Family__c,In_Network_Out_of_Pocket_Max_Single__c,OON_Out_of_Pocket_Max_Single__c,In_Network_Out_of_Pocket_Max_Family__c,OON_Out_of_Pocket_Max_Family__c
                                        from Benefit__c
                                        ];
        system.assertEquals(listBenefits.size(),1,staticVariableClass.assertEquals);                               
        system.assertEquals(listBenefits[0].In_Network_Coinsurance__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].Out_of_Network_Coinsurance__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].In_Network_Deductible_Single__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].Out_of_Network_Deductible_Single__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].In_Network_Deductible_Family__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].Out_of_Network_Deductible_Family__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].In_Network_Out_of_Pocket_Max_Single__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].OON_Out_of_Pocket_Max_Single__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].In_Network_Out_of_Pocket_Max_Family__c,90,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].OON_Out_of_Pocket_Max_Family__c,90,staticVariableClass.assertEquals); 
    }    
    
    /**
    _________________________________________________________________________________________
    @Description :This method tests about medical benefits mappings
    _________________________________________________________________________________________
    **/
     @isTest
    static  void medicalBenefitsMappings(){
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';

        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        
        BenefitResponseWrapper.PlanBenefitOption oBenefitOption = new BenefitResponseWrapper.PlanBenefitOption();
        oBenefitOption.id = StaticVariableClass.COPAY_ID;
        oBenefitOption.name = StaticVariableClass.COPAY_ID;
        oBenefitOption.type = StaticVariableClass.COPAY_ID;
        oBenefitOption.boa = StaticVariableClass.COPAY_ID;
        oBenefitOption.uom = StaticVariableClass.COPAY_ID;
        oBenefitOption.value = new list<String>{'100'};

        BenefitResponseWrapper.PlanBenefitOption oBenefitOption1 = new BenefitResponseWrapper.PlanBenefitOption();
        oBenefitOption1.id = StaticVariableClass.COVERED_AT_ID;
        oBenefitOption1.value = new list<String>{'100'};        

        List<BenefitResponseWrapper.PlanBenefitOption> listBenefitOptions = new 
        List<BenefitResponseWrapper.PlanBenefitOption>{oBenefitOption,oBenefitOption1};

        BenefitResponseWrapper.MedicalPlanCalculation oMedicalPlanCalculation = new BenefitResponseWrapper.MedicalPlanCalculation();
        oMedicalPlanCalculation.id = StaticVariableClass.PCP_CONFIG;
        oMedicalPlanCalculation.name = StaticVariableClass.PCP_CONFIG;
        oMedicalPlanCalculation.benefitOption = listBenefitOptions;

        BenefitResponseWrapper.MedicalPlanCalculation oMedicalPlanCalculation1 = new BenefitResponseWrapper.MedicalPlanCalculation();
        oMedicalPlanCalculation1.id = StaticVariableClass.SPC_CONFIG;
        oMedicalPlanCalculation1.name = StaticVariableClass.SPC_CONFIG;
        oMedicalPlanCalculation1.benefitOption = listBenefitOptions;

        List<BenefitResponseWrapper.MedicalPlanCalculation> listMedicalPlanCalculations = new List<BenefitResponseWrapper.MedicalPlanCalculation>{oMedicalPlanCalculation,oMedicalPlanCalculation1};

        BenefitResponseWrapper.MedicalPlanAdministrationType oMedicalAdminType = new BenefitResponseWrapper.MedicalPlanAdministrationType();
        oMedicalAdminType.id = StaticVariableClass.COVERED_PCP_SPC_SEPARATION;
        oMedicalAdminType.name = StaticVariableClass.COVERED_PCP_SPC_SEPARATION;
        oMedicalAdminType.calculation = listMedicalPlanCalculations;

        BenefitResponseWrapper.MedicalPlanBenefitTier oMedicalPlanBenefitTier = new 
        BenefitResponseWrapper.MedicalPlanBenefitTier();
        oMedicalPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oMedicalPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oMedicalPlanBenefitTier.administrationType = oMedicalAdminType;

        BenefitResponseWrapper.MedicalPlanBenefitTier oMedicalPlanBenefitTier1 = new 
        BenefitResponseWrapper.MedicalPlanBenefitTier();
        oMedicalPlanBenefitTier1.id = StaticVariableClass.OUT_OF_NETWORK;
        oMedicalPlanBenefitTier1.name = StaticVariableClass.OUT_OF_NETWORK;
        oMedicalPlanBenefitTier1.administrationType = oMedicalAdminType;

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit.id = StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL;
        oMedicalPlanBenefit.name = StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL;
        oMedicalPlanBenefit.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit1 = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit1.id = StaticVariableClass.EMERGENCY_INSTITUTIONAL;
        oMedicalPlanBenefit1.name = StaticVariableClass.EMERGENCY_INSTITUTIONAL;
        oMedicalPlanBenefit1.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit2 = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit2.id = StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL;
        oMedicalPlanBenefit2.name = StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL;
        oMedicalPlanBenefit2.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory.id = StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID;
        oBenefitCategory.name = StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID;
        oBenefitCategory.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory1 = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory1.id = StaticVariableClass.URGENT_CARE_ID;
        oBenefitCategory1.name = StaticVariableClass.URGENT_CARE_ID;
        oBenefitCategory1.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit2};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory2 = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory2.id = StaticVariableClass.EMERGENCY_CARE_ID;
        oBenefitCategory2.name = StaticVariableClass.EMERGENCY_CARE_ID;
        oBenefitCategory2.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit1};

        BenefitResponseWrapper.MedicalPlanBenefits oPlanBenefits = new BenefitResponseWrapper.MedicalPlanBenefits();
        oPlanBenefits.benefitCategory = new list<BenefitResponseWrapper.MedicalPlanBenefitCategory>{oBenefitCategory,oBenefitCategory1,oBenefitCategory2};

        BenefitResponseWrapper.MedicalPlan oMedicalPlan = new BenefitResponseWrapper.MedicalPlan();
        oMedicalPlan.benefits = oPlanBenefits;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.medical = oMedicalPlan;

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        oBenefitDocumentInfo.location = 'test';
        oBenefitDocumentInfo.errors = new list<BenefitResponseWrapper.ErrorInformation>();
        oBenefitDocumentInfo.data = oBenefitData;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];
        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }

        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();

        
        Benefit__c oBenefit = [Select Co_Pay_Primary_Care_Provider_INN__c,               
                               Co_Ins_Primary_Care_Provider_OON__c,Co_Pay_Specialty_Care_Provider_INN__c,
                               Co_Ins_Specialty_Care_Provider_OON__c
                               from Benefit__c
                               limit 1
                              ];

        system.assertEquals(oBenefit.Co_Pay_Primary_Care_Provider_INN__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Primary_Care_Provider_OON__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Pay_Specialty_Care_Provider_INN__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Specialty_Care_Provider_OON__c,'100',staticVariableClass.assertEquals);   
    }
    
    
    /**
    _________________________________________________________________________________________
    @Description: This method tests about census and census member creation
    _________________________________________________________________________________________
    **/
     @isTest
    static  void censusDocumentContext(){
        
        ContentVersion id = [SELECT Id, Request_Tracking_ID__r.CaseID__c FROM ContentVersion Limit 1];
        string caseId = id.Request_Tracking_ID__r.CaseID__c;
        string contentVersionId= id.Id;
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        //Creating Test Response Data
        CensusMemberResponseWrapper oCensusResponse = new CensusMemberResponseWrapper();
        Integer len = 15;
        String str = string.valueof(Math.abs(Crypto.getRandomLong()));
        String randomNumber = str.substring(0, len);
        
        oCensusResponse.transactionId=randomNumber;
        oCensusResponse.transactionTime=randomNumber;
        oCensusResponse.lobType=StaticVariableClass.Entity;
        
        CensusMemberResponseWrapper.CensusMemberData oCensusData = new CensusMemberResponseWrapper.CensusMemberData();
        CensusMemberResponseWrapper.CensusMemberPerson ocensus = new CensusMemberResponseWrapper.CensusMemberPerson();
        ocensus.firstName ='john';
        ocensus.lastName ='doe';
        ocensus.zipcode = '90990';
        ocensus.age=20;
        
        oCensusData.person = new list <CensusMemberResponseWrapper.CensusMemberPerson>{ocensus};
            
        CensusMemberResponseWrapper.CensusMemberDocumentInformation oCensusMemberDocument = new CensusMemberResponseWrapper.CensusMemberDocumentInformation();
        
        oCensusMemberDocument.context = StaticVariableClass.CENSUS;
        oCensusMemberDocument.id =ContentVersionId;
        oCensusMemberDocument.location='sfdc://caseid';
        oCensusMemberDocument.type='excel';
        oCensusMemberDocument.data =  oCensusData;
        
        oCensusResponse.document = new list <CensusMemberResponseWrapper.CensusMemberDocumentInformation>{oCensusMemberDocument};
            
        restRequest.requestBody = Blob.valueOf(JSON.serialize(oCensusResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        
        List<Census__c> listCensus = [Select Id,CaseID__c from Census__c where CaseID__c=: caseId ];
        //checking census record is getting created
        System.assert(listCensus.size() > 0,staticVariableClass.assertEquals);
        System.assertEquals(listCensus[0].CaseID__c, caseId,staticVariableClass.assertEquals);
        
        List<Census_Members__c> listCensusMember = [Select Id,first_Name__c,last_Name__c,age__c from Census_Members__c where CensusID__c =:listCensus];
      
        //checking census member record is getting created     
        System.assert(listCensusMember.size() > 0,staticVariableClass.assertEquals);
        System.assertEquals(listCensusMember[0].first_Name__c,'john',staticVariableClass.assertEquals);
        System.assertEquals(listCensusMember[0].last_Name__c,'doe',staticVariableClass.assertEquals);
        System.assertEquals(listCensusMember[0].age__c,20,staticVariableClass.assertEquals);
    }

    /**
    _________________________________________________________________________________________
    @Description: This method tests about partial success scenario for census files.
    _________________________________________________________________________________________

    **/
     @isTest
    static void censusPartialSuccessTest(){
        
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        ContentVersion cv = [SELECT Id, Request_Tracking_ID__r.CaseID__c FROM ContentVersion Limit 1];
        string caseId = cv.Request_Tracking_ID__r.CaseID__c;
        CensusMemberResponseWrapper oCensusResponse = new CensusMemberResponseWrapper();
        
        CensusMemberResponseWrapper.ErrorInformation oErrorInformation = new CensusMemberResponseWrapper.ErrorInformation();
        oErrorInformation.code = '500.1';
        oErrorInformation.description = 'Invalid Date Format';

        CensusMemberResponseWrapper.ErrorInformation oErrorInformation1 = new CensusMemberResponseWrapper.ErrorInformation();
        oErrorInformation1.code = '500.2';
        oErrorInformation1.description = 'Invalid Zip Code';

        CensusMemberResponseWrapper.CensusMemberDocumentInformation oCensusMemberDocument = new CensusMemberResponseWrapper.CensusMemberDocumentInformation();
        oCensusMemberDocument.context = StaticVariableClass.CENSUS;
        oCensusMemberDocument.id =cv.Id;
        oCensusMemberDocument.errors = new List<CensusMemberResponseWrapper.ErrorInformation>{oErrorInformation,oErrorInformation1};
        oCensusMemberDocument.data = new CensusMemberResponseWrapper.CensusMemberData();
        oCensusResponse.document = new list <CensusMemberResponseWrapper.CensusMemberDocumentInformation>{oCensusMemberDocument};
            
        restRequest.requestBody = Blob.valueOf(JSON.serialize(oCensusResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        
        List<Census__c> listcensusCheck = [Select Id,CaseID__c,Active_In_Active_Flag__c,NLP_Processing_Failure__c
                                           from Census__c 
                                           where CaseID__c=: caseId 
                                           Order by createdDate asc];
        System.assert(listcensusCheck.size() > 0,staticVariableClass.assertEquals);
        System.assertEquals(listcensusCheck[0].CaseID__c, caseId,staticVariableClass.assertEquals);
        System.assertEquals(listcensusCheck[0].Active_In_Active_Flag__c, true,staticVariableClass.assertEquals);
        System.assertNotEquals(listcensusCheck[0].NLP_Processing_Failure__c, null,staticVariableClass.assertEquals);
    }
    
     /**
    _________________________________________________________________________________________
    @Description :This method tests about vision benefits mappings (Covered Mapping)
    _________________________________________________________________________________________
    **/
   @isTest
        static  void visionBenefitsCoveredMappings(){
        
        //Added as per PRDCRM2-2836 to enable/disable vision benefit creation functionality 
        Vision_Benefit_Creation__c oVisionBenefitCreation =  new Vision_Benefit_Creation__c(SetupOwnerId=UserInfo.getOrganizationId(), Allow_Vision_Benefit_Creation__c=true);
        insert oVisionBenefitCreation;

        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        
        BenefitResponseWrapper.PlanBenefitOption oBenefitOption = new BenefitResponseWrapper.PlanBenefitOption();
        oBenefitOption.id = StaticVariableClass.COPAY_ID;
        oBenefitOption.name = StaticVariableClass.COPAY_ID;
        oBenefitOption.type = StaticVariableClass.COPAY_ID;
        oBenefitOption.boa = StaticVariableClass.COPAY_ID;
        oBenefitOption.uom = StaticVariableClass.COPAY_ID;
        oBenefitOption.value = new list<String>{'100'};
          List<BenefitResponseWrapper.PlanBenefitOption> listBenefitOptions = new 
        List<BenefitResponseWrapper.PlanBenefitOption>{oBenefitOption};
           

        BenefitResponseWrapper.VisionPlanCalculation oVisionPlanCalculation = new BenefitResponseWrapper.VisionPlanCalculation();
        oVisionPlanCalculation.id = StaticVariableClass.DEFAULT_CONFIGURATION;
        oVisionPlanCalculation.name = StaticVariableClass.DEFAULT_CONFIGURATION;
        oVisionPlanCalculation.benefitOption = listBenefitOptions;
       
        List<BenefitResponseWrapper.VisionPlanCalculation> listVisionPlanCalculation = new List<BenefitResponseWrapper.VisionPlanCalculation>{oVisionPlanCalculation};
       
        BenefitResponseWrapper.VisionPlanAdministrationType oVisionAdminType = new BenefitResponseWrapper.VisionPlanAdministrationType();
        oVisionAdminType.id = StaticVariableClass.COVERED;
        oVisionAdminType.name = StaticVariableClass.COVERED;
        oVisionAdminType.calculation = listVisionPlanCalculation;
       
        BenefitResponseWrapper.VisionPlanBenefitTier oVisionPlanBenefitTier = new 
        BenefitResponseWrapper.VisionPlanBenefitTier();
        oVisionPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.administrationType = oVisionAdminType;
         
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit.id = StaticVariableClass.EYE_EXAM;
        oVisionPlanBenefit.name = StaticVariableClass.EYE_EXAM;
        oVisionPlanBenefit.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
           
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit1 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit1.id = StaticVariableClass.SINGLR_VISION_LENS;
        oVisionPlanBenefit1.name = StaticVariableClass.SINGLR_VISION_LENS;
        oVisionPlanBenefit1.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
  
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit2 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit2.id = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit2.name = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit2.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
    
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit3 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit3.id = StaticVariableClass.TRIFOCAL_LENS;
        oVisionPlanBenefit3.name = StaticVariableClass.TRIFOCAL_LENS;
        oVisionPlanBenefit3.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit4 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit4.id = StaticVariableClass.FRAMES;
        oVisionPlanBenefit4.name = StaticVariableClass.FRAMES;
        oVisionPlanBenefit4.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit5 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit5.id = StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit5.name = StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit5.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit6 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit6.id = StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit6.name = StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit6.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory.id = StaticVariableClass.EXAM;
        oBenefitCategory.name =StaticVariableClass.EXAM;
        oBenefitCategory.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit};

        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory1 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory1.id = StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory1.name =StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory1.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit1,oVisionPlanBenefit2,oVisionPlanBenefit3};

        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory2 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory2.id = StaticVariableClass.EYEGLASS_FRAMES;
        oBenefitCategory2.name =StaticVariableClass.EYEGLASS_FRAMES;
        oBenefitCategory2.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit4};
            
        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory3 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory3.id = StaticVariableClass.CONTACT_LENSES;
        oBenefitCategory3.name =StaticVariableClass.CONTACT_LENSES;
        oBenefitCategory3.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit5,oVisionPlanBenefit6};


        BenefitResponseWrapper.VisionPlanBenefits oPlanBenefits = new BenefitResponseWrapper.VisionPlanBenefits();
        oPlanBenefits.benefitCategory = new list<BenefitResponseWrapper.VisionPlanBenefitCategory>{oBenefitCategory,oBenefitCategory1,oBenefitCategory2,oBenefitCategory3};

            
        BenefitResponseWrapper.VisionPlan oVisionPlan = new BenefitResponseWrapper.VisionPlan();
        oVisionPlan.benefits = oPlanBenefits;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.vision = oVisionPlan;

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        oBenefitDocumentInfo.location = 'test';
        oBenefitDocumentInfo.errors = new list<BenefitResponseWrapper.ErrorInformation>();
        oBenefitDocumentInfo.data = oBenefitData;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];

        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }

        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();

        
        Benefit__c oBenefit = [Select INN_Exam__c,               
                               INN_Single_Vision_Lens__c,INN_Bifocal_Lens__c,
                               INN_Trifocal_Lens__c, INN_Frames__c,INN_Elective_Contact_Lens__c,INN_Non_Elective_Contact_Lens__c
                               from Benefit__c
                               limit 1
                              ];

        system.assertEquals(oBenefit.INN_Exam__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Single_Vision_Lens__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Bifocal_Lens__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Trifocal_Lens__c,'100',staticVariableClass.assertEquals);    
        system.assertEquals(oBenefit.INN_Frames__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Elective_Contact_Lens__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Non_Elective_Contact_Lens__c,'100',staticVariableClass.assertEquals);     

        }

     /**
    _________________________________________________________________________________________
    @Description :This method tests about vision benefits mappings(Not Covered)
    _________________________________________________________________________________________
    **/
     @isTest
        static  void visionBenefitNotCoveredMappings(){
        
        //Added as per PRDCRM2-2836 to enable/disable vision benefit creation functionality 
        Vision_Benefit_Creation__c oVisionBenefitCreation =  new Vision_Benefit_Creation__c(SetupOwnerId=UserInfo.getOrganizationId(), Allow_Vision_Benefit_Creation__c=true);
        insert oVisionBenefitCreation;

        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
          
        BenefitResponseWrapper.VisionPlanAdministrationType oVisionAdminType = new BenefitResponseWrapper.VisionPlanAdministrationType();
        oVisionAdminType.id = StaticVariableClass.NOT_COVERED;
        oVisionAdminType.name = StaticVariableClass.NOT_COVERED;
     
            
        BenefitResponseWrapper.VisionPlanBenefitTier oVisionPlanBenefitTier = new 
        BenefitResponseWrapper.VisionPlanBenefitTier();
        oVisionPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.administrationType = oVisionAdminType;
      

            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit.id = StaticVariableClass.EYE_EXAM;
        oVisionPlanBenefit.name = StaticVariableClass.EYE_EXAM;
        oVisionPlanBenefit.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit1 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit1.id = StaticVariableClass.SINGLR_VISION_LENS;
        oVisionPlanBenefit1.name = StaticVariableClass.SINGLR_VISION_LENS;
        oVisionPlanBenefit1.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};

            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit2 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit2.id = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit2.name = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit2.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};

            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit3 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit3.id = StaticVariableClass.TRIFOCAL_LENS;
        oVisionPlanBenefit3.name = StaticVariableClass.TRIFOCAL_LENS;
        oVisionPlanBenefit3.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit4 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit4.id = StaticVariableClass.FRAMES;
        oVisionPlanBenefit4.name = StaticVariableClass.FRAMES;
        oVisionPlanBenefit4.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit5 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit5.id = StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit5.name = StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit5.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit6 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit6.id = StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit6.name = StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit6.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            


        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory.id = StaticVariableClass.EXAM;
        oBenefitCategory.name =StaticVariableClass.EXAM;
        oBenefitCategory.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit};

        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory1 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory1.id = StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory1.name =StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory1.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit1,oVisionPlanBenefit2,oVisionPlanBenefit3};

         BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory2 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory2.id = StaticVariableClass.EYEGLASS_FRAMES;
        oBenefitCategory2.name =StaticVariableClass.EYEGLASS_FRAMES;
        oBenefitCategory2.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit4};
            
        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory3 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory3.id = StaticVariableClass.CONTACT_LENSES;
        oBenefitCategory3.name =StaticVariableClass.CONTACT_LENSES;
        oBenefitCategory3.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit5,oVisionPlanBenefit6};
    
       
        BenefitResponseWrapper.VisionPlanBenefits oPlanBenefits = new BenefitResponseWrapper.VisionPlanBenefits();
        oPlanBenefits.benefitCategory = new list<BenefitResponseWrapper.VisionPlanBenefitCategory>{oBenefitCategory,oBenefitCategory1,oBenefitCategory2,oBenefitCategory3};

            
        BenefitResponseWrapper.VisionPlan oVisionPlan = new BenefitResponseWrapper.VisionPlan();
        oVisionPlan.benefits = oPlanBenefits;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.vision = oVisionPlan;

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        oBenefitDocumentInfo.location = 'test';
        oBenefitDocumentInfo.errors = new list<BenefitResponseWrapper.ErrorInformation>();
        oBenefitDocumentInfo.data = oBenefitData;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];

        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }

        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();

        
        Benefit__c oBenefit = [Select INN_Exam__c,               
                               INN_Single_Vision_Lens__c,INN_Bifocal_Lens__c,
                               INN_Trifocal_Lens__c, INN_Frames__c,INN_Elective_Contact_Lens__c,INN_Non_Elective_Contact_Lens__c
                               from Benefit__c
                               limit 1
                              ];
       
        system.assertEquals(oBenefit.INN_Exam__c, StaticVariableClass.NotCvrd ,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Single_Vision_Lens__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Bifocal_Lens__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Trifocal_Lens__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);    
        system.assertEquals(oBenefit.INN_Frames__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Elective_Contact_Lens__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Non_Elective_Contact_Lens__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);     

      
  }
  /**
    _________________________________________________________________________________________
    @Description :This method tests about vision and medical benefits mappings
    _________________________________________________________________________________________
    **/    
     @isTest
       static  void medicalVisionBenefitsMappings(){

        //Added as per PRDCRM2-2836 to enable/disable vision benefit creation functionality 
        Vision_Benefit_Creation__c oVisionBenefitCreation =  new Vision_Benefit_Creation__c(SetupOwnerId=UserInfo.getOrganizationId(), Allow_Vision_Benefit_Creation__c=true);
        insert oVisionBenefitCreation;

        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';

        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        
        BenefitResponseWrapper.PlanBenefitOption oBenefitOption = new BenefitResponseWrapper.PlanBenefitOption();
        oBenefitOption.id = StaticVariableClass.COPAY_ID;
        oBenefitOption.name = StaticVariableClass.COPAY_ID;
        oBenefitOption.type = StaticVariableClass.COPAY_ID;
        oBenefitOption.boa = StaticVariableClass.COPAY_ID;
        oBenefitOption.uom = StaticVariableClass.COPAY_ID;
        oBenefitOption.value = new list<String>{'100'};

        BenefitResponseWrapper.PlanBenefitOption oBenefitOption1 = new BenefitResponseWrapper.PlanBenefitOption();
        oBenefitOption1.id = StaticVariableClass.COVERED_AT_ID;
        oBenefitOption1.value = new list<String>{'100'};        

        List<BenefitResponseWrapper.PlanBenefitOption> listBenefitOptions = new 
        List<BenefitResponseWrapper.PlanBenefitOption>{oBenefitOption,oBenefitOption1};

        BenefitResponseWrapper.MedicalPlanCalculation oMedicalPlanCalculation = new BenefitResponseWrapper.MedicalPlanCalculation();
        oMedicalPlanCalculation.id = StaticVariableClass.PCP_CONFIG;
        oMedicalPlanCalculation.name = StaticVariableClass.PCP_CONFIG;
        oMedicalPlanCalculation.benefitOption = listBenefitOptions;

        BenefitResponseWrapper.MedicalPlanCalculation oMedicalPlanCalculation1 = new BenefitResponseWrapper.MedicalPlanCalculation();
        oMedicalPlanCalculation1.id = StaticVariableClass.SPC_CONFIG;
        oMedicalPlanCalculation1.name = StaticVariableClass.SPC_CONFIG;
        oMedicalPlanCalculation1.benefitOption = listBenefitOptions;

        List<BenefitResponseWrapper.MedicalPlanCalculation> listMedicalPlanCalculations = new List<BenefitResponseWrapper.MedicalPlanCalculation>{oMedicalPlanCalculation,oMedicalPlanCalculation1};
     
        BenefitResponseWrapper.VisionPlanCalculation oVisionPlanCalculation = new BenefitResponseWrapper.VisionPlanCalculation();
        oVisionPlanCalculation.id = StaticVariableClass.DEFAULT_CONFIGURATION;
        oVisionPlanCalculation.name = StaticVariableClass.DEFAULT_CONFIGURATION;
        oVisionPlanCalculation.benefitOption = listBenefitOptions;
       
        List<BenefitResponseWrapper.VisionPlanCalculation> listVisionPlanCalculation = new List<BenefitResponseWrapper.VisionPlanCalculation>{oVisionPlanCalculation};
        
        BenefitResponseWrapper.MedicalPlanAdministrationType oMedicalAdminType = new BenefitResponseWrapper.MedicalPlanAdministrationType();
        oMedicalAdminType.id = StaticVariableClass.COVERED_PCP_SPC_SEPARATION;
        oMedicalAdminType.name = StaticVariableClass.COVERED_PCP_SPC_SEPARATION;
        oMedicalAdminType.calculation = listMedicalPlanCalculations;
        
        BenefitResponseWrapper.VisionPlanAdministrationType oVisionAdminType = new BenefitResponseWrapper.VisionPlanAdministrationType();
        oVisionAdminType.id = StaticVariableClass.COVERED;
        oVisionAdminType.name = StaticVariableClass.COVERED;
        oVisionAdminType.calculation = listVisionPlanCalculation;

        BenefitResponseWrapper.MedicalPlanBenefitTier oMedicalPlanBenefitTier = new 
        BenefitResponseWrapper.MedicalPlanBenefitTier();
        oMedicalPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oMedicalPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oMedicalPlanBenefitTier.administrationType = oMedicalAdminType;

        BenefitResponseWrapper.MedicalPlanBenefitTier oMedicalPlanBenefitTier1 = new 
        BenefitResponseWrapper.MedicalPlanBenefitTier();
        oMedicalPlanBenefitTier1.id = StaticVariableClass.OUT_OF_NETWORK;
        oMedicalPlanBenefitTier1.name = StaticVariableClass.OUT_OF_NETWORK;
        oMedicalPlanBenefitTier1.administrationType = oMedicalAdminType;
        
        BenefitResponseWrapper.VisionPlanBenefitTier oVisionPlanBenefitTier = new 
        BenefitResponseWrapper.VisionPlanBenefitTier();
        oVisionPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.administrationType = oVisionAdminType;
      

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit.id = StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL;
        oMedicalPlanBenefit.name = StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL;
        oMedicalPlanBenefit.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit1 = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit1.id = StaticVariableClass.EMERGENCY_INSTITUTIONAL;
        oMedicalPlanBenefit1.name = StaticVariableClass.EMERGENCY_INSTITUTIONAL;
        oMedicalPlanBenefit1.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit2 = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit2.id = StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL;
        oMedicalPlanBenefit2.name = StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL;
        oMedicalPlanBenefit2.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

               
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit.id = StaticVariableClass.EYE_EXAM;
        oVisionPlanBenefit.name = StaticVariableClass.EYE_EXAM;
        oVisionPlanBenefit.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
            
            BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit1 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit1.id = StaticVariableClass.SINGLR_VISION_LENS;
        oVisionPlanBenefit1.name = StaticVariableClass.SINGLR_VISION_LENS;
        oVisionPlanBenefit1.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};

            
            BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit2 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit2.id = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit2.name = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit2.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};

            
            BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit3 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit3.id = StaticVariableClass.TRIFOCAL_LENS;
        oVisionPlanBenefit3.name = StaticVariableClass.TRIFOCAL_LENS;
        oVisionPlanBenefit3.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
            BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit4 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit4.id = StaticVariableClass.FRAMES;
        oVisionPlanBenefit4.name = StaticVariableClass.FRAMES;
        oVisionPlanBenefit4.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
            
            BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit5 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit5.id = StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit5.name = StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit5.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
            BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit6 = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit6.id = StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit6.name = StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS;
        oVisionPlanBenefit6.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
            
        
        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory.id = StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID;
        oBenefitCategory.name = StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID;
        oBenefitCategory.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory1 = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory1.id = StaticVariableClass.URGENT_CARE_ID;
        oBenefitCategory1.name = StaticVariableClass.URGENT_CARE_ID;
        oBenefitCategory1.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit2};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory2 = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory2.id = StaticVariableClass.EMERGENCY_CARE_ID;
        oBenefitCategory2.name = StaticVariableClass.EMERGENCY_CARE_ID;
        oBenefitCategory2.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit1};
        
        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory3 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory3.id = StaticVariableClass.EXAM;
        oBenefitCategory3.name =StaticVariableClass.EXAM;
        oBenefitCategory3.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit};

        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory4 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory4.id = StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory4.name =StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory4.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit1,oVisionPlanBenefit2,oVisionPlanBenefit3};

         BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory5 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory5.id = StaticVariableClass.EYEGLASS_FRAMES;
        oBenefitCategory5.name =StaticVariableClass.EYEGLASS_FRAMES;
        oBenefitCategory5.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit4};
            
          BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory6 = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory6.id = StaticVariableClass.CONTACT_LENSES;
        oBenefitCategory6.name =StaticVariableClass.CONTACT_LENSES;
        oBenefitCategory6.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit5,oVisionPlanBenefit6};

        BenefitResponseWrapper.MedicalPlanBenefits oPlanBenefits = new BenefitResponseWrapper.MedicalPlanBenefits();
        oPlanBenefits.benefitCategory = new list<BenefitResponseWrapper.MedicalPlanBenefitCategory>{oBenefitCategory,oBenefitCategory1,oBenefitCategory2};
       
        BenefitResponseWrapper.VisionPlanBenefits oPlanBenefit = new BenefitResponseWrapper.VisionPlanBenefits();
        oPlanBenefit.benefitCategory =new list<BenefitResponseWrapper.VisionPlanBenefitCategory>{oBenefitCategory3,oBenefitCategory4,oBenefitCategory5,oBenefitCategory6};
       
        BenefitResponseWrapper.MedicalPlan oMedicalPlan = new BenefitResponseWrapper.MedicalPlan();
        oMedicalPlan.benefits = oPlanBenefits;
       
        BenefitResponseWrapper.VisionPlan oVisionPlan = new BenefitResponseWrapper.VisionPlan();
        oVisionPlan.benefits = oPlanBenefit;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.vision = oVisionPlan;
         oBenefitPlan.medical = oMedicalPlan;
        

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        oBenefitDocumentInfo.location = 'test';
        oBenefitDocumentInfo.errors = new list<BenefitResponseWrapper.ErrorInformation>();
        oBenefitDocumentInfo.data = oBenefitData;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];
        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }

        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();

        
        Benefit__c oBenefit = [Select Co_Pay_Primary_Care_Provider_INN__c,               
                               Co_Ins_Primary_Care_Provider_OON__c,Co_Pay_Specialty_Care_Provider_INN__c,
                               Co_Ins_Specialty_Care_Provider_OON__c, INN_Exam__c,               
                               INN_Single_Vision_Lens__c,INN_Bifocal_Lens__c,
                               INN_Trifocal_Lens__c, INN_Frames__c,INN_Elective_Contact_Lens__c,INN_Non_Elective_Contact_Lens__c
                               from Benefit__c
                               limit 1
                              ];

        system.assertEquals(oBenefit.Co_Pay_Primary_Care_Provider_INN__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Primary_Care_Provider_OON__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Pay_Specialty_Care_Provider_INN__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Specialty_Care_Provider_OON__c,'100',staticVariableClass.assertEquals);  
         system.assertEquals(oBenefit.INN_Exam__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Single_Vision_Lens__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Bifocal_Lens__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Trifocal_Lens__c,'100',staticVariableClass.assertEquals);    
        system.assertEquals(oBenefit.INN_Frames__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Elective_Contact_Lens__c,'100',staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.INN_Non_Elective_Contact_Lens__c,'100',staticVariableClass.assertEquals);     

    }
    
  /**
    _________________________________________________________________________________________
    @Description :This method tests about medical benefits mappings for not covered administration type
    _________________________________________________________________________________________
    **/
     @isTest
       static void medicalBenefitsNotCovered(){
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';

        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        
        BenefitResponseWrapper.MedicalPlanAdministrationType oMedicalAdminType = new BenefitResponseWrapper.MedicalPlanAdministrationType();
        oMedicalAdminType.id = StaticVariableClass.NOT_COVERED;
        oMedicalAdminType.name = StaticVariableClass.NOT_COVERED;

        BenefitResponseWrapper.MedicalPlanBenefitTier oMedicalPlanBenefitTier = new 
        BenefitResponseWrapper.MedicalPlanBenefitTier();
        oMedicalPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oMedicalPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oMedicalPlanBenefitTier.administrationType = oMedicalAdminType;

        BenefitResponseWrapper.MedicalPlanBenefitTier oMedicalPlanBenefitTier1 = new 
        BenefitResponseWrapper.MedicalPlanBenefitTier();
        oMedicalPlanBenefitTier1.id = StaticVariableClass.OUT_OF_NETWORK;
        oMedicalPlanBenefitTier1.name = StaticVariableClass.OUT_OF_NETWORK;
        oMedicalPlanBenefitTier1.administrationType = oMedicalAdminType;

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit.id = StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL;
        oMedicalPlanBenefit.name = StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL;
        oMedicalPlanBenefit.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit1 = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit1.id = StaticVariableClass.EMERGENCY_INSTITUTIONAL;
        oMedicalPlanBenefit1.name = StaticVariableClass.EMERGENCY_INSTITUTIONAL;
        oMedicalPlanBenefit1.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit2 = new BenefitResponseWrapper.MedicalPlanBenefit();
        oMedicalPlanBenefit2.id = StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL;
        oMedicalPlanBenefit2.name = StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL;
        oMedicalPlanBenefit2.tier = new List<BenefitResponseWrapper.MedicalPlanBenefitTier>{oMedicalPlanBenefitTier,oMedicalPlanBenefitTier1};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory.id = StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID;
        oBenefitCategory.name = StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID;
        oBenefitCategory.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory1 = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory1.id = StaticVariableClass.URGENT_CARE_ID;
        oBenefitCategory1.name = StaticVariableClass.URGENT_CARE_ID;
        oBenefitCategory1.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit2};

        BenefitResponseWrapper.MedicalPlanBenefitCategory oBenefitCategory2 = new BenefitResponseWrapper.MedicalPlanBenefitCategory();
        oBenefitCategory2.id = StaticVariableClass.EMERGENCY_CARE_ID;
        oBenefitCategory2.name = StaticVariableClass.EMERGENCY_CARE_ID;
        oBenefitCategory2.benefit = new list<BenefitResponseWrapper.MedicalPlanBenefit>{oMedicalPlanBenefit1};

        BenefitResponseWrapper.MedicalPlanBenefits oPlanBenefits = new BenefitResponseWrapper.MedicalPlanBenefits();
        oPlanBenefits.benefitCategory = new list<BenefitResponseWrapper.MedicalPlanBenefitCategory>{oBenefitCategory,oBenefitCategory1,oBenefitCategory2};

        BenefitResponseWrapper.MedicalPlan oMedicalPlan = new BenefitResponseWrapper.MedicalPlan();
        oMedicalPlan.benefits = oPlanBenefits;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.medical = oMedicalPlan;

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        oBenefitDocumentInfo.location = 'test';
        oBenefitDocumentInfo.errors = new list<BenefitResponseWrapper.ErrorInformation>();
        oBenefitDocumentInfo.data = oBenefitData;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];
        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }

        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();

        Benefit__c oBenefit = [Select Co_Pay_Primary_Care_Provider_INN__c,               
                               Co_Ins_Primary_Care_Provider_OON__c,Co_Pay_Specialty_Care_Provider_INN__c,
                               Co_Ins_Specialty_Care_Provider_OON__c,Co_Ins_Emergency_Room_INN__c,Co_ins_Urgent_Care_OON__c
                               from Benefit__c
                               limit 1
                              ];

        system.assertEquals(oBenefit.Co_Pay_Primary_Care_Provider_INN__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Primary_Care_Provider_OON__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Pay_Specialty_Care_Provider_INN__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Specialty_Care_Provider_OON__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_Ins_Emergency_Room_INN__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
        system.assertEquals(oBenefit.Co_ins_Urgent_Care_OON__c,StaticVariableClass.NotCvrd,staticVariableClass.assertEquals);
    }

    
      /**
    _________________________________________________________________________________________
    @Description :This method tests about vision benefit general administration mappings
    _________________________________________________________________________________________
    **/
     @isTest
    static void visionGeneralBenefitData(){
       
        //Added as per PRDCRM2-2836 to enable/disable vision benefit creation functionality 
        Vision_Benefit_Creation__c oVisionBenefitCreation =  new Vision_Benefit_Creation__c(SetupOwnerId=UserInfo.getOrganizationId(), Allow_Vision_Benefit_Creation__c=true);
        insert oVisionBenefitCreation;

        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        
        List<BenefitResponseWrapper.PlanBenefitOption> listPlanBenefitOptions = new List<BenefitResponseWrapper.PlanBenefitOption>();
        BenefitResponseWrapper.PlanBenefitOption oPlanBenefitOption;
        for(Integer iCounter=0;iCounter < 4;iCounter++){
            oPlanBenefitOption = new BenefitResponseWrapper.PlanBenefitOption();
            oPlanBenefitOption.name=StaticVariableClass.FREQUENCIES;
            oPlanBenefitOption.type=StaticVariableClass.FREQUENCIES;
            oPlanBenefitOption.boa=StaticVariableClass.FREQUENCIES;
            oPlanBenefitOption.uom=StaticVariableClass.FREQUENCIES;
            oPlanBenefitOption.benefitPeriod=StaticVariableClass.FREQUENCIES;
            oPlanBenefitOption.value = new List<String>{'90'};
                listPlanBenefitOptions.add(oPlanBenefitOption);
        }
        
        listPlanBenefitOptions[0].id=StaticVariableClass.EXAM_FREQUENCY;
        listPlanBenefitOptions[1].id=StaticVariableClass.LENS_FREQUENCY;
        listPlanBenefitOptions[2].id=StaticVariableClass.FRAMES_FREQUENCY;
        listPlanBenefitOptions[3].id=StaticVariableClass.CONTACT_LENS_FREQUENCY;
        
        BenefitResponseWrapper.PlanGeneralBenefitTier oBenefitTier = new BenefitResponseWrapper.PlanGeneralBenefitTier();
        oBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oBenefitTier.benefitOption = listPlanBenefitOptions;
        
        
        List<BenefitResponseWrapper.PlanGeneralBenefitTier> listPlanBenefitTiers = new 
            List<BenefitResponseWrapper.PlanGeneralBenefitTier>{oBenefitTier};
                
        BenefitResponseWrapper.PlanGeneralBenefit oPlanGeneralBenefit = new BenefitResponseWrapper.PlanGeneralBenefit();
        oPlanGeneralBenefit.id = StaticVariableClass.FREQUENCIES;
        oPlanGeneralBenefit.name = StaticVariableClass.FREQUENCIES;
        oPlanGeneralBenefit.tier = listPlanBenefitTiers;
        
        
        List<BenefitResponseWrapper.PlanGeneralBenefit> listPlanGeneralBenefit = new List<BenefitResponseWrapper.PlanGeneralBenefit>{oPlanGeneralBenefit};
            
        BenefitResponseWrapper.PlanGeneralAdmin oPlanAdmin = new BenefitResponseWrapper.PlanGeneralAdmin();
        oPlanAdmin.generalBenefit = listPlanGeneralBenefit;
        
        BenefitResponseWrapper.VisionPlan oVisionPlan = new BenefitResponseWrapper.VisionPlan();
        oVisionPlan.generalBasisOfAdministration = oPlanAdmin;
        
        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.vision = oVisionPlan;
        
        
        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        
        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];
        
        
        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }
        oBenefitDocumentInfo.data = oBenefitData;
        
        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};
            
        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        
        //Method called to check upsert logic
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        
        List<Benefit__c> listBenefits = [Select INN_Exam_Frequency__c,INN_Lens_Frequency__c,INN_Frame_Frequency__c,INN_Contact_Lens_Frequency__c  from Benefit__c];
        
        
        system.assertEquals(listBenefits[0].INN_Exam_Frequency__c,'90',staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].INN_Lens_Frequency__c, '90' ,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].INN_Frame_Frequency__c, '90' ,staticVariableClass.assertEquals);
        system.assertEquals(listBenefits[0].INN_Contact_Lens_Frequency__c, '90' ,staticVariableClass.assertEquals);
    }
    
 
      /**
    _________________________________________________________________________________________
    @Description :This method tests about census record creation and Checking If there is no 
                   census member record created in the system
    _________________________________________________________________________________________
    **/
     @isTest
    static  void censusmemberCheck(){
        
        ContentVersion id = [SELECT Id, Request_Tracking_ID__r.CaseID__c FROM ContentVersion Limit 1];
        string caseId = id.Request_Tracking_ID__r.CaseID__c;
        string contentVersionId= id.Id;
        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        //Creating Test Response Data
        CensusMemberResponseWrapper oCensusResponse = new CensusMemberResponseWrapper();
        Integer len = 15;
        String str = string.valueof(Math.abs(Crypto.getRandomLong()));
        String randomNumber = str.substring(0, len);
        
        oCensusResponse.transactionId=randomNumber;
        oCensusResponse.transactionTime=randomNumber;
        oCensusResponse.lobType=StaticVariableClass.Entity;
        oCensusResponse.requestId = randomNumber;
        
        CensusMemberResponseWrapper.CensusMemberData oCensusData = new CensusMemberResponseWrapper.CensusMemberData();
        CensusMemberResponseWrapper.CensusMemberPerson ocensus = new CensusMemberResponseWrapper.CensusMemberPerson();
        ocensus.firstName ='john';
        ocensus.lastName ='doe';
        ocensus.zipcode = '9000000000sxsxsh';
        ocensus.age=20;
        
        oCensusData.person = new list <CensusMemberResponseWrapper.CensusMemberPerson>{ocensus};
            
        CensusMemberResponseWrapper.CensusMemberDocumentInformation oCensusMemberDocument = new CensusMemberResponseWrapper.CensusMemberDocumentInformation();
        
        oCensusMemberDocument.context = StaticVariableClass.CENSUS;
        oCensusMemberDocument.id =ContentVersionId;
        oCensusMemberDocument.location='sfdc://caseid';
        oCensusMemberDocument.type='excel';
        oCensusMemberDocument.data =  oCensusData;
        
        oCensusResponse.document = new list <CensusMemberResponseWrapper.CensusMemberDocumentInformation>{oCensusMemberDocument};
            
        restRequest.requestBody = Blob.valueOf(JSON.serialize(oCensusResponse));
        RestContext.request = restRequest;
        
        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
              
          // checking census is getting created 
          system.assertEquals([Select Id from Census__c].size(),1,staticVariableClass.assertEquals);
          // checking census member is not getting created
          system.assertEquals([Select Id from Census_Members__c].size(),0,staticVariableClass.assertEquals);
    
    }
       /**
    _________________________________________________________________________________________
    @Description :This method tests If there is no benefits record created in the system
    _________________________________________________________________________________________
    **/
        @isTest
        static  void visionBenefitsMappings(){
        
        //Added as per PRDCRM2-2836 to enable/disable vision benefit creation functionality 
        Vision_Benefit_Creation__c oVisionBenefitCreation =  new Vision_Benefit_Creation__c(SetupOwnerId=UserInfo.getOrganizationId(), Allow_Vision_Benefit_Creation__c=true);
        insert oVisionBenefitCreation;

        RestRequest restRequest = new RestRequest();   
        restRequest.requestURI = '/services/apexrest/' + StaticVariableClass.NLP_DOCUMENT_REST_SERVICE_URL;
        restRequest.httpMethod = 'POST';
        
        BenefitResponseWrapper oBenefitResponse = new BenefitResponseWrapper();
        
        BenefitResponseWrapper.PlanBenefitOption oBenefitOption = new BenefitResponseWrapper.PlanBenefitOption();
        oBenefitOption.id = StaticVariableClass.COPAY_ID;
        oBenefitOption.name = StaticVariableClass.COPAY_ID;
        oBenefitOption.type = StaticVariableClass.COPAY_ID;
        oBenefitOption.boa = StaticVariableClass.COPAY_ID;
        oBenefitOption.uom = StaticVariableClass.COPAY_ID;
        oBenefitOption.value = new list<String>{'trr1121'};
         
        List<BenefitResponseWrapper.PlanBenefitOption> listBenefitOptions = new 
        List<BenefitResponseWrapper.PlanBenefitOption>{oBenefitOption};
          

        BenefitResponseWrapper.VisionPlanCalculation oVisionPlanCalculation = new BenefitResponseWrapper.VisionPlanCalculation();
        oVisionPlanCalculation.id = StaticVariableClass.DEFAULT_CONFIGURATION;
        oVisionPlanCalculation.name = StaticVariableClass.DEFAULT_CONFIGURATION;
        oVisionPlanCalculation.benefitOption = listBenefitOptions;
       
        List<BenefitResponseWrapper.VisionPlanCalculation> listVisionPlanCalculation = new List<BenefitResponseWrapper.VisionPlanCalculation>{oVisionPlanCalculation};
                

        BenefitResponseWrapper.VisionPlanAdministrationType oVisionAdminType = new BenefitResponseWrapper.VisionPlanAdministrationType();
        oVisionAdminType.id = StaticVariableClass.COVERED;
        oVisionAdminType.name = StaticVariableClass.COVERED;
        oVisionAdminType.calculation = listVisionPlanCalculation;
                                 

        BenefitResponseWrapper.VisionPlanBenefitTier oVisionPlanBenefitTier = new 
        BenefitResponseWrapper.VisionPlanBenefitTier();
        oVisionPlanBenefitTier.id = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.name = StaticVariableClass.IN_NETWORK;
        oVisionPlanBenefitTier.administrationType = oVisionAdminType;
                         
      
        BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit = new BenefitResponseWrapper.VisionPlanBenefit();
        oVisionPlanBenefit.id = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit.name = StaticVariableClass.BIFOCAL_LENS;
        oVisionPlanBenefit.tier = new List<BenefitResponseWrapper.VisionPlanBenefitTier>{oVisionPlanBenefitTier};
                              
        BenefitResponseWrapper.VisionPlanBenefitCategory oBenefitCategory = new BenefitResponseWrapper.VisionPlanBenefitCategory();
        oBenefitCategory.id = StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory.name =StaticVariableClass.EYEGLASS_LENSES;
        oBenefitCategory.benefit = new list<BenefitResponseWrapper.VisionPlanBenefit>{oVisionPlanBenefit};
                             
        BenefitResponseWrapper.VisionPlanBenefits oPlanBenefits = new BenefitResponseWrapper.VisionPlanBenefits();
        oPlanBenefits.benefitCategory = new list<BenefitResponseWrapper.VisionPlanBenefitCategory>{oBenefitCategory};

            
        BenefitResponseWrapper.VisionPlan oVisionPlan = new BenefitResponseWrapper.VisionPlan();
        oVisionPlan.benefits = oPlanBenefits;

        BenefitResponseWrapper.BenefitPlan oBenefitPlan = new BenefitResponseWrapper.BenefitPlan();
        oBenefitPlan.vision = oVisionPlan;

        BenefitResponseWrapper.BenefitData oBenefitData = new BenefitResponseWrapper.BenefitData();
        oBenefitData.plan = new List<BenefitResponseWrapper.BenefitPlan>{oBenefitPlan};
            
        BenefitResponseWrapper.BenefitDocumentInformation oBenefitDocumentInfo = new BenefitResponseWrapper.BenefitDocumentInformation();
        oBenefitDocumentInfo.context = StaticVariableClass.BENEFIT;
        oBenefitDocumentInfo.location = 'test';
        oBenefitDocumentInfo.errors = new list<BenefitResponseWrapper.ErrorInformation>();
        oBenefitDocumentInfo.data = oBenefitData;

        List<ContentVersion> listCV = [SELECT Id,Request_Tracking_ID__r.CaseID__c
                                       FROM ContentVersion 
                                       LIMIT 1];

        if(!listCV.isEmpty()){
            oBenefitDocumentInfo.id = listCV[0].Id;
        }

        oBenefitResponse.document = new List<BenefitResponseWrapper.BenefitDocumentInformation>{oBenefitDocumentInfo};

        restRequest.requestBody = Blob.valueOf(JSON.serialize(oBenefitResponse));
        RestContext.request = restRequest;
                                    

        test.starttest();
        NLPFileResponse_WS.parseAndPersistNLPResponse();
        test.stoptest();
        //checking if no benefit record is getting created
        system.assertEquals([Select Id from Benefit__c].size(),0,staticVariableClass.assertEquals);

            
        }

}
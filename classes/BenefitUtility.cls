/*
*******************************************************************************************
* Name          BenefitUtility 
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   29/01/2020
* UsedBy        This will be a utility class for benefit object data operations
*******************************************************************************************
*/
public with sharing class BenefitUtility{
    
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to parse NLP benefit response
    _______________________________________________________________________________________

    *@param: sNLPFileResponse - holds the benefit file response body - String
    ____________________________________________________________________________________

    *@return: Void
    _________________________________________________________________________________________
    */
    public static void parseJSONResponse(String sNLPFileResponse){
        
        try{
            //Deserializing benefit data into wrapper class
            BenefitResponseWrapper oBenefitResponse = (BenefitResponseWrapper) JSON.deserialize(sNLPFileResponse, BenefitResponseWrapper.class);
            //Calling utility class method to perist deserialized benefit response into benefit object
            persistData(oBenefitResponse,sNLPFileResponse);
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                    staticVariableClass.BENEFIT_UTILITY,StaticVariableClass.PARSE_JSON_METHOD, null, LoggingLevel.ERROR);   
        }
    }
    
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to persist NLP benefit file response into benefits object
    _______________________________________________________________________________________

    *@param: oBenefitResponse - holds the deserialized benefit file response  - BenefitResponseWrapper
    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    ____________________________________________________________________________________

    *@return: Void
    _________________________________________________________________________________________
    */
    public static void persistData(BenefitResponseWrapper oBenefitResponse,String sNLPFileResponse){
        
        try{
            List<Benefit__c> listBenefitsToUpsert = new List<Benefit__c>();
            String sContentVersionId;
            
            //Checking If there is any plan data coming from NLP response
            if(oBenefitResponse.document != null && !oBenefitResponse.document.isEmpty() &&  oBenefitResponse.document[0].data != null && oBenefitResponse.document[0].data.plan != null && !oBenefitResponse.document[0].data.plan.isEmpty()){
                Benefit__c oBenefitRecord;
                Benefit__c oVisionBenefit;
                Map<String, Schema.RecordTypeInfo> mapBenefitRecordTypes = Schema.SObjectType.Benefit__c.getRecordTypeInfosByDeveloperName(); 
                sContentVersionId = oBenefitResponse.document[0].id;
                
                for(BenefitResponseWrapper.BenefitPlan oBenefitPlan : oBenefitResponse.document[0].data.plan){
                    oBenefitRecord = new Benefit__c(Benefit_JSON_Response__c = sNLPFileResponse);
                    //Checking If there is any plan administration data coming from from NLP response
                    if(oBenefitPlan.administration != null && oBenefitPlan.administration.administrationSection != null && !oBenefitPlan.administration.administrationSection.isEmpty()){
                        //Method called to persist plan administration data into benefit object
                        persistAdministrationData(oBenefitRecord,oBenefitPlan.administration);
                    }
                    
                    // Checking If there is any medical data coming from NLP response
                    if(oBenefitPlan.medical != null && ((oBenefitPlan.medical.generalBasisOfAdministration != null && oBenefitPlan.medical.generalBasisOfAdministration.generalBenefit != null && !oBenefitPlan.medical.generalBasisOfAdministration.generalBenefit.isEmpty())|| (oBenefitPlan.medical.benefits != null && oBenefitPlan.medical.benefits.benefitCategory != null &&  !oBenefitPlan.medical.benefits.benefitCategory.isEmpty()))){
                        //Method called to persist medical plan data into benefit object
                        persistMedicalData(oBenefitRecord,oBenefitPlan.medical);

                        oBenefitRecord.RecordTypeId = mapBenefitRecordTypes.containsKey(StaticVariableClass.BENEFIT_MEDICAL_RT_NAME) ? mapBenefitRecordTypes.get(StaticVariableClass.BENEFIT_MEDICAL_RT_NAME).getRecordTypeId() : null;
                    } 
                    // Checking If vision benefit creation is enabled and there is any vision data coming from NLP response
                   if(Vision_Benefit_Creation__c.getOrgDefaults() != null && Vision_Benefit_Creation__c.getOrgDefaults().Allow_Vision_Benefit_Creation__c && oBenefitPlan.vision != null && ((oBenefitPlan.vision.generalBasisOfAdministration != null && oBenefitPlan.vision.generalBasisOfAdministration.generalBenefit != null && !oBenefitPlan.vision.generalBasisOfAdministration.generalBenefit.isEmpty())|| (oBenefitPlan.vision.benefits != null && oBenefitPlan.vision.benefits.benefitCategory != null &&  !oBenefitPlan.vision.benefits.benefitCategory.isEmpty()))){
                        if(oBenefitRecord.RecordTypeId == null){
                            oBenefitRecord = persistVisionData(oBenefitRecord,oBenefitPlan.vision);
                            oBenefitRecord.RecordTypeId = mapBenefitRecordTypes.containsKey(StaticVariableClass.BENEFIT_VISION_RT_NAME) ? mapBenefitRecordTypes.get(StaticVariableClass.BENEFIT_VISION_RT_NAME).getRecordTypeId() : null;
                        }
                        
                       else{
                            oVisionBenefit = oBenefitRecord.clone();
                            oVisionBenefit = persistVisionData(oVisionBenefit,oBenefitPlan.vision);
                            oVisionBenefit.RecordTypeId = mapBenefitRecordTypes.containsKey(StaticVariableClass.BENEFIT_VISION_RT_NAME) ? mapBenefitRecordTypes.get(StaticVariableClass.BENEFIT_VISION_RT_NAME).getRecordTypeId() : null;
                            listBenefitsToUpsert.add(oVisionBenefit);
                       }
                       
                    }
                    listBenefitsToUpsert.add(oBenefitRecord);
                }
            }
            else{
                listBenefitsToUpsert.add(new Benefit__c(Benefit_JSON_Response__c = sNLPFileResponse));
            }
            
            if(!listBenefitsToUpsert.isEmpty()){
                //Method called to upsert medical and vision benefits data based on plan name + competitor name 
                upsertBenefitData(sContentVersionId,listBenefitsToUpsert);
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.BENEFIT_UTILITY,StaticVariableClass.PERSIST_JSON_METHOD, null, LoggingLevel.ERROR);
        }
    }
    
    /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to persist NLP plan administration data into benefits object
    _______________________________________________________________________________________

    *@param: oPlanAdministration - holds the benefit plan administration data  - BenefitResponseWrapper.PlanAdministration
    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    ____________________________________________________________________________________
    
    *@return: void
    _________________________________________________________________________________________
    */
    private static void persistAdministrationData(Benefit__c oBenefitRecord,BenefitResponseWrapper.PlanAdministration oPlanAdministration){
        try{
            String sPlanAdminOptionValue;
            for(BenefitResponseWrapper.PlanAdminSection oPlanAdminSection : oPlanAdministration.administrationSection){
                //Checking If it is plan Information section
                if(oPlanAdminSection.id != null && oPlanAdminSection.id.trim() == StaticVariableClass.PLAN_INFORMATION){
                    if(oPlanAdminSection.adminOption != null && !oPlanAdminSection.adminOption.isEmpty()){
                        for(BenefitResponseWrapper.PlanAdminOption oPlanAdminOption : oPlanAdminSection.adminOption){
                            sPlanAdminOptionValue = ((oPlanAdminOption.value != null && !oPlanAdminOption.value.isEmpty() && String.isNotEmpty(oPlanAdminOption.value[0].trim())) ? oPlanAdminOption.value[0] : null);

                            //If it is plan name
                            if(oPlanAdminOption.id != null && oPlanAdminOption.id.trim() == StaticVariableClass.PLAN_NAME)
                                oBenefitRecord.Plan_Name__c = sPlanAdminOptionValue;
                            //If it is payer name       
                            else if(oPlanAdminOption.id != null && oPlanAdminOption.id.trim() == StaticVariableClass.PAYER_NAME)
                                oBenefitRecord.Competitor_Name__c = sPlanAdminOptionValue;
                            //If it is product family       
                            else if(oPlanAdminOption.id != null && oPlanAdminOption.id.trim() == StaticVariableClass.PRODUCT_FAMILY_ID)
                                oBenefitRecord.Product_Family__c = sPlanAdminOptionValue;       
                        }   
                    }
                    break;
                } 
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.BENEFIT_UTILITY, StaticVariableClass.PERSIST_ADMIN_DATA_METHOD, null, LoggingLevel.ERROR);
        }
    }
    
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to persist benefit medical plan data into benefits object
    _______________________________________________________________________________________

    *@param: oMedicalPlan - holds the benefit medical plan data received from NLP - BenefitResponseWrapper.MedicalPlan
    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    ____________________________________________________________________________________

    *@return: void
    _________________________________________________________________________________________
    */
    private static void persistMedicalData(Benefit__c oBenefitRecord,BenefitResponseWrapper.MedicalPlan oMedicalPlan){
        try{
            
            //Checking If there is any medical plan general administration data coming from NLP response
            if(oMedicalPlan.generalBasisOfAdministration != null && oMedicalPlan.generalBasisOfAdministration.generalBenefit != null && !oMedicalPlan.generalBasisOfAdministration.generalBenefit.isEmpty()){
                //Method called to persist medical general administration data into benefits object
                persistMedicalGeneralBenefitData(oBenefitRecord,oMedicalPlan.generalBasisOfAdministration);
            }
            
            //Checking If there is any medical plan benefits data coming from NLP response
            if(oMedicalPlan.benefits != null && oMedicalPlan.benefits.benefitCategory != null && !oMedicalPlan.benefits.benefitCategory.isEmpty()){
                persistMedicalBenefitsData(oBenefitRecord,oMedicalPlan.benefits);
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                    staticVariableClass.BENEFIT_UTILITY, StaticVariableClass.PERSIST_MEDICAL_DATA_METHOD, null, LoggingLevel.ERROR);
        }
    }
    
    /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to persist NLP medical plan general benefit data into benefits object
    _______________________________________________________________________________________

    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    *@param: oPlanGeneralAdmin - holds the benefit medical plan administration data received from NLP - BenefitResponseWrapper.PlanGeneralAdmin 
    ____________________________________________________________________________________
    
    *@return: void
    _________________________________________________________________________________________
    */
    private static void persistMedicalGeneralBenefitData(Benefit__c oBenefitRecord,BenefitResponseWrapper.PlanGeneralAdmin oPlanGeneralAdmin){

        try{
            Decimal dcBenefitOptionValue;
            //Parsing through NLP response JSON structure to read the data
            for(BenefitResponseWrapper.PlanGeneralBenefit oPlanGeneralBenefit : oPlanGeneralAdmin.generalBenefit){
                if(oPlanGeneralBenefit.id != null && oPlanGeneralBenefit.tier != null && !oPlanGeneralBenefit.tier.isEmpty()){
                    for(BenefitResponseWrapper.PlanGeneralBenefitTier oPlanBenefitTier : oPlanGeneralBenefit.tier){
                        if(oPlanBenefitTier.benefitOption != null && !oPlanBenefitTier.benefitOption.isEmpty()){
                            for(BenefitResponseWrapper.PlanBenefitOption oPlanBenefitOption: oPlanBenefitTier.benefitOption){
                                dcBenefitOptionValue = ((oPlanBenefitOption.value != null && !oPlanBenefitOption.value.isEmpty() && String.isNotEmpty(oPlanBenefitOption.value[0].trim()) && oPlanBenefitOption.value[0] != StaticVariableClass.NOT_APPLICABLE) ? Decimal.valueOf(oPlanBenefitOption.value[0]) : null);
                                
                                //CoInsurance field mappings
                                if(oPlanGeneralBenefit.Id != null && oPlanGeneralBenefit.Id.trim() == StaticVariableClass.CO_INSURANCE && oPlanBenefitOption.id != null && oPlanBenefitOption.id.trim() == StaticVariableClass.PLAN_CO_INSURANCE){
                                    mapInAndOutNetworkBenefitFields(oBenefitRecord,oPlanBenefitTier.id,'In_Network_Coinsurance__c','Out_of_Network_Coinsurance__c',dcBenefitOptionValue);
                                }
                                //Deductible Individual mappings
                                else if(oPlanGeneralBenefit.Id != null && oPlanGeneralBenefit.id.trim() == StaticVariableClass.DEDUCTIBLE && oPlanBenefitOption.id != null && oPlanBenefitOption.id.trim() ==  StaticVariableClass.DEDUCTIBLE_INDIVIDUAL){      
                                    mapInAndOutNetworkBenefitFields(oBenefitRecord,oPlanBenefitTier.id,'In_Network_Deductible_Single__c','Out_of_Network_Deductible_Single__c',dcBenefitOptionValue);
                                }
                                //Deductible Family mappings
                                else if(oPlanGeneralBenefit.id != null && oPlanGeneralBenefit.id.trim() == StaticVariableClass.DEDUCTIBLE && oPlanBenefitOption.id != null && oPlanBenefitOption.id.trim() == StaticVariableClass.DEDUCTIBLE_FAMILY){       
                                    mapInAndOutNetworkBenefitFields(oBenefitRecord,oPlanBenefitTier.id,'In_Network_Deductible_Family__c','Out_of_Network_Deductible_Family__c',dcBenefitOptionValue);
                                }
                                //Out Of Pocket Individual field mappings
                                else if(oPlanGeneralBenefit.id != null && oPlanGeneralBenefit.id.trim() == StaticVariableClass.OUT_OF_POCKET && oPlanBenefitOption.id != null && oPlanBenefitOption.id.trim() == StaticVariableClass.OOP_MAX_INDIVIDUAL){
                                    mapInAndOutNetworkBenefitFields(oBenefitRecord,oPlanBenefitTier.id,'In_Network_Out_of_Pocket_Max_Single__c','OON_Out_of_Pocket_Max_Single__c',dcBenefitOptionValue);
                                }
                                //Out Of Pocket Family field mappings
                                else if(oPlanGeneralBenefit.id != null && oPlanGeneralBenefit.id.trim() == StaticVariableClass.OUT_OF_POCKET && oPlanBenefitOption.id != null && oPlanBenefitOption.id.trim() == StaticVariableClass.OOP_MAX_FAMILY){
                                    mapInAndOutNetworkBenefitFields(oBenefitRecord,oPlanBenefitTier.id,'In_Network_Out_of_Pocket_Max_Family__c','OON_Out_of_Pocket_Max_Family__c',dcBenefitOptionValue);
                                }
                            }
                        }
                    }
                }
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.BENEFIT_UTILITY,StaticVariableClass.PERSIST_MEDICAL_GENERAL_BENEFIT_METHOD, null, LoggingLevel.ERROR);
        }
    }
   
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to persist medical benefits data into benefits object
    _______________________________________________________________________________________

    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    *@param: oPlanBenefit - holds the medical plan benefits data received from NLP - BenefitResponseWrapper.MedicalPlanBenefits 
    ____________________________________________________________________________________

    *@return: void
    _________________________________________________________________________________________
    */
    private static void persistMedicalBenefitsData(Benefit__c oBenefitRecord,BenefitResponseWrapper.MedicalPlanBenefits oPlanBenefit){
    try{
      String sBenefitOptionValue;

      for(BenefitResponseWrapper.MedicalPlanBenefitCategory oPlanBenefitCategory : oPlanBenefit.benefitCategory){
        if(oPlanBenefitCategory.id != null && (oPlanBenefitCategory.id.trim() == StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID || oPlanBenefitCategory.id.trim() == StaticVariableClass.EMERGENCY_CARE_ID || oPlanBenefitCategory.id.trim() == StaticVariableClass.URGENT_CARE_ID)){
          //Checking If there are any benefits under benefit category
          if(oPlanBenefitCategory.benefit != null && !oPlanBenefitCategory.benefit.isEmpty()){
            //Parsing through NLP response JSON structure to read the data
            for(BenefitResponseWrapper.MedicalPlanBenefit oMedicalPlanBenefit : oPlanBenefitCategory.benefit){
              //Checking If there are any tiers under benefits
              if(oMedicalPlanBenefit.tier != null && !oMedicalPlanBenefit.tier.isEmpty()){
                for(BenefitResponseWrapper.MedicalPlanBenefitTier oPlanBenefitTier : oMedicalPlanBenefit.tier){
                  //Checking If there is any administration type under tiers
                  if(oPlanBenefitTier.administrationType != null && oPlanBenefitTier.administrationType.id != null){
                    administrationTypeMapping(oBenefitRecord,oPlanBenefitCategory.Id,oMedicalPlanBenefit.Id,oPlanBenefitTier.Id,oPlanBenefitTier.administrationType.id,oPlanBenefitTier.administrationType);
                  }
                }  
              }
            }
          }
        }
      }
    }
    catch(Exception excn){
      //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.BENEFIT_UTILITY, StaticVariableClass.PERSIST_MEDICAL_BENEFITS_METHOD, null, LoggingLevel.ERROR);
    }
    }
    
    /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to map benefit fields based on different administrationType mappings(Covered - PCP and SPC Copay Sep,Covered,Not Covered)
    _______________________________________________________________________________________

  *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
  *@param: sBenefitCategoryId - holds benefitCategory Id of NLP JSON response - String
  *@param: sBenefitId - holds benefit Id of NLP JSON response - String
  *@param: sTierId - holds benefit Id of NLP JSON response - String
  *@param: sAdministrationTypeId - holds administrationType Id of NLP JSON response - String
  *@param: oMedicalPlanAdminType - holds the administrationType node from NLP response - MedicalPlanAdministrationType
    ____________________________________________________________________________________
    
    *@return: void
    _________________________________________________________________________________________
    */
  private static void administrationTypeMapping(Benefit__c oBenefitRecord,String sBenefitCategoryId,String sBenefitId,String sTierId,String sAdministrationTypeId,BenefitResponseWrapper.MedicalPlanAdministrationType oMedicalPlanAdminType){
    try{
      //If administration type is not covered
      if(sAdministrationTypeId == StaticVariableClass.NOT_COVERED){
        //Professional Physician Services
        if(sBenefitCategoryId == StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID && sBenefitId == StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL){
          if(sTierId == StaticVariableClass.IN_NETWORK){
            oBenefitRecord.Co_Pay_Primary_Care_Provider_INN__c = StaticVariableClass.NotCvrd;
            oBenefitRecord.Co_Pay_Specialty_Care_Provider_INN__c = StaticVariableClass.NotCvrd;
          }  
          else if(sTierId == StaticVariableClass.OUT_OF_NETWORK){
            oBenefitRecord.Co_Ins_Primary_Care_Provider_OON__c = StaticVariableClass.NotCvrd;
            oBenefitRecord.Co_Ins_Specialty_Care_Provider_OON__c = StaticVariableClass.NotCvrd;
          }  
        }
        //Emergency Care Services
        else if(sBenefitCategoryId == StaticVariableClass.EMERGENCY_CARE_ID && sBenefitId == StaticVariableClass.EMERGENCY_INSTITUTIONAL && sTierId == StaticVariableClass.IN_NETWORK){
          oBenefitRecord.Co_Pay_Emergency_Room_INN__c = StaticVariableClass.NotCvrd;
          oBenefitRecord.Co_Ins_Emergency_Room_INN__c = StaticVariableClass.NotCvrd;
        }
        //Urgent Care Services
        else if(sBenefitCategoryId == StaticVariableClass.URGENT_CARE_ID && sBenefitId == StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL){
          if(sTierId == StaticVariableClass.IN_NETWORK)
            oBenefitRecord.Co_Pay_Urgent_Care_INN__c = StaticVariableClass.NotCvrd;
          else if(sTierId == StaticVariableClass.OUT_OF_NETWORK)
            oBenefitRecord.Co_ins_Urgent_Care_OON__c = StaticVariableClass.NotCvrd;
        }
      }    
      else if(sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION || sAdministrationTypeId == StaticVariableClass.COVERED){
        if(oMedicalPlanAdminType.calculation != null && !oMedicalPlanAdminType.calculation.isEmpty()){
          String sBenefitOptionValue;
          for(BenefitResponseWrapper.MedicalPlanCalculation oPlanCalculation : oMedicalPlanAdminType.calculation){
            if(oPlanCalculation.benefitOption != null && !oPlanCalculation.benefitOption.isEmpty()){
              for(BenefitResponseWrapper.PlanBenefitOption oPlanBenefitOption : oPlanCalculation.benefitOption){
                sBenefitOptionValue = ((oPlanBenefitOption.value != null && !oPlanBenefitOption.value.isEmpty() && String.isNotEmpty(oPlanBenefitOption.value[0].trim())) ? oPlanBenefitOption.value[0] : null);
                //Copay Fields
                if(oPlanBenefitOption.Id == StaticVariableClass.COPAY_ID && sTierId == StaticVariableClass.IN_NETWORK){
                  if(sBenefitCategoryId == StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID && sBenefitId == StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL){
                    if((sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.PCP_CONFIG) || (sAdministrationTypeId == StaticVariableClass.COVERED && oPlanCalculation.Id == StaticVariableClass.DEFAULT_CONFIGURATION))
                      oBenefitRecord.Co_Pay_Primary_Care_Provider_INN__c = sBenefitOptionValue;
                    else if(sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.SPC_CONFIG)  
                      oBenefitRecord.Co_Pay_Specialty_Care_Provider_INN__c = sBenefitOptionValue;
                  }  
                  else if(sBenefitCategoryId == StaticVariableClass.EMERGENCY_CARE_ID && sBenefitId == StaticVariableClass.EMERGENCY_INSTITUTIONAL && ((sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.PCP_CONFIG) || (sAdministrationTypeId == StaticVariableClass.COVERED && oPlanCalculation.Id == StaticVariableClass.DEFAULT_CONFIGURATION))){
                    oBenefitRecord.Co_Pay_Emergency_Room_INN__c = sBenefitOptionValue;
                  }
                  else if(sBenefitCategoryId == StaticVariableClass.URGENT_CARE_ID && sBenefitId == StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL && ((sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.PCP_CONFIG) || (sAdministrationTypeId == StaticVariableClass.COVERED && oPlanCalculation.Id == StaticVariableClass.DEFAULT_CONFIGURATION))){
                    oBenefitRecord.Co_Pay_Urgent_Care_INN__c = sBenefitOptionValue;
                  }
                }
                //CoInsurance fields
                else if(oPlanBenefitOption.Id == StaticVariableClass.COVERED_AT_ID){
                  if(sBenefitCategoryId == StaticVariableClass.PROFESSIONAL_PHYSICIAN_SERVICES_ID && sBenefitId == StaticVariableClass.OFFICE_VISIT_OFFICE_PROFESSIONAL && sTierId == StaticVariableClass.OUT_OF_NETWORK){
                    if((sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.PCP_CONFIG) || (sAdministrationTypeId == StaticVariableClass.COVERED && oPlanCalculation.Id == StaticVariableClass.DEFAULT_CONFIGURATION))
                      oBenefitRecord.Co_Ins_Primary_Care_Provider_OON__c = sBenefitOptionValue;
                    else if(sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.SPC_CONFIG)  
                      oBenefitRecord.Co_Ins_Specialty_Care_Provider_OON__c = sBenefitOptionValue;
                  }  
                  else if(sBenefitCategoryId == StaticVariableClass.EMERGENCY_CARE_ID && sBenefitId == StaticVariableClass.EMERGENCY_INSTITUTIONAL && sTierId == StaticVariableClass.IN_NETWORK && ((sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.PCP_CONFIG) || (sAdministrationTypeId == StaticVariableClass.COVERED && oPlanCalculation.Id == StaticVariableClass.DEFAULT_CONFIGURATION))){
                    oBenefitRecord.Co_Ins_Emergency_Room_INN__c = sBenefitOptionValue;
                  }
                  else if(sBenefitCategoryId == StaticVariableClass.URGENT_CARE_ID && sBenefitId == StaticVariableClass.URGENT_CARE_OP_INSTITUTIONAL && sTierId == StaticVariableClass.OUT_OF_NETWORK && ((sAdministrationTypeId == StaticVariableClass.COVERED_PCP_SPC_SEPARATION && oPlanCalculation.Id == StaticVariableClass.PCP_CONFIG) || (sAdministrationTypeId == StaticVariableClass.COVERED && oPlanCalculation.Id == StaticVariableClass.DEFAULT_CONFIGURATION))){
                    oBenefitRecord.Co_ins_Urgent_Care_OON__c = sBenefitOptionValue;
                  }
                }
              }
            }
          }
        }
      }
    }
    catch(Exception excn){
      //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
            StaticVariableClass.BENEFIT_UTILITY, StaticVariableClass.ADMIN_TYPE_MAPPING, null, LoggingLevel.ERROR);
    }
    }
    
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to persist benefit vision plan data into benefits object
    _______________________________________________________________________________________

    *@param: oVisionPlan - holds the benefit vision plan data received from NLP - BenefitResponseWrapper.VisionPlan
    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    ____________________________________________________________________________________

    *@return: Benefit__c object record
    _________________________________________________________________________________________
    */
    private static Benefit__c persistVisionData(Benefit__c oVisionBenefit,BenefitResponseWrapper.VisionPlan oVisionPlan){
        try{
            //Checking If there is any vision plan general administration data coming from NLP response
            if(oVisionPlan.generalBasisOfAdministration != null && oVisionPlan.generalBasisOfAdministration.generalBenefit != null && !oVisionPlan.generalBasisOfAdministration.generalBenefit.isEmpty()){
                //Method called to persist vision general administration data into benefits object
                 persistVisionGeneralBenefitData(oVisionBenefit,oVisionPlan.generalBasisOfAdministration);
            }
            
            //Checking If there is any vision plan benefits data coming from NLP response
            if(oVisionPlan.benefits != null && oVisionPlan.benefits.benefitCategory != null && !oVisionPlan.benefits.benefitCategory.isEmpty()){
                //Method called to persist vision benefits data inot benefit object
                persistVisionBenefitsData(oVisionBenefit,oVisionPlan.benefits);
                
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                    staticVariableClass.BENEFIT_UTILITY, StaticVariableClass.PERSIST_VISION_DATA_METHOD, null, LoggingLevel.ERROR);
        }
        return oVisionBenefit;
    }
    
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to persist NLP vision plan general benefit data into benefits object
    _______________________________________________________________________________________

    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    *@param: oPlanGeneralAdmin - holds the benefit vision plan administration data received from NLP - BenefitResponseWrapper.PlanGeneralAdmin 
    ____________________________________________________________________________________

    *@return: Benefit__c object record
    _________________________________________________________________________________________
    */
    private static Benefit__c persistVisionGeneralBenefitData(Benefit__c oVisionBenefit,BenefitResponseWrapper.PlanGeneralAdmin oPlanGeneralAdmin){
        
        try{
            String sBenefitOptionValue;
            //Parsing through NLP response JSON structure to read the data
            for(BenefitResponseWrapper.PlanGeneralBenefit oPlanGeneralBenefit : oPlanGeneralAdmin.generalBenefit){
                if(oPlanGeneralBenefit.id != null &&  oPlanGeneralBenefit.Id.trim() == StaticVariableClass.FREQUENCIES && oPlanGeneralBenefit.tier != null  &&!oPlanGeneralBenefit.tier.isEmpty()){
                   for(BenefitResponseWrapper.PlanGeneralBenefitTier oPlanBenefitTier : oPlanGeneralBenefit.tier){
                        if( oPlanBenefitTier.id !=null && oPlanBenefitTier.ID.trim() == StaticVariableClass.IN_NETWORK  && oPlanBenefitTier.benefitOption != null && !oPlanBenefitTier.benefitOption.isEmpty()){
                            for(BenefitResponseWrapper.PlanBenefitOption oPlanBenefitOption: oPlanBenefitTier.benefitOption){
                                sBenefitOptionValue = ((oPlanBenefitOption.value != null && !oPlanBenefitOption.value.isEmpty() && String.isNotEmpty(oPlanBenefitOption.value[0].trim())) ? String.valueOf(oPlanBenefitOption.value[0]) : null);
                                if( oPlanBenefitOption.id.trim() == StaticVariableClass.EXAM_FREQUENCY){
                                oVisionBenefit.INN_Exam_Frequency__c = sBenefitOptionValue;
                                }
                               else if( oPlanBenefitOption.id.trim() == StaticVariableClass.LENS_FREQUENCY){
                                    oVisionBenefit.INN_Lens_Frequency__c = sBenefitOptionValue;

                                }
                                else if( oPlanBenefitOption.id.trim() == StaticVariableClass.FRAMES_FREQUENCY){
                                    oVisionBenefit.INN_Frame_Frequency__c =sBenefitOptionValue;
                                }
                                else if( oPlanBenefitOption.id.trim() == StaticVariableClass.CONTACT_LENS_FREQUENCY){
                                    oVisionBenefit.INN_Contact_Lens_Frequency__c = sBenefitOptionValue;

                                }
                            }

                        }
                    } 
                }   
            }  
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.BENEFIT_UTILITY,StaticVariableClass.PERSIST_VISION_GENERAL_BENEFIT_METHOD, null, LoggingLevel.ERROR);
        }
               

        return oVisionBenefit;
        
    }
    
       
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to persist vision benefits data into benefits object
    _______________________________________________________________________________________

    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    *@param: oPlanBenefit - holds the vision plan benefits data received from NLP - BenefitResponseWrapper.MedicalPlanBenefits 
    ____________________________________________________________________________________

    *@return: Benefit__c object record
    _________________________________________________________________________________________
    */
     private static Benefit__c persistVisionBenefitsData(Benefit__c oVisionBenefit,BenefitResponseWrapper.VisionPlanBenefits oPlanBenefit){
        try{
            String sBenefitOptionValue;
            
            for(BenefitResponseWrapper.VisionPlanBenefitCategory oPlanBenefitCategory : oPlanBenefit.benefitCategory){
                
                if(oPlanBenefitCategory.id != null && (oPlanBenefitCategory.id.trim() == StaticVariableClass.EXAM || oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES || oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_FRAMES ||   oPlanBenefitCategory.id.trim() == StaticVariableClass.CONTACT_LENSES )){
                    //Checking If there are any benefits under benefit category
                    if(oPlanBenefitCategory.benefit != null && !oPlanBenefitCategory.benefit.isEmpty()){
                        //Parsing through NLP response JSON structure to read the data
                        for(BenefitResponseWrapper.VisionPlanBenefit oVisionPlanBenefit : oPlanBenefitCategory.benefit){
                            //Checking If there are any tiers under benefits
                            if(oVisionPlanBenefit.tier != null && !oVisionPlanBenefit.tier.isEmpty()){
                                for(BenefitResponseWrapper.VisionPlanBenefitTier oPlanBenefitTier : oVisionPlanBenefit.tier){
                                    //Checking If there are any administration types under tiers
                                    if(oPlanBenefitTier.administrationType != null && oPlanBenefitTier.administrationType.calculation != null && !oPlanBenefitTier.administrationType.calculation.isEmpty()){
                                        for(BenefitResponseWrapper.VisionPlanCalculation oPlanCalculation : oPlanBenefitTier.administrationType.calculation){
                                            //Checking If there are any benefit options under calculation
                                           
                                            if(oPlanCalculation.benefitOption != null && !oPlanCalculation.benefitOption.isEmpty()){
                                                for(BenefitResponseWrapper.PlanBenefitOption oPlanBenefitOption : oPlanCalculation.benefitOption){
                                                    sBenefitOptionValue = ((oPlanBenefitOption.value != null && !oPlanBenefitOption.value.isEmpty() && String.isNotEmpty(oPlanBenefitOption.value[0].trim())) ? oPlanBenefitOption.value[0] : null);
                                                   
                                                    if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EXAM &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.EYE_EXAM && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK  ){
                                                        if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID ) 
                                                         oVisionBenefit.INN_Exam__c = sBenefitOptionValue;   
                                                        }
                                                                 
                                                         
                                                    else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.SINGLR_VISION_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK  ){
                                                           if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID ) 
                                                               oVisionBenefit.INN_Single_Vision_Lens__c = sBenefitOptionValue;
                                                               }
                                                     
                                                    else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.BIFOCAL_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                            if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID ) 
                                                               oVisionBenefit.INN_Bifocal_Lens__c = sBenefitOptionValue;
                                                           }
                                                    else if (oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.TRIFOCAL_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                        if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID ) 
                                                               oVisionBenefit.INN_Trifocal_Lens__c = sBenefitOptionValue;
                                                    }
                                                    
                                                    else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_FRAMES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.FRAMES && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                         if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID ) 
                                                               oVisionBenefit.INN_Frames__c = sBenefitOptionValue;
                                                    }
                                                    else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.CONTACT_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK){
                                                         if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID ) 
                                                               oVisionBenefit.INN_Elective_Contact_Lens__c = sBenefitOptionValue;
                                                    }
                                                    
                                                    else if (oPlanBenefitCategory.id.trim() == StaticVariableClass.CONTACT_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                        if(oPlanBenefitTier.administrationType.id == StaticVariableClass.COVERED && oPlanCalculation.id.trim() == StaticVariableClass.DEFAULT_CONFIGURATION && oPlanBenefitOption.id.trim()==StaticVariableClass.COPAY_ID )
                                                            oVisionBenefit.INN_Non_Elective_Contact_Lens__c = sBenefitOptionValue;
                                                    }
                                                    
                                                        }
                                                }
                                            }
                                        }
                                    else {
                                      if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EXAM &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.EYE_EXAM && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK  ){
                                         if (oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                             oVisionBenefit.INN_Exam__c = StaticVariableClass.NotCvrd;
                                      }
                                      
                                         else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.SINGLR_VISION_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK  ){
                                              if (oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                                 oVisionBenefit.INN_Single_Vision_Lens__c = StaticVariableClass.NotCvrd;                                            
                                        }
                                             else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.BIFOCAL_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                  if (oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                                      oVisionBenefit.INN_Bifocal_Lens__c = StaticVariableClass.NotCvrd;
                                        }
                                        
                                                else  if (oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.TRIFOCAL_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                      if (oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                                         oVisionBenefit.INN_Trifocal_Lens__c = StaticVariableClass.NotCvrd;
                                        }
                                                     else  if(oPlanBenefitCategory.id.trim() == StaticVariableClass.EYEGLASS_FRAMES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.FRAMES && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                           if (oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                                              oVisionBenefit.INN_Frames__c = StaticVariableClass.NotCvrd;  
                                        }
                                        
                                                          else if(oPlanBenefitCategory.id.trim() == StaticVariableClass.CONTACT_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.ELECTIVE_CONVENTIONAL_CONTACT_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                               if(oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                                                oVisionBenefit.INN_Elective_Contact_Lens__c = StaticVariableClass.NotCvrd;
                                        }
                                        
                                                              else if (oPlanBenefitCategory.id.trim() == StaticVariableClass.CONTACT_LENSES &&  oVisionPlanBenefit.id.trim() == StaticVariableClass.NON_ELECTIVE_CONVENTIONAL_CONTACT_LENS && oPlanBenefitTier.id.trim() == StaticVariableClass.IN_NETWORK ){
                                                                   if(oPlanBenefitTier.administrationType.id == StaticVariableClass.NOT_COVERED)
                                                                    oVisionBenefit.INN_Non_Elective_Contact_Lens__c = StaticVariableClass.NotCvrd;
                                                         
                                        }

                                        
                                    }
                                    }
                                }   
                            }
                        }
                    }
                }
            }
        
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), StaticVariableClass.NLP_APP_NAME,
                                                    StaticVariableClass.BENEFIT_UTILITY, StaticVariableClass.PERSIST_MEDICAL_BENEFITS_METHOD, null, LoggingLevel.ERROR);
        }
      
        return oVisionBenefit;
    }

    
    
    /*
    _________________________________________________________________________________________

    *@description: This method will be used to map In-Network and Out-of-Network benefit fields
    _______________________________________________________________________________________

    *@param: oBenefitRecord - holds the benefit object record in which data needs to be persisted - Benefit__c
    *@param: sBenefitTierId - holds In-Network Or Out-Of-Network - String
    *@param: sInNetworkFieldName - holds the benefit object field name in which data needs to be persisted if benefit tier Id is In-Network - String
    *@param: sOutOfNetworkFieldName - holds the benefit object field name in which data needs to be persisted if benefit tier Id is Out-Of-Network - String
    *@param: dcBenefitOptionValue - holds the benefit option value - Decimal
    ____________________________________________________________________________________

    *@return: void
    _________________________________________________________________________________________
    */
    private static void mapInAndOutNetworkBenefitFields(Benefit__c oBenefitRecord,String sBenefitTierId,String sInNetworkFieldName,String sOutOfNetworkFieldName,Decimal dcBenefitOptionValue){
        try{
            if(sBenefitTierId !=null && sBenefitTierId.trim() == StaticVariableClass.IN_NETWORK){
                oBenefitRecord.put(sInNetworkFieldName,dcBenefitOptionValue);
            }
            else if(sBenefitTierId !=null && sBenefitTierId.trim() == StaticVariableClass.OUT_OF_NETWORK){
                oBenefitRecord.put(sOutOfNetworkFieldName,dcBenefitOptionValue);
            }
        }
        catch(Exception excn){
            //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
                                                    staticVariableClass.BENEFIT_UTILITY,StaticVariableClass.MAP_NETWORK_FIELDS_METHOD, null, LoggingLevel.ERROR);
        }
    }
    
  /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to upsert benefits data based on plan name + competitor name
    _______________________________________________________________________________________

  *@param: contentVersionID - holds the content version Id which was sent to NLP - Id
  *@param: listBenefitsToUpsert - holds the list of benefit records to be upserted based on NLP response- list<Benefit__c>
    ____________________________________________________________________________________
    
    *@return: void
    _________________________________________________________________________________________
    */
  private static void upsertBenefitData(String sContentVersionId,list<Benefit__c> listBenefitsToUpsert){

    try{
      List<ContentVersion> listContentVersion = [Select Id,
                             Request_Tracking_ID__r.CaseID__c,Request_Tracking_ID__r.CaseID__r.Opportunity__c
                             From ContentVersion
                             Where Id =:(sContentVersionId != null ? sContentVersionId.trim() : sContentVersionId)];
      
      //Checking If there is any case associated with request tracking
      if(!listContentVersion.isEmpty() && listContentVersion[0].Request_Tracking_ID__r.CaseID__c != null){
        
        map<String,Id> mapExistingBenefitsForCase = new map<String,Id>();
        List<Benefit__c> listFinalBenefitsToUpsert = new List<Benefit__c>();
  
        //Set to avoid duplicate benefits with same plan name + competitor name which are coming from NLP response
        set<String> setExistingCombinationBenefits = new set<String>();
        String sBenefitUniqueCombination;
        String sDocumentURL = System.URL.getSalesforceBaseURL().toExternalForm()+'/' + sContentVersionId;

        Map<String, Schema.RecordTypeInfo> mapBenefitRecordTypes = Schema.SObjectType.Benefit__c.getRecordTypeInfosByDeveloperName(); 
        
        //Counters required to update plan and competitor names If they are coming blank in NLP response
        Integer iTempPlanNameCount = 0;
        Integer iTempCompetitorNameCount = 0;
        
        //Querying existing benefits for case to upsert benefits data
        for(Benefit__c oBenefit : [Select Id,Plan_Name__c,Competitor_Name__c,RecordTypeId                
                       from Benefit__c
                       where Case__c =:listContentVersion[0].Request_Tracking_ID__r.CaseID__c]){
          
          if(oBenefit.Plan_Name__c != null && oBenefit.Plan_Name__c.startsWithIgnoreCase(StaticVariableClass.TEMP_PLAN_NAME)){
            iTempPlanNameCount++;
          }
          if(oBenefit.Competitor_Name__c != null && oBenefit.Competitor_Name__c.startsWithIgnoreCase(StaticVariableClass.TEMP_COMPETITOR_NAME)){
            iTempCompetitorNameCount++;
          }
          mapExistingBenefitsForCase.put((oBenefit.Plan_Name__c != null ? oBenefit.Plan_Name__c.toLowerCase() : '') + '_' + (oBenefit.Competitor_Name__c != null ? oBenefit.Competitor_Name__c.toLowerCase() : '') + '_' + oBenefit.RecordTypeId,oBenefit.Id);
        }

        for(Benefit__c oBenefitToUpsert : listBenefitsToUpsert){
  
          oBenefitToUpsert.Case__c = listContentVersion[0].Request_Tracking_ID__r.CaseID__c;
          oBenefitToUpsert.Opportunity__c = listContentVersion[0].Request_Tracking_ID__r.CaseID__r.Opportunity__c;
          oBenefitToUpsert.Document_Link__c = sDocumentURL;
          
          //If both plan name and competitor name are present then checking for upsert logic
          if(oBenefitToUpsert.Plan_Name__c != null && oBenefitToUpsert.Competitor_Name__c != null && oBenefitToUpsert.RecordTypeId != null){
            sBenefitUniqueCombination = oBenefitToUpsert.Plan_Name__c.toLowerCase() + '_' + oBenefitToUpsert.Competitor_Name__c.toLowerCase() + '_' + oBenefitToUpsert.RecordTypeId;

            if(!setExistingCombinationBenefits.contains(sBenefitUniqueCombination)){
              if(mapExistingBenefitsForCase.containsKey(sBenefitUniqueCombination)){    
                updateBenefitRecordFields(oBenefitToUpsert);
                oBenefitToUpsert.Id = mapExistingBenefitsForCase.get(sBenefitUniqueCombination);
              }
              setExistingCombinationBenefits.add(sBenefitUniqueCombination);
            }          
          }
          else{
            //If plan name not coming from NLP response
            if(oBenefitToUpsert.Plan_Name__c == null){
              iTempPlanNameCount++;
              oBenefitToUpsert.Plan_Name__c = StaticVariableClass.TEMP_PLAN_NAME + ' ' + iTempPlanNameCount + ' ' + Datetime.now();
            }
            //If competitor name not coming from NLP response
            if(oBenefitToUpsert.Competitor_Name__c == null){
              iTempCompetitorNameCount++;
              oBenefitToUpsert.Competitor_Name__c = StaticVariableClass.TEMP_COMPETITOR_NAME + ' ' + iTempCompetitorNameCount + ' ' + Datetime.now();
            }  
          }
          listFinalBenefitsToUpsert.add(oBenefitToUpsert);
        }
        if(!listFinalBenefitsToUpsert.isEmpty())
          upsert listFinalBenefitsToUpsert;
      }
    }  
    catch(Exception excn){
      //Logging exception in ExceptionLog__c object
      UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
      staticVariableClass.BENEFIT_UTILITY,StaticVariableClass.UPSERT_BENEFITS, null, LoggingLevel.ERROR);
    }
  }

    /*
    _________________________________________________________________________________________
    
    *@description: This method will be used to update existing benefit record based on new NLP response In case of upsert scenario with plan name + competitor name
    _______________________________________________________________________________________

    *@param: oBenefitRecord - holds the benefit object record to be updated - Benefit__c
    ____________________________________________________________________________________
    
    *@return: void
    _________________________________________________________________________________________
    */
    private static void updateBenefitRecordFields(Benefit__c oBenefitRecord){
    try{
      Map<String, Schema.SObjectType> mapSchema = Schema.getGlobalDescribe();
      schema.describefieldresult schBenefitObjectFieldResult;

      //Updating field values to blank If new NLP response does not contain field mappings in case of plan name + competitor name upsert scenario
      for(Schema.SObjectField schBenefitObjectfield : mapSchema.get('Benefit__c').getDescribe().fields.getMap().Values()){
        schBenefitObjectFieldResult = schBenefitObjectfield.getDescribe();
        if(schBenefitObjectFieldResult.isCustom() && schBenefitObjectFieldResult.isUpdateable() && oBenefitRecord.get(schBenefitObjectFieldResult.getName()) == null){
          oBenefitRecord.put(schBenefitObjectFieldResult.getName(),null);
        }
      } 
    }
    catch(Exception excn){
      //Logging exception in ExceptionLog__c object
            UTIL_LoggingService.logHandledException(excn, UserInfo.getOrganizationId(), staticVariableClass.NLP_APP_NAME,
            staticVariableClass.BENEFIT_UTILITY,StaticVariableClass.UPDATE_BENEFIT_FIELDS, null, LoggingLevel.ERROR);
    }
  }    
}
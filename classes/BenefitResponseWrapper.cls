/*
*******************************************************************************************
* Name          BenefitResponseWrapper 
* Author        Deloitte offshore
* ModifiedBy    Deloitte offshore
* CreatedDate   29/01/2020
* UsedBy        Class used for deserializing benefit JSON response from NLP
*******************************************************************************************
*/
public with sharing class BenefitResponseWrapper{
	
    public String transactionId {get;set;}	
    public String transactionTime {get;set;}	
    public Integer transactionStatus {get;set;}
    public String requestId {get;set;}
    public String lobType {get;set;}
    public String businessContextId {get;set;}
    public BenefitDocumentInformation[] document {get;set;}
   
    public class BenefitDocumentInformation{
		public String location {get;set;}	
		public String id {get;set;}	
		public String type {get;set;}
		public String context {get;set;}
		public ErrorInformation[] errors {get;set;}
		public BenefitData data {get;set;}
	}

    public class ErrorInformation{
        public String code {get;set;}
		public String description {get;set;}	
    }

    public class BenefitData{
		public BenefitPlan[] plan {get;set;}
	}

    public class BenefitPlan{
		public PlanAdministration administration {get;set;}
		public MedicalPlan medical {get;set;}
		public VisionPlan vision {get;set;}
	}

    public class PlanAdministration{
		public PlanAdminSection[] administrationSection {get;set;}
	}
    
	public class PlanAdminSection{
		public String id {get;set;}
		public String name {get;set;}
		public PlanAdminOption[] adminOption {get;set;}
	}

    public class PlanAdminOption{
		public String id {get;set;}
		public String name {get;set;}
		public String type {get;set;}
		public String[] value {get;set;}
	}
    
    public class MedicalPlan{
		public PlanGeneralAdmin generalBasisOfAdministration {get;set;}
		public MedicalPlanBenefits benefits {get;set;}
    }

    public class PlanGeneralAdmin{
        public PlanGeneralBenefit[] generalBenefit {get;set;}
    }

    public class PlanGeneralBenefit{
		public String id {get;set;}
		public String name {get;set;}
        public PlanGeneralBenefitTier[] tier {get;set;}
        public PlanAdminOption[] adminOption {get;set;}
	}

    public class PlanGeneralBenefitTier{
        public String id {get;set;}
		public String name {get;set;}
        public PlanBenefitOption[] benefitOption {get;set;}
    }

    public class PlanBenefitOption{
        public String id {get;set;}
		public String name {get;set;}
        public String type {get;set;}
		public String boa {get;set;}
		public String uom {get;set;}
		public String benefitPeriod {get;set;}
        public String[] value {get;set;}
    }

    public class MedicalPlanBenefits{
		public MedicalPlanBenefitCategory[] benefitCategory {get;set;}
	}

    public class MedicalPlanBenefitCategory{
		public String id {get;set;}
		public String name {get;set;}
		public MedicalPlanBenefit[] benefit {get;set;}
	}

    public class MedicalPlanBenefit{
		public String id {get;set;}
		public String name {get;set;}
		public MedicalPlanBenefitTier[] tier {get;set;}
	}
    
    public class MedicalPlanBenefitTier{
		public String id {get;set;}
		public String name {get;set;}
		public MedicalPlanAdministrationType administrationType {get;set;}
    }

    public class MedicalPlanAdministrationType{
		public String id {get;set;}
		public String name {get;set;}
		public MedicalPlanCalculation[] calculation {get;set;}
	}

    public class MedicalPlanCalculation{
		public String id {get;set;}
		public String name {get;set;}
		public PlanBenefitOption[] benefitOption {get;set;}
	}

    public class VisionPlan{
        public PlanGeneralAdmin generalBasisOfAdministration {get;set;}
        public VisionPlanBenefits benefits {get;set;}
    }

    public class VisionPlanBenefits{
		public VisionPlanBenefitCategory[] benefitCategory {get;set;}
	}

    public class VisionPlanBenefitCategory{
		public String id {get;set;}
		public String name {get;set;}
		public VisionPlanBenefit[] benefit {get;set;}
	}

    public class VisionPlanBenefit{
		public String id {get;set;}
		public String name {get;set;}
		public VisionPlanBenefitTier[] tier {get;set;}
	}
    
    public class VisionPlanBenefitTier{
		public String id {get;set;}
		public String name {get;set;}
		public VisionPlanAdministrationType administrationType {get;set;}
    }

    public class VisionPlanAdministrationType{
		public String id {get;set;}
		public String name {get;set;}
		public VisionPlanCalculation[] calculation {get;set;}
	}

    public class VisionPlanCalculation{
		public String id {get;set;}
		public String name {get;set;}
		public PlanBenefitOption[] benefitOption {get;set;}
	}
}
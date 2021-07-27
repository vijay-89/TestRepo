/*
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Name              LGHWAssociatePackageToPlansController
 * Author            Deloitte offshore (Gladiators)
 * ModifiedBy        Deloitte offshore (Gladiators)
 * CreatedDate       18th November 2019
 * UsedBy            LG_Attach_H&W_Packages (OS) 
 * User Story        Associate multiple Plans with a new or existing H&W Package
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * @description used by LG_Attach_H&W_Packages Omniscript to attach new or existing package to multiple plans.
 * 
 * Additional information
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Changes
 * vX.X(Version)            Name
 * Date                     Explanation
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/

global without sharing class LGHWAssociatePackageToPlansController implements vlocity_ins.VlocityOpenInterface2
{

    //public static Map<Id,String> mapPlanVsPackageName       =   new Map<Id,String>();
    
        /*
    _________________________________________________________________________________________
    
    *@description: Implementation of invokeMethod from VlocityOpenInterface2 interface.
    _________________________________________________________________________________________
    
    *@param: methodName - hold the name of specified method - String
    *@param: inputMap - Whole JSON from Omniscript - Map<String,Object>
    *@param: outMap - Whole JSON to Omniscript - Map<String,Object>
    *@param: optns - Optional parameter - Map<String,Object>
    _________________________________________________________________________________________
    
    *@return: Boolean
    _________________________________________________________________________________________
    */
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options) {
        List<QuoteLineItem> listSelectedPlan = new List<QuoteLineItem>();
        List<Product2> listSelectedChildProd;
        List<Product2> listExistingPkgParent;
        Set<Id> setQuoteId                   =   new Set<Id>();
        QuoteLineItem oCurrentPlanQli;
        ParamsWrapper oWrap;
        Id commercialFlowTypeParentID;
        String sCommercialFlowType;
        String sIncentiveType = '' ;
        Boolean bReturnValue  = false ;
        Id jobId;
        try{
            if(methodName.equalsIgnoreCase(staticVariableClass.ASSOCIATE_EXISTING_PKG)){
                listExistingPkgParent = (Product2[])JSON.deserialize(JSON.serialize(((List<Object>)((Map<String, Object>)((Map<String, Object>) 
                                        inputMap.get(staticVariableClass.PRODUCT_SELECTION)).get(staticVariableClass.PARENT_PRODUCT)).get(staticVariableClass.SELECTED_PARENT_PRODUCT))), List<Product2>.class);
                oCurrentPlanQli       = (QuoteLineItem)JSON.deserialize(JSON.serialize(inputMap.get(staticVariableClass.CURRENT_PLAN)), QuoteLineItem.class);   
                for(QuoteLineItem oQli : (QuoteLineItem[])JSON.deserialize(JSON.serialize((List<Object>)inputMap.get(staticVariableClass.PLAN_LIST)), List<QuoteLineItem>.class)){
                    if(oCurrentPlanQli.Id != oQli.Id){
                        listSelectedPlan.add(oQli);
                    }
                }
                sIncentiveType = [SELECT id,Incentive_Type__c FROM QuoteLineItem WHERE product2.Id =: listExistingPkgParent[0].Id AND ParentQuoteLineItem__c = :oCurrentPlanQli.Id].Incentive_Type__c;
               
                listSelectedChildProd = (List<product2>)JSON.deserialize(JSON.serialize(((List<Object>)((Map<String, Object>)((Map<String, Object>) inputMap.get(staticVariableClass.PRODUCT_SELECTION)).
                                                        get(staticVariableClass.CHILD_BUNDLES)).get(staticVariableClass.CHILD_LIST))), List<Product2>.class);
               
                oWrap = new ParamsWrapper(listExistingPkgParent[0].Name == staticVariableClass.COMMERCIAL_BUY_UPS ? staticVariableClass.COMMERCIAL_BUY_UPS : staticVariableClass.COMMERCIAL_CLINICAL,
                                    listExistingPkgParent[0].Id, listSelectedChildProd != null ? listSelectedChildProd : null, listSelectedPlan != null ? listSelectedPlan : null, sIncentiveType);
                
            }else if(methodName.equalsIgnoreCase(staticVariableClass.ASSOCIATE_NEW_PKG)){
                listSelectedPlan = (QuoteLineItem[])JSON.deserialize(JSON.serialize(
                                                    (List<Object>)inputMap.get(staticVariableClass.PLAN_LIST)), List<QuoteLineItem>.class);
                sCommercialFlowType              =   (String)((Map<String, Object>)
                                                        ((Map<String, Object>) inputMap.get(staticVariableClass.PRODUCT_SELECTION)).
                                                                    get(staticVariableClass.COMMERCIAL_SELECTIONS)).get(staticVariableClass.COMMERCIAL_FLOW);
                if( sCommercialFlowType == staticVariableClass.COMMERCIAL_CLINICAL){
                    commercialFlowTypeParentID   = (Id)(((Map<String, Object>) inputMap.get(staticVariableClass.COMMERCIAL_CLINICAL_NODE)).
                                                                    get(staticVariableClass.PARENT_PRODUCT_ID));
                    listSelectedChildProd        = (Product2[])JSON.deserialize(JSON.serialize((List<Object>) 
                                                                    inputMap.get(staticVariableClass.FINAL_PROGRAM_LIST)), List<Product2>.class);
                    sIncentiveType               = (String)((Map<String, Object>) inputMap.get(staticVariableClass.INCENTIVE_TYPE)).
                                                                    get(staticVariableClass.INCENTIVE_TYPE_SELECT);
                 }else if(sCommercialFlowType == staticVariableClass.COMMERCIAL_BUY_UPS){
                    commercialFlowTypeParentID   = ([SELECT Id FROM Product2 WHERE  NALGProdRecordType__c =:staticVariableClass.COMMERCIAL_BUY_UPS 
                                                                                AND ProductActive__c = true LIMIT 1 ].Id);
                    listSelectedChildProd        = (Product2[])JSON.deserialize(JSON.serialize((List<Object>)((Map<String, Object>) inputMap.get(staticVariableClass.COMMERCIAL_BUYUP_SELECTION)).get(staticVariableClass.FINAL_PROGRAM_LIST)), List<Product2>.class);
                 
                 }
              oWrap = new ParamsWrapper(sCommercialFlowType, commercialFlowTypeParentID, listSelectedChildProd, listSelectedPlan,sIncentiveType);
            }
            setQuoteId.add(listSelectedPlan[0].QuoteId);
             jobId = System.enqueueJob(new LGHWAssociatePackageToPlansQueueable(JSON.serialize(oWrap)));
                if(!setQuoteId.isEmpty() && jobId != null){
                    LGHWQuoteLineItemActions.getAsyncJobIdUpdateQuote(setQuoteId,jobId);
                }
            bReturnValue = true;
        }catch (Exception oExcn){
            ExceptionLog__c oExceptionlog = LGHWQuoteLineItemActions.createExceptionRecord(oExcn);
            oExceptionlog.ClassName__C    = staticVariableClass.CLASS_LG_ASSOCIATE_PACKAGE_TO_PLAN;
            oExceptionlog.MethodName__c   = staticVariableClass.ASSOCIATE_NEW_PKG;
            oExceptionlog.ApexTrigger__c  = null;
            insert oExceptionlog;
        }
        return bReturnValue;
    }
  
   /*
    _________________________________________________________________________________________
    *@name       : ParamsWrapper
    *@description: oWrapper class to hold the params sent to autoAssociation
    _________________________________________________________________________________________
    *@param:  List<Product2> listSelectedChildPrograms;
    *@param:  List<QuoteLineItem> listSelectedPlan;
    *@param:  List<QuoteLineItem> listAhgProdInOtherPlans;
    *@param:  String sIncentiveType;
    *@param:  String sCommercialFlowType;
    *@param:  String commercialFlowTypeParentID;
    *@param:  Boolean bContainsActiveAhg;
    *@param:  Boolean bHasAhg;
    _________________________________________________________________________________________
    
    *@return: null
    _________________________________________________________________________________________
   */
   public class ParamsWrapper{
        public List<Product2> listSelectedChildPrograms;
        public List<QuoteLineItem> listSelectedPlan;
        public List<QuoteLineItem> listAhgProdInOtherPlans;
        public String sIncentiveType;
        public String sCommercialFlowType;
        public String sCommercialFlowTypeParent;
        public Boolean bContainsActiveAhg;
        public Boolean bHasAhg;
        
       public ParamsWrapper(String sCommercialFlowType, String sCommercialFlowTypeParent, List<Product2> listSelectedChildPrograms, List<QuoteLineItem> listSelectedPlan,String sIncentiveType){
            this.sCommercialFlowType                 = sCommercialFlowType;
            this.sCommercialFlowTypeParent           = sCommercialFlowTypeParent;
            this.listSelectedChildPrograms           = new List<Product2>( listSelectedChildPrograms );
            this.listSelectedPlan                    = new List<QuoteLineItem>( listSelectedPlan );
            this.sIncentiveType                      = sIncentiveType;
        }
       public ParamsWrapper(Boolean bContainsActiveAhg, List<QuoteLineItem> listAhgProdInOtherPlans, Boolean bHasAhg){
            this.bContainsActiveAhg                 = bContainsActiveAhg;
            this.listAhgProdInOtherPlans            = new List<QuoteLineItem>(listAhgProdInOtherPlans);
            this.bHasAhg                            = bHasAhg;
        }
    }
}
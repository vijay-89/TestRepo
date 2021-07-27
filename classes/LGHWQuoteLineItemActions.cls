/*
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Name              LGHWQuoteLineItemActions
 * Author            Deloitte offshore (Gladiators)
 * ModifiedBy        Deloitte offshore (Gladiators)
 * CreatedDate       18th November 2019
 * UsedBy            Add Plan/Product or Add PLan omniscript 
 * User Story        Associate H&W package while adding a plan
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * @description used by Add Plan/Product or Add PLan omniscript  to attach H&W package based on HPCC code.
 * 
 * Additional information
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * Changes
 * vX.X(Version)            Name
 * Date                     Explanation
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
public with sharing class LGHWQuoteLineItemActions{
    /**
     * @description This methood is used to identify Plans and then process further.
     * @param  newQLI List of new QuoteLineItem
     */
    public static void createHWPackagePrograms ( List<QuoteLineItem> newQLI) {
    try{
        //Check if we have Custom Setting Trigger Switch Record 
        vlocity_ins__TriggerSetup__c triggerRecord = vlocity_ins__TriggerSetup__c.getValues('QuoteLineItemAfterInsert');
        if(triggerRecord != null && triggerRecord.vlocity_ins__IsTriggerOn__c){
             //Logic to Insert  Packages
            Map<String,List<QuoteLineItem>> mapOfCombinationStringVsQuoteLineItem= new Map<String,List<QuoteLineItem>>();
            Set<Id> setQuoteLineIds = new Set<Id>();
            Set<Id> setCreateFutureQuoteIds = new Set<Id>();
            for(QuoteLineItem oQLI : newQLI){
                if(oQLI.ProductCategory__c.equals(staticVariableClass.Plan) && oQLI.Product_Type__c.equals(staticVariableClass.Medical)){//prevent vision flow from Auto Association flow - Vision Flow changes-GLD
                    setCreateFutureQuoteIds.add(oQLI.QuoteId);
                    setQuoteLineIds.add(oQLI.Id);
                    String sQLICombination = oQLI.HPCC_Code__c.toLowerCase()+oQLI.Funding__c+oQLI.Situs_State_Abbrev__c+String.valueOf(oQLI.OpportunityEffectiveDate__c.year());
                    if(!mapOfCombinationStringVsQuoteLineItem.containsKey(sQLICombination)){
                        mapOfCombinationStringVsQuoteLineItem.put(sQLICombination, new List<QuoteLineItem>{oQLI});
                    }
                    else{
                        mapOfCombinationStringVsQuoteLineItem.get(sQLICombination).add(oQLI);
                    }
                }
            }
            if (mapOfCombinationStringVsQuoteLineItem != null &&  mapOfCombinationStringVsQuoteLineItem.size()>0 && !setQuoteLineIds.isEmpty()){   
               Id jobId = System.enqueueJob(new LGAddHWPackageProgramsQueueable(mapOfCombinationStringVsQuoteLineItem,setQuoteLineIds,setCreateFutureQuoteIds));
                if(!setCreateFutureQuoteIds.isEmpty() && jobId != null){
                    getAsyncJobIdUpdateQuote(setCreateFutureQuoteIds,jobId);
                }
            }
          }
        }   catch (Exception excn){
            ExceptionLog__c exceptionlog = createExceptionRecord(excn);
            exceptionLog.ClassName__C = staticVariableClass.CLASS_LG_QUOTE_LINE_ITEM;
            exceptionLog.MethodName__c=staticVariableClass.CREATE_HW_PACKAGE_PROGRAMS;
            exceptionLog.ApexTrigger__c=staticVariableClass.QLI_AFTER_INSERT_TRIGGER;
            insert exceptionLog;
        }
    }
    
    /**
     * @description This Methood is get AsyncJobId and Update on QuoteId.
     * @param  quoteIds Set of Ids
     * @param  jobId Id of AsyncApexJob
     */

    public static void getAsyncJobIdUpdateQuote(Set<Id>setquoteIds, Id jobId){
            Quote oQuote = new Quote (Id = (new list<Id>(setquoteIds)[0]));
            oQuote.ApexAsyncJobId__c = jobId;
            update oQuote;
        }
    
    
    /**
     * @description This methood is used to create a Map of ProductId and PriceBookId whenever Invoked using ProductId.
     * @param  setProductId Set of Products Id
     * @return mapOfProductVsPricebook  map of product vs pricebook
     */
    public static Map<Id,Id> getPricebookForProduct(Set<Id> setProductId){
        Map<Id,Id> mapOfProductVsPricebook = new Map<Id,Id>();
      
        If(setProductId !=null && setProductId.size()>0 &&   Schema.sObjectType.PricebookEntry.isAccessible()){
            for(Pricebookentry oPbe : [Select Id,Product2Id FROM PricebookEntry where Product2Id IN :setProductId AND IsActive=TRUE]){
                   mapOfProductVsPricebook.put(oPbe.Product2Id, oPbe.Id);
                }
            }
        return mapOfProductVsPricebook;
    }     
        
      /**
     * @description This methood is used to return  a exception record when called.
     * @param excep (Exception)
     * @return exceptionLog  (ExceptionLog__c object)
    */
    public static ExceptionLog__c  createExceptionRecord(Exception excep){
        ExceptionLog__c exceptionLog = new ExceptionLog__c();
        exceptionLog.ExceptionDetails__c = excep.getTypeName()+UTIL_ErrorConstants.COLON+excep.getMessage()+UTIL_ErrorConstants.ENTER+excep.getStackTraceString();
        exceptionLog.OrgId__c = ANA_UTIL03_Constants.ORGID;
        exceptionLog.Application__c = staticVariableClass.COMMERCIAL_SALES_STRING;
        exceptionLog.ContextUser__c = UserInfo.getUserId();
        exceptionLog.Severity__c = staticVariableClass.ERROR ;
        return  exceptionLog ;
    }
}
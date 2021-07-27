/**
* ------------------------------------------------------------------------------------------------------
* Name          LGOrderImpactedProducts_Ctrl
* Author        Deloitte Offshore
* ModifiedBy    Deloitte Offshore
* UsedBy        LGOrderImpactedProducts_App,Vlocity Action (Impacted Product)
* ------------------------------------------------------------------------------------------------------
* 
* @description
* 
* Used to populate Impacted_Products__c , Impacted_Products_Id__c and Impacted_Product_Types__c fields of Order
* 
* ------------------------------------------------------------------------------------------------------
* Changes
* ------------------------------------------------------------------------------------------------------
**/

public with sharing class LGOrderImpactedProducts_Ctrl{
    
    /**
* @description 		getQliOfCase 				Init method to load QLIs 
* @param 			ordId 			String		OrderId	
* @param 			quoteId		String		QuoteId of the Order
* @return 			oDatawrap		DataWrapper
*/
    @AuraEnabled
    public static DataWrapper getQliOfCase(String ordId ,String quoteId){
        List<String> listImpacQli = new List<String>();
        List<QuoteLineItem> listQli = new List<QuoteLineItem>();
        List<Order> listOrderRecord;
        
        if(ordId != null){
            //Domain URL for Page Redirect to Implementation Case
            String sFullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + ordId;
            listOrderRecord = new List<Order>([select id ,Impacted_Products__c,Impacted_Products_Id__c from Order where Id=:ordId]);
            if(listOrderRecord.size()>0){
                if(listOrderRecord[0].Impacted_Products_Id__c !=null && listOrderRecord[0].Impacted_Products_Id__c.length() >0){
                    listImpacQli.addAll(listOrderRecord[0].Impacted_Products_Id__c.split(','));  
                }
            }
            if(quoteId!=null){
                for(QuoteLineItem qli : [SELECT ProductStage__c,Id,Product2.Name,OppType__c,Product_Type__c,SFDCLegacyID__c 
                                         FROM QuoteLineItem WHERE QuoteId =:quoteId 
                                         AND
                                         (
                                             (ProductCategory__c =:staticVariableClass.Product  AND ParentQuoteLineItem__c = null and Product_Type__c !=: staticVariableClass.Medical ) 
                                             OR 
                                             (ProductCategory__c=: staticVariableClass.Plan AND ParentQuoteLineItem__c != null AND Product_Type__c =: staticVariableClass.Medical)
                                             OR
                                             (ProductCategory__c =: staticVariableClass.Plan AND Product_Type__c =: staticVariableClass.Vision)//Display vision plans on Lightning screen -Vision flow check - GLD
                                             OR
                                             (ProductCategory__c =:staticVariableClass.Product AND ParentQuoteLineItem__c = null AND Product_Type__c =: staticVariableClass.Medical AND Product_SFDC_Legacy_ID__c != null) 
                                         )]){
                                             listQli.add(qli);
                                         }
                //Wrapper with FullRecordUrl, List with Impacted Qli Ids,QLI records of the Quote under given Order
                
                DataWrapper oDatawrap = new DataWrapper(
                    sFullRecordURL,
                    listQli.size()>0 && listQli !=null  ? listQli : null,
                    listImpacQli.size()>0 && listImpacQli !=null ? listImpacQli : null
                );
                return oDatawrap;
            }            
        }
        return null; 
    }
    /** 
* @description 			updateQli			Impacted_Products_Id__c , Impacted_Products__c, 	Impacted_Product_Types__c fields of Order
* @param qliIdsList		List<String>		QLI Ids that got Impacted
* @param ordId			String				order Id
* @return 				void
*/
    @AuraEnabled
    public static void updateQli(List<String> qliIdsList, String ordId){
        List<Order> listOrderToBeUpdated = new List<Order>(); 
        Set<String> setProductType = new Set<String>();
        if(!qliIdsList.isEmpty() && qliIdsList !=null){
            String sProdId ='';
            String sProdName='';
            String sProdType = '';
            for(QuoteLineItem oQli : [SELECT id,Product2.Name,Product2.Product_Type__c, QuoteId from QuoteLineItem where Id IN : qliIdsList]){
                sProdName = sProdName + oQli.Product2.Name +','+'\n' ;
                sProdId = sProdId + oQli.Id  +',' ;
                setProductType.add(oQli.Product2.Product_Type__c);
            }
            sProdId = sProdId.removeEnd(',');
            sProdName = sProdName.removeEnd('\n');
            sProdName = sProdName.removeEnd(',');
            sProdType = String.join(new List<String>(setProductType), ',');
            listOrderToBeUpdated.add(new Order(id=ordId,Impacted_Products_Id__c =sProdId,Impacted_Products__c = sProdName,Impacted_Product_Types__c = sProdType)); 
        }else{
            String sProdId ='';
            String sProdName='';
            String sProdType = '';
            listOrderToBeUpdated.add(new Order(id=ordId,Impacted_Products_Id__c =sProdId,Impacted_Products__c = sProdName,Impacted_Product_Types__c = sProdType)); 
        }
        if(Schema.sObjectType.Order.isUpdateable() && !listOrderToBeUpdated.isEmpty() && listOrderToBeUpdated!=null){
            update listOrderToBeUpdated;
        }
    }
    
    /** 
* @description 			DataWrapper			wrapper class to hold the data to be shown on lightning page
*/  
    public class DataWrapper{
        @AuraEnabled
        public List<QuoteLineItem> data;
        
        @AuraEnabled
        public String fullRecordURL;
        
        @AuraEnabled
        public List<String> qliId;
        
        DataWrapper(String fullRecordURL,List<QuoteLineItem> data,List<String> qliId){
            this.fullRecordURL = fullRecordURL;
            this.data = data;
            this.qliId = new List<String>(qliId);
        }
    }
}
/**
* @author Deloitte
* @date 21st Aug 2019
* @description This is a wraper class which eventually maintains the bridge between Vlocity Omniscript and ContCodeReservService.
*/
global without sharing class LG_ContCodeReservServiceWrapper implements vlocity_ins.VlocityOpenInterface2{
    
    /**
        @description implementation of invokeMEthod from VlocityOpenInterface2 interface.
        @param a map<String,Object> which will carry the data into "invokeMethod" method of this class from omniScript.
        @param a map<String,Object> which will carry the data form this apex class to the vlocity output screen.
        @param a map<String,Object> which is optional.
        @return this method will return a boolean value, which will be true or false.
    */
    global Boolean invokeMethod(String methodName, map<String,Object> inputMap, map<String,Object> outMap, map<String,Object> optns){
        contractCodeReserveServiceCallwrapper(inputMap, outMap, true);   
        return true;
    }
    
    /**
        @description this method is being called from "invokeMethod" only.
        @param a map<String,Object> which will get the data from "invokeMethod" method of this class.
        @param a map<String,Object> which will get the data form "invokeMethod" method of this class and containes the output for vlocity screen.
        @param a boolean parameter which is used to identify that it's a omniScriptCall or not.
        @returnt this method don't return anything.
    */
    global static void contractCodeReserveServiceCallwrapper(map<String, Object> inputMap, map<String,Object> outMap, Boolean omniScriptCall){
        ID orderid= (ID)inputMap.get(staticVariableClass.CreateGrpQUOTEID);
        list<ContCodeReserveResponse> responseStatus = ContCodeReservService.contractCodeReserveServiceCalloutImpl(orderid);
        map<String,Object> responseMap = new map<String,Object>();
        list<list<string>> responseList = new list<list<string>>();
        if(!responseStatus.isEmpty()){
            for(Integer i = 0; i < responseStatus.size(); i++){
                responseList.add(new list<string>{responseStatus.get(i).Status.code, responseStatus.get(i).Status.message});
            }
            outMap.put('SoldProduct', responseList);
        }
    }
}
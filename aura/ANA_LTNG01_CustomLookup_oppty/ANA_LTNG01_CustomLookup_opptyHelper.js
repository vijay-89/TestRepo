({
	itemSelected : function(component, event, helper) {
        var target = event.target;   
        var SelIndex = helper.getIndexFrmParent(target,helper,"data-selectedIndex");  
        if(SelIndex){
            var serverResult = component.get("v.server_result");
            var selItem = serverResult[SelIndex];
            if(selItem.val){
               component.set("v.selItem",selItem);
               component.set("v.last_ServerResult",serverResult);                
                if(selItem.val.substring(0, 3) == '001'){
                   /**********FireEvent *******************/
                   var appEvent = $A.get("e.c:ANA_LTNG04_BrokerConsultant_Event_oppty");
                   appEvent.setParams({
                        "selectedOpp" : selItem});
                   appEvent.fire();
                }
            } 
            console.log('selItem:'+JSON.stringify("v.selItem"));
            component.set("v.server_result",null);
        } 
	}, 
    serverCall : function(component, event, helper) { 
        //console.log('ServerCalling');
        var target = event.target;  
        var searchText = target.value; 
        var last_SearchText = component.get("v.last_SearchText");        
        console.log('searchText:'+searchText);
        console.log('last_SearchText:'+last_SearchText);
        console.log('Validation:'+/\s+$/.test(searchText));
        //Escape button pressed 
        if (event.keyCode == 27 || !searchText.trim()) { 
            console.log('FirstIf');
            helper.clearSelection(component, event, helper);
        }else if(searchText){ //searchText.trim() != last_SearchText && /\s+$/.test(searchText)
            //Save server call, if last text not changed
            //Search only when space character entered
             console.log('SecondIf');
            var objectName = component.get("v.objectName");
            var field_API_text = component.get("v.field_API_text");
            var field_API_val = component.get("v.field_API_val");
            var field_API_search = component.get("v.field_API_search");
            var limit = component.get("v.limit");
            var searchSpecific = component.get("v.searchSpecific");
            var oppId = component.get("v.oppId");
            var searchByType = component.get("v.searchByType");
            
            console.log(searchSpecific);
            console.log(OppId);
            console.log(searchByType);
            var action = component.get('c.searchDB');
            action.setStorable();
            
            action.setParams({
                objectName : objectName,
                fld_API_Text : field_API_text,
                fld_API_Val : field_API_val,
                lim : limit, 
                fld_API_Search : field_API_search,
                searchText : searchText,
                searchByType : searchByType,
                searchSpecific : searchSpecific,
                oppId : oppId
            });
    
            action.setCallback(this,function(a){
                this.handleResponse(a,component,helper);
            });
            
            component.set("v.last_SearchText",searchText.trim());
            console.log('Server call made');
            $A.enqueueAction(action); 
        }
        /*else if(searchText && last_SearchText && searchText.trim() == last_SearchText.trim()){ 
            console.log('ThirdIf');
            component.set("v.server_result",component.get("v.last_ServerResult"));
            console.log('Server call saved');
        }  */       
	},
    handleResponse : function (res,component,helper){
        if (res.getState() === 'SUCCESS') {
            var retObj = JSON.parse(res.getReturnValue());
            if(retObj.length <= 0){
                var noResult = JSON.parse('[{"text":"No Results Found"}]');
                component.set("v.server_result",noResult); 
            	component.set("v.last_ServerResult",noResult);
            }else{
                component.set("v.server_result",retObj); 
            	component.set("v.last_ServerResult",retObj);
            }  
        }else if (res.getState() === 'ERROR'){
            var errors = res.getError();
            if (errors) {
                if (errors[0] && errors[0].message) {
                    alert(errors[0].message);
                }
            } 
        }
    },
    getIndexFrmParent : function(target,helper,attributeToFind){
        //User can click on any child element, so traverse till intended parent found
        var SelIndex = target.getAttribute(attributeToFind);
        while(!SelIndex){
            target = target.parentNode ;
			SelIndex = helper.getIndexFrmParent(target,helper,attributeToFind);           
        }
        return SelIndex;
    },
    clearSelection: function(component, event, helper){
        component.set("v.selItem",null);
        component.set("v.server_result",null);
    } 
})
trigger CaseTrigger on Case (before Insert, before Update,after Insert,after Update) {
    system.debug('trigger.newMap '+trigger.newMap);
    CaseTriggerHelper csHelper = new CaseTriggerHelper();
    if(trigger.isBefore && (trigger.IsInsert || trigger.isUpdate)){
        csHelper.updateMailBox(trigger.new);
        if(checkRecursive_trgrecursive.beforerunOnce()){
        csHelper.removeAccountContact(trigger.new,trigger.newMap);
         }

    }
    if (trigger.isAfter && (trigger.IsInsert || trigger.isUpdate)){
        if(checkRecursive_trgrecursive.afterrunOnce()){
        if(trigger.IsInsert) {
            csHelper.potentialDuplicateCheck(trigger.new); 
        }
        if(trigger.isUpdate) {
            csHelper.uncheckPotentialDuplicates(trigger.new);
            csHelper.opptyStampingBenefitCensus(trigger.new,trigger.oldMap);  
         }
      }
}
}
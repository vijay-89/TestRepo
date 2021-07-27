/* eslint-disable no-irregular-whitespace */
/*Author Geetha
*Date    03/17/2020     
*Description  :  Javascript to pass Selected/Deselected anthem plan names and benefit.
*Modification Log:
-----------------------------------------------------------------------------------------
* Developer Name                                Date            Description
* Geetha                                     03/05/2020        Initial version
*/
import { LightningElement, api } from 'lwc';
import fetchCustomLabels from 'c/customLabelLG';
export default class BenefitPlanTopRowValuesLG extends LightningElement {
  @api planDataToDislay;
  @api isBenefitSelected;
  @api selectedPicklistId;
  selectedDeselectedDictionary = {};

  /*
Method Name : customLabelLG
Description: For fecthing the custom labels. 
Paramerter:
*/
  get customLabelLG() {
    return fetchCustomLabels;
  }
  /*
Method Name : handleSelect
Description: For handling the selected and deselected plans in LWC plan compare screen. 
Paramerter:Event
*/
  handleSelect(evnt) {
    this.dispatchEvent(new CustomEvent('buttonclick', { detail: evnt.target.dataset.prodid }));
  }
  /*
  Method Name : handleRemovePlanComparison
  Description: For removing plans from comparison screen(LWC)
  Paramerter:Event
  */
  handleRemoveFromComparision(evt) {
    this.dispatchEvent(new CustomEvent('linkclick', { detail: evt.target.dataset.targetId }));
  }
  /*
  Method Name : decideHtmlClasses
  Description: For adding styles to anthem plans
  Paramerter:
  */
  get decideHtmlClasses() {
    let htmlClass = '';
    const filler_width = this.planDataToDislay.topRow.length;
    let constantClasses = 'topRow-planName slds-large-size--1-of-' + filler_width + ' slds-small-size--1-of-' + this.planDataToDislay.topRow.length;
    if (this.planDataToDislay.topRow.length === 1) {
      htmlClass = constantClasses + ' slds-max-small-size--1-of-1 nds-max-small-size--1-of-1';
    } else if (this.planDataToDislay.topRow.length > 1) {
      htmlClass = constantClasses + ' slds-max-small-size--1-of-2 nds-max-small-size--1-of-2';
    }
    return htmlClass;
  }
  /*
    Method Name : benefitDecideHtmlClasses
    Description: For adding styles to benefits plans
    Paramerter:
    */
  get benefitDecideHtmlClasses() {
    let backhtmlClass = '';
    const filler_width = this.planDataToDislay.topRow.length;
    let constantClasses = 'topRow-planName slds-large-size--1-of-' + filler_width + ' slds-small-size--1-of-' + this.planDataToDislay.topRow.length;
    if (this.planDataToDislay.topRow.length === 1) {
      backhtmlClass = constantClasses + ' slds-max-small-size--1-of-1 nds-max-small-size--1-of-1';
    } else if (this.planDataToDislay.topRow.length > 1) {
      if (this.isBenefitSelected) {
        backhtmlClass = constantClasses + ' benefitBackground slds-max-small-size--1-of-2 nds-max-small-size--1-of-2';
      } else {
        backhtmlClass = constantClasses + ' slds-max-small-size--1-of-2 nds-max-small-size--1-of-2';
      }
    }
    return backhtmlClass;
  }

}
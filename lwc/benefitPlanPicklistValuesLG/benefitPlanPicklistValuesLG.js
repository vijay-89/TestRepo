/* eslint-disable no-irregular-whitespace */
/*Author Haneesha Tangeti
*Date    03/18/2020     
*Description  :  Javascript to pass the selected benefit record, from the dropdown. 
*Modification Log:
-----------------------------------------------------------------------------------------
* Developer Name                                Date            Description
* Haneesha Tangeti                              03/05/2020      Initial version
*/
import { LightningElement, api } from 'lwc';
import fetchCustomLabels from 'c/customLabelLG';
export default class BenefitPlanPicklistValuesLG extends LightningElement {
  @api planDataToDislay;
  @api placeHolder;
  @api listBenefitRecords;
  @api isDisabled;
  @api isBenefitSelected;
  @api selectedPicklistId;
  @api value;
  @api isDifference;
  @api isDropDown;
  /*
  Method Name : customLabelLG
  Description: For fetching the Custom Labels
  Paramerter:
  */
  get customLabelLG() {
    return fetchCustomLabels;
  }
  /*
    Method Name : headerFillerClass
    Description: For adding the style classes for header/Top Row
    Paramerter:
    */
  get headerFillerClass() {
    const filler_width = this.planDataToDislay.topRow.length + 2
    return "slds-large-size--2-of-" + filler_width + " slds-large-show"
  }
  /*
  Method Name : handlePicklistChange
  Description: For creating an event on change of DropDown
  Paramerter:Event
  */
  handlePicklistChange(evnt) {
    this.dispatchEvent(new CustomEvent('picklistclick', { detail: evnt.detail.value }));
  }
  /*
  Method Name : handleDifference
  Description: For handling the difference between benefit and anthem plan
  Paramerter:Event
  */
  handleDifference(evt) {
    this.dispatchEvent(new CustomEvent('checkboxclick', { detail: evt.target.checked }));
  }
}
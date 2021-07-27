/* eslint-disable no-irregular-whitespace */
/*Author Bikash Kumar Gupta  
*Date    03/05/2020     
*Description  :  Javascript to pass the Anthem Plan and Benefit data for comparison. 
*Modification Log:
-----------------------------------------------------------------------------------------
* Developer Name                                Date            Description
* Bikash Kumar Gupta                          03/05/2020      Initial version
*/
import { LightningElement, api, track } from 'lwc';
export default class BenefitPlanRecordValuesLG extends LightningElement {
  @api planDataToDislay;
  @api isBenefitSelected;
  @api isDifference;
  /*
    Method Name : decideHtmlClasses
    Description: For showing the anthem plans with styling
    Paramerter:null
    */
  get decideHtmlClasses() {
    let htmlClass = '';
    const filler_width = this.planDataToDislay.topRow.length + 2;
    let filler_width_diff = filler_width * 2;
    let constantClasses
    if (this.isDifference) {
      constantClasses = 'topRow-planName slds-large-size--1-of-' + filler_width_diff + ' slds-small-size--1-of-' + this.planDataToDislay.topRow.length;
    } else {
      constantClasses = 'topRow-planName slds-large-size--1-of-' + filler_width + ' slds-small-size--1-of-' + this.planDataToDislay.topRow.length;
    }
    if (this.planDataToDislay.topRow.length === 1) {
      htmlClass = constantClasses + ' slds-max-small-size--1-of-1 nds-max-small-size--1-of-1';
    } else if (this.planDataToDislay.topRow.length > 1) {
      htmlClass = constantClasses + ' slds-max-small-size--1-of-2 nds-max-small-size--1-of-2';
    }
    return htmlClass;
  }
  /*
  Method Name : benefitDecideHtmlClasses
  Description: For showing the benefit plans with styling
  Paramerter:null
  */
  get benefitDecideHtmlClasses() {
    let backhtmlClass = '';
    const filler_width = this.planDataToDislay.topRow.length + 2;
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
  
  /*
    Method Name : tableLabels
    Description: For adding styles for lables
    Paramerter:
    */
  get tableLabels() {
    const filler_width = this.planDataToDislay.topRow.length + 2;
    return "slds-large-size--2-of-" + filler_width + " slds-size--1-of-1 slds-truncate label"
  }
}
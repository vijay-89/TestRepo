/* eslint-disable no-irregular-whitespace */
/*Author Bikash Gupta
*Date    03/18/2020     
*Description  :  Helper JS class that contains all the methods, Invoked by the child components based on custom events.  
*Modification Log:
-----------------------------------------------------------------------------------------
* Developer Name                                Date            Description
* Bikash Gupta                                03/05/2020      Initial version
* Geetha                                      03/05/2020      handle Select/Deselect logic
* Wes                                        03/05/2020      Data flow   latest
*/
import { LightningElement, api, track } from 'lwc';
import getBenefitRecords from '@salesforce/apex/LGCompetitorBenefitDetails.getBenefitRecords';
import fetchCustomLabels from 'c/customLabelLG';
export default class CompareBenefitPlanLG extends LightningElement {
  @track planDataToDislay;
  @api planDataToCompare = {};
  selectedDeselectedDictionary = {};
  @track message = this.customLabelLG.Label.No_Competitor_Data_available;
  @track listBenefitRecords = [];
  @track isDisabled = false;
  @track value = '';  //this displays selected value of combo box
  @track placeHolder = this.customLabelLG.Label.Select_Competitor_Data;
  dataMap = {};
  clonedData;
  @track selectedPicklistId;
  isBenefitSelected = false;
  @track isDifference = false;
  @track isErrorState = false;
  @track isDropdown=false;

  //Call back method
  connectedCallback() {
    document.addEventListener('os_notification', this.handleNotification.bind(this));
    this.handlePlanData();
  }
  /*
  Method Name : handleNotification
  Description: For handling the data in LWC plan compare screen. 
  Paramerter:Event
  */
  handleNotification(evt) {
    evt.preventDefault();
    this.planDataToCompare = evt.detail.text;
    this.handlePlanData();
    this.handleBenifitData();
    this.isBenefitSelected = false;
  }
  /*
  Method Name : handlePlanData
  Description: For handling the selected and deselected plans in LWC plan compare screen. 
  Paramerter:Event
  */
  handlePlanData() {
    let objPlanDetails = {};
    let arrOfTopRow = [];
    let lstplanDataToDislay = [];
    for (let key in this.planDataToCompare.topRow) {
      if (this.planDataToCompare.topRow[key]) {
        arrOfTopRow.push({ 'id': this.planDataToCompare.topRow[key].Id, 'name': this.planDataToCompare.topRow[key].Name, 'productData': this.planDataToCompare.topRow[key].productData, 'color': '' });
      }
    }
    for (let key in this.planDataToCompare.categorized_list) {
      if (this.planDataToCompare.categorized_list[key]) {
        objPlanDetails = {
          'sectionName': key,
          'lstSectionValue': []
        };
        for (let name in this.planDataToCompare.categorized_list[key]) {
          if (this.planDataToCompare.categorized_list[key]) {
            let lstPlanValue = [];
            this.planDataToCompare.categorized_list[key][name].attributeValues.forEach(item => {
              lstPlanValue.push({ 'val': item.dataType !== undefined && item.dataType === this.customLabelLG.Label.currency ? '$' + item.userValues : (item.dataType !== undefined && item.dataType === this.customLabelLG.Label.percent ? item.userValues + '%' : item.userValues === undefined ? '' : item.userValues), 'color': '' });
            })
            if(this.planDataToCompare.categorized_list[key][name].label!==undefined){
            objPlanDetails.lstSectionValue.push({
              'Name': this.planDataToCompare.categorized_list[key][name].label,
              'Value': lstPlanValue
            });
          }
          }
        }
        lstplanDataToDislay.push(objPlanDetails);
      }
    }
    this.planDataToDislay = {
      'topRow': arrOfTopRow,
      'categoryData': lstplanDataToDislay
    }
  }
  /*
  Method Name : handleBenifitData
  Description: For fetching the benefit data from apex and to showcase the same on UI
  Paramerter:
  */
  handleBenifitData() {
    let state=this.customLabelLG.Label.States;
    getBenefitRecords({ sOppId: this.planDataToCompare.OpptyId, sPlanType: this.planDataToCompare.ProductType, sObjectApiName: this.customLabelLG.Label.Benefit })
      .then(result => {
        if(this.planDataToCompare.ProductType === this.customLabelLG.Label.Medical){ 
          if (this.planDataToCompare.Situs_State !== undefined && this.planDataToCompare.Situs_State !== null && state.includes(this.planDataToCompare.Situs_State) ) {
          this.isDropDown=true;
        if (result.lstWrap.length === 0) {
          this.isErrorState=true;
          this.isDisabled = true;
          this.placeHolder = this.customLabelLG.Label.No_Competitor_Data_available;
          this.showCustomErrorModal();
        }
        else if (result.lstWrap.length > 0) {
          this.listBenefitRecords = result.lstWrap;
          this.dataMap = result.mapBenefit;
        }
      }
      }
      else if (this.planDataToCompare.ProductType === this.customLabelLG.Label.Vision){
        if (this.planDataToCompare.Situs_State !== undefined && this.planDataToCompare.Situs_State !== null && state.includes(this.planDataToCompare.Situs_State) && result.isVisionAllowed) {
          this.isDropDown=true;
          if (result.lstWrap.length === 0) {
            this.isErrorState=true;
            this.isDisabled = true;
            this.placeHolder = this.customLabelLG.Label.No_Competitor_Data_available;
            this.showCustomErrorModal();
          }
          else if (result.lstWrap.length > 0) {
            this.listBenefitRecords = result.lstWrap;
            this.dataMap = result.mapBenefit;
          }
       }else{
         this.isDropDown=false;
         this.isErrorState=false;
       }
      }
      })
      .catch(error => {
        this.message = error;
        this.showCustomErrorModal();
      });
  }
  /*
  Method Name : handlePicklistChange
  Description: For showing the benefit data as first column on click of dropdown
  Paramerter:
  */
  handlePicklistChange(event) {
    let newValue;
    let obj = JSON.parse(event.detail);
    this.selectedPicklistId = obj.Id;
    if (this.isDifference) {
      this.isDifference = false;
      this.planDataToDislay.categoryData = JSON.parse(JSON.stringify(this.clonedData));
    }
    if (!this.isBenefitSelected) {
      this.planDataToDislay.topRow.unshift({ 'id': obj.Id, 'name': obj.Competitor_Name__c + ' ' + obj.Plan_Name__c });
      for (let key in this.planDataToDislay.categoryData) {
        if (this.planDataToDislay.categoryData[key]) {
          for (let data in this.planDataToDislay.categoryData[key].lstSectionValue) {
            if (this.planDataToDislay.categoryData[key]) {
              let name = this.planDataToDislay.categoryData[key].sectionName + this.planDataToDislay.categoryData[key].lstSectionValue[data].Name;
              let recordValue = this.dataMap[name] !== undefined ?
                (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] === this.customLabelLG.Label.currency && !isNaN(obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]])) ? '$' + obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] :
                  (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] === this.customLabelLG.Label.percent && !isNaN(obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]])) ? obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] + '%' :
                    (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] === undefined) ?
                      obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] : (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && isNaN(obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]])) ?
                        obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] : this.customLabelLG.Label.Hyphen_Value : this.customLabelLG.Label.Not_Applicable;
              this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.unshift({ 'val': recordValue, 'color': '' });
            }
          }
        }
      }
    }
    else {
      this.planDataToDislay.topRow[0] = { 'id': obj.Id, 'name': obj.Competitor_Name__c + ' ' + obj.Plan_Name__c };
      for (let key in this.planDataToDislay.categoryData) {
        if (this.planDataToDislay.categoryData[key]) {
          for (let data in this.planDataToDislay.categoryData[key].lstSectionValue) {
            if (this.planDataToDislay.categoryData[key]) {
              let name = this.planDataToDislay.categoryData[key].sectionName + this.planDataToDislay.categoryData[key].lstSectionValue[data].Name;
              let recordValue = this.dataMap[name] !== undefined ?
                (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] === this.customLabelLG.Label.currency && !isNaN(obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]])) ? '$' + obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] :
                  (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] === this.customLabelLG.Label.percent && !isNaN(obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]])) ? obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] + '%' :
                    (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && this.dataMap[name][this.customLabelLG.Label.Benefit_Datatype] === undefined) ?
                      obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] :
                      (obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] !== undefined && isNaN(obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]])) ?
                        obj[this.dataMap[name][this.customLabelLG.Label.Benefit_Api_Name]] : this.customLabelLG.Label.Hyphen_Value : this.customLabelLG.Label.Not_Applicable;
              this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0] = ({ 'val': recordValue, 'color': '' });
            }
          }
        }
      }
    }
    this.clonedData = JSON.parse(JSON.stringify(this.planDataToDislay.categoryData));
    this.isBenefitSelected = true;
    this.value = event.detail;
  }
  /*
  Method Name : showCustomErrorModal
  Description: For showing the ErroModalPopup for no benefit records
  Paramerter:
  */
  showCustomErrorModal() {
    const toastModal = this.template.querySelector('[data-id="toastModal"]');
    toastModal.className = 'slds-show';
  }
  /*
  Method Name : handleSelect
  Description: For handling the selected and deselected plans in LWC plan compare screen. 
  Paramerter:Event
  */
  handleSelect(event) {
    const clickedPlanId = event.detail;
    let chosen_plan_index_arr = [];
    let chosen_plan = this.planDataToDislay.topRow.filter((plan, index) => {
      if (plan.id === clickedPlanId) {
        chosen_plan_index_arr.push(index)
        return plan
      }
    })[0]
    if (clickedPlanId in this.selectedDeselectedDictionary) {
      delete this.selectedDeselectedDictionary[clickedPlanId]
      if (!chosen_plan.productData.selected) {
        chosen_plan.productData.selected = true;
      } else {
        delete chosen_plan.productData.selected;
      }
    }
    else {
      if (!chosen_plan.productData.selected) {
        chosen_plan.productData.selected = true;
        this.selectedDeselectedDictionary[clickedPlanId] = this.customLabelLG.Label.selected;
      } else {
        this.selectedDeselectedDictionary[clickedPlanId] = this.customLabelLG.Label.deselected;
        delete chosen_plan.productData.selected;
      }
    }
    this.planDataToDislay.topRow[chosen_plan_index_arr[0]] = chosen_plan
    this.planDataToDislay.topRow = [...this.planDataToDislay.topRow]
  }
  /*
  Method Name : handleRemovePlanComparison
  Description: For removing plans from comparison screen(LWC)
  Paramerter:Event
  */
  handleRemoveFromComparision(event) {
    let planTarget = event.detail;
    this.planDataToDislay.topRow.splice(planTarget, 1);
    for (let key in this.planDataToDislay.categoryData) {
      if (this.planDataToDislay.categoryData) {
        for (let data in this.planDataToDislay.categoryData[key].lstSectionValue) {
          if (this.planDataToDislay.categoryData[key].lstSectionValue) {
            if (!this.isDifference) {
              this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.splice(planTarget, 1);
            }
            else if (this.isDifference && event.detail != undefined && event.detail != 0) {
              this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.splice(planTarget, 2);
              let updatedRecValues = JSON.parse(JSON.stringify(this.planDataToDislay.categoryData));
              this.planDataToDislay.categoryData = JSON.parse(JSON.stringify(this.clonedData));
              this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.splice(planTarget, 1);
              this.clonedData = JSON.parse(JSON.stringify(this.planDataToDislay.categoryData));
              this.planDataToDislay.categoryData = JSON.parse(JSON.stringify(updatedRecValues));
            }
            else if (this.isDifference && event.detail !== undefined && event.detail == 0) {
              this.planDataToDislay.categoryData = JSON.parse(JSON.stringify(this.clonedData));
              this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.splice(planTarget, 1);
              this.isDifference = false;
            }
          }
        }
      }
    }
    if (this.selectedPicklistId != undefined) {
      for (let i = 0; i < this.planDataToDislay.topRow.length; i++) {
        if (this.planDataToDislay.topRow[i].id === this.selectedPicklistId) {
          this.isBenefitSelected = true;
          break;
        }
        else {
          this.isBenefitSelected = false;
          this.isDifference = false;
          this.value = null;
        }
      }
    }
    if (this.planDataToDislay.topRow.length === 1 && this.isBenefitSelected) {
      this.closeModal();
    }
    else if (this.planDataToDislay.topRow.length === 0) {
      this.closeModal();
    }
    else if(this.planDataToDislay.topRow.length===1 && this.placeHolder==this.customLabelLG.Label.No_Competitor_Data_available){
      this.closeModal();
    }
    else if(!this.isDropDown && this.planDataToDislay.topRow.length === 1){
      this.closeModal();
    }
  }
  /*
  Method Name : handleDifference
  Description: For finding the difference between benefit plan and anthem plan
  Paramerter:
  */
  handleDifference(event) {
    if (event.detail) {
      let diffValues;
      for (let key in this.planDataToDislay.categoryData) {
        if (this.planDataToDislay.categoryData[key]) {
          for (let data in this.planDataToDislay.categoryData[key].lstSectionValue) {
            if (this.planDataToDislay.categoryData[key]) {
              let len = this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.length;
              let indexDiffValue = 2;
              let indexPlanValue = 1;
              for (let a = 1; a < len; a++) {
                if (this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val.includes('$')) {
                  diffValues = (((this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[indexPlanValue].val).replace('$', '')) -
                    ((this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val).replace('$', '')));
                }
                else if (this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val.includes('%')) {
                  diffValues = (((this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[indexPlanValue].val).replace('%', '')) -
                    ((this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val).replace('%', '')));
                }
                else if (!this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val.includes('%') &&
                  !this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val.includes('$')) {
                  if (!this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[indexPlanValue].val.includes('%') &&
                    !this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[indexPlanValue].val.includes('$')) {
                    diffValues = ((this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[indexPlanValue].val) -
                      (this.planDataToDislay.categoryData[key].lstSectionValue[data].Value[0].val));
                  } else {
                    diffValues = NaN;
                  }
                }
                indexPlanValue = indexPlanValue + 2;
                let recValue = JSON.stringify(this.planDataToDislay.categoryData[key].lstSectionValue[data].Value);
                this.planDataToDislay.categoryData[key].lstSectionValue[data].Value.splice(indexDiffValue, 0,
                  isNaN(diffValues) ? { 'val': '', 'color': '' }
                    : (diffValues == null && (!recValue.includes('$'))) ? { 'val': 'aaa', 'color': '' }
                    : (diffValues == 0 && (!recValue.includes('$'))) ? { 'val': '-', 'color': 'black-color' }
                    : (diffValues == 0 && (!recValue.includes('%'))) ? { 'val': '-', 'color': 'black-color' }
                      : diffValues == 0 && (recValue.includes('$')) ? { 'val': '-', 'color': 'black-color' }
                        : diffValues == 0 && (recValue.includes('%')) ? { 'val': '-', 'color': 'black-color' }
                          : diffValues < 0 && recValue.includes('$') ? { 'val': '$' + Math.abs(diffValues) + ' Less', 'color': 'green-text' }
                            : diffValues < 0 && recValue.includes('%') ? { 'val': Math.abs(diffValues) + '%' + ' Less', 'color': 'green-text' }
                              : diffValues > 0 && recValue.includes('%') ? { 'val': diffValues + '%' + ' More', 'color': 'red-text' }
                                : diffValues > 0 && recValue.includes('$') ? { 'val': '$' + diffValues + ' More', 'color': 'red-text' }
                                  : diffValues > 0 && !recValue.includes('$') ? { 'val': diffValues + ' More', 'color': 'red-text' }
                                    : diffValues > 0 && !recValue.includes('%') ? { 'val': diffValues + ' More', 'color': 'red-text' }
                                      : diffValues < 0 && !recValue.includes('%') ? { 'val': Math.abs(diffValues) + ' Less', 'color': 'green-text' }
                                        : diffValues < 0 && !recValue.includes('$') ? { 'val': Math.abs(diffValues) + ' Less', 'color': 'green-text' }
                                          : diffValues);
                this.isDifference = true;
                indexDiffValue = indexDiffValue + 2;
              }
            }
          }
        }
      }
    }
    else {
      this.planDataToDislay.categoryData = JSON.parse(JSON.stringify(this.clonedData));
      this.isDifference = false;
    }
  }
  /*
  Method Name : closeModal
  Description: For closing the modalPopUp and to pass the data back to Vlocity
  Paramerter:
  */
  closeModal() {
    this.dispatchEvent(new CustomEvent('plans_from_lwc',
      {
        detail: { closeWindow: true, change_dictionary: this.selectedDeselectedDictionary },
        bubbles: true,
        composed: true,
      }));
    this.selectedDeselectedDictionary = {};
    this.listBenefitRecords = [];
    this.value = null;
    if (this.isDifference) {
      this.isDifference = false;
      this.planDataToDislay.categoryData = JSON.parse(JSON.stringify(this.clonedData));
    }
    const toastModal = this.template.querySelector('[data-id="toastModal"]');
    toastModal.className = 'slds-hide';
    this.closeErrorModal();
  }

  /*
  Method Name : closeErrorModal
  Description: For closing the ErroModalPopup
  Paramerter:
  */
  closeErrorModal() {
    const toastModal = this.template.querySelector('[data-id="toastModal"]');
    toastModal.className = 'slds-hide';
  }
  /*
    Method Name : customLabelLG
    Description: For getting the Custom Labels
    Paramerter:
    */
  get customLabelLG() {
    return fetchCustomLabels;
  }
  /*
   Method Name : headerFillerClass
   Description: For Header Styling 
   Paramerter:
   */
  get headerFillerClass() {
    const filler_width = this.planDataToDislay.topRow.length + 2
    return "slds-large-size--2-of-" + filler_width + " slds-large-show"
  }
  /*
    Method Name : inner_container_class
    Description: For Header Styling 
    Paramerter:
    */
  get inner_container_class() {
    if (this.planDataToDislay.topRow.length === 1) {
      return "vloc-ins-product-details-compare-modal-container single-product"
    }
    return "vloc-ins-product-details-compare-modal-container"
  }
  /*
    Method Name : tableLabels
    Description: For Labels Styling 
    Paramerter:
    */
  get tableLabels() {
    const filler_width = this.planDataToDislay.topRow.length + 2;
    return "slds-large-size--2-of-" + filler_width + " slds-size--1-of-1 slds-truncate label"
  }
}
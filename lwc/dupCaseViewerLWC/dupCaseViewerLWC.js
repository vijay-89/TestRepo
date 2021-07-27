import { LightningElement, wire, api, track } from 'lwc';
import getDupRecords from '@salesforce/apex/DupCaseViewerController.getDupRecords';
import ComponentTitle from '@salesforce/label/c.DupCaseViewer_Title'; 
import ModalTitle from '@salesforce/label/c.DupCaseViewer_ModalTitle'; 

const columns = [
    {label: 'Case', fieldName: 'URL', initialWidth: 100, type: 'url', typeAttributes: {label: {fieldName: 'CaseNumber'}, tooltip:"Open Case Record", target:"_blank"}, sortable:"true"},
    {label: 'Status', fieldName: 'Status', sortable:"true"},
    {label: 'Created Date', fieldName: 'CreatedDate', type: 'date', sortable:"true"}, 
    {label: 'Last Modified Date', fieldName: 'LastModifiedDate', type: 'date', sortable:"true"}, 
]; 

const modalColumns = [
    {label: 'Case', fieldName: 'URL', initialWidth: 110, type: 'url', typeAttributes: {label: {fieldName: 'CaseNumber'}, tooltip:"Open Case Record", target:"_blank"}, sortable:"true"},
    {label: 'Subject', fieldName: 'Subject', sortable:"true"},
    {label: 'Status', fieldName: 'Status', initialWidth: 150, sortable:"true"},
    {label: 'Contact Name', fieldName: 'ContactName', initialWidth: 160, sortable:"true"},
    {label: 'Prospect/Customer', fieldName: 'ProspectCustomer', initialWidth: 160, sortable:"true"},
    {label: 'Requested Effective Date', fieldName: 'RequestedEffectiveDate', type: 'date', initialWidth: 160, sortable:"true"}, 
    {label: 'Created Date', fieldName: 'CreatedDate', type: 'date', initialWidth: 160, sortable:"true"}, 
    {label: 'Last Modified Date', fieldName: 'LastModifiedDate', type: 'date', initialWidth: 160, sortable:"true"}, 
]; 

export default class DupCaseViewerLWC extends LightningElement 
{
    @api recordId; 
    cases; 
    allCases; 
    error;

    @track columns = columns; 
    @track modalColumns = modalColumns; 
    @track sortBy; 
    @track sortDirection; 
    @track openmodel = false;

    customLabels = {
        ComponentTitle, 
        ModalTitle, 
    }; 

    @wire(getDupRecords, {recordId:'$recordId'})
    wiredCases({ error, data }) 
    {
        if (data) 
        {
            let counter = 0; 
            this.cases = new Array(); 
            this.allCases = new Array(); 
            for(var key in data)
            {
                var obj = new Object(); 
                obj.Id = data[key].Id; 
                obj.CaseNumber = data[key].CaseNumber; 
                obj.Status = data[key].Status; 
                obj.CreatedDate = data[key].CreatedDate;
                obj.LastModifiedDate = data[key].LastModifiedDate; 
                obj.URL = '/' + data[key].Id;
                obj.Subject = data[key].Subject; 
                obj.ContactName = data[key].Contact.FirstName + ' ' + data[key].Contact.LastName; 
                obj.ProspectCustomer = data[key].Prospect_Customer_Name__c; 
                
                obj.RequestedEffectiveDate = new Date(data[key].Requested_Effective_Date__c); 
                obj.RequestedEffectiveDate.setDate(obj.RequestedEffectiveDate.getDate() + 1);

                if(counter < 5)
                {
                    this.cases.push(obj);
                }
                this.allCases.push(obj); 

                counter++; 
            }
            this.error = undefined;
        } 
        else if (error) 
        {
            this.error = error;
            this.cases = undefined;
            this.allCases = undefined; 
        }
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName; 
        this.sortDirection = event.detail.sortDirection; 
        this.sortData(this.sortBy, this.sortDirection); 
    }

    sortData(fieldName, direction) {
        let parseData = JSON.parse(JSON.stringify(this.cases)); 
        let keyValue = (a) => {
            return a[fieldName]; 
        }; 
        let isReverse = direction === 'asc' ? 1: -1; 
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; 
            y = keyValue(y) ? keyValue(y) : ''; 
            return isReverse * ((x > y) - (y > x));
        });
        this.cases = parseData; 
    }

    openmodal() {
        this.openmodel = true
    }
    closeModal() {
        this.openmodel = false
    } 
    saveMethod() {
        this.closeModal();
    }
}
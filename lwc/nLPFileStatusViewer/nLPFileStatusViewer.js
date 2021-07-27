import { LightningElement, wire, api, track } from 'lwc';
import getNLPRecords from '@salesforce/apex/NLPFileStatusViewerController.getNLPFileStatus';
import statusImageAnnouncement from '@salesforce/resourceUrl/NLPStatusImageAnnouncement';
import NLPFileStatusViewer_ComponentTitle from '@salesforce/label/c.NLPFileStatusViewer_ComponentTitle'; 
import NLPFileStatusViewer_ComponentTitle_CreatedDate from '@salesforce/label/c.NLPFileStatusViewer_ComponentTitle_CreatedDate'; 
import NLPFileStatusViewer_ComponentTitle_Details from '@salesforce/label/c.NLPFileStatusViewer_ComponentTitle_Details'; 
import NLPFileStatusViewer_ComponentTitle_FileName from '@salesforce/label/c.NLPFileStatusViewer_ComponentTitle_FileName'; 
import NLPFileStatusViewer_ComponentTitle_Status from '@salesforce/label/c.NLPFileStatusViewer_ComponentTitle_Status'; 
import NLPFileStatusViewer_ComponentTitle_TrackingName from '@salesforce/label/c.NLPFileStatusViewer_ComponentTitle_TrackingName'; 
import NLPFileStatusViewer_StatusStringColor_Default from '@salesforce/label/c.NLPFileStatusViewer_StatusStringColor_Default'; 
import NLPFileStatusViewer_StatusStringColor_Error from '@salesforce/label/c.NLPFileStatusViewer_StatusStringColor_Error'; 
import NLPFileStatusViewer_StatusStringColor_Success from '@salesforce/label/c.NLPFileStatusViewer_StatusStringColor_Success'; 
import NLPFileStatusViewer_StatusString_Error from '@salesforce/label/c.NLPFileStatusViewer_StatusString_Error'; 
import NLPFileStatusViewer_StatusString_Success from '@salesforce/label/c.NLPFileStatusViewer_StatusString_Success'; 
import NLPFileStatusViewer_StatusString_Unsupported from '@salesforce/label/c.NLPFileStatusViewer_StatusString_Unsupported'; 

export default class NLPFileStatusViewer extends LightningElement
{
    @api recordId; 
    files;
    allFiles; 
    error;

    announcementImage = statusImageAnnouncement; 

    customLabels = {
        NLPFileStatusViewer_ComponentTitle, 
        NLPFileStatusViewer_ComponentTitle_CreatedDate, 
        NLPFileStatusViewer_ComponentTitle_Details, 
        NLPFileStatusViewer_ComponentTitle_FileName, 
        NLPFileStatusViewer_ComponentTitle_Status, 
        NLPFileStatusViewer_ComponentTitle_TrackingName, 
    }; 

    @track openmodel = false;

    @wire(getNLPRecords, {recordId:'$recordId'})
    wiredFiles({ error, data }) 
    {

        if (data) 
        {
            let counter = 0; 
            this.files = new Array();
            this.allFiles = new Array(); 
            for(var key in data)
            {
                var obj = new Object(); 
                obj.Id = data[key].Id; 

                obj.FileId = data[key].ContentDocumentId; 
                if(data[key].ContentDocument.Title.length <= 10) {
                    obj.FileName = data[key].ContentDocument.Title;
                } else {
                    obj.FileName = data[key].ContentDocument.Title.substring(0, 10); 
                    obj.FileName += '...'; 
                } 
                obj.FullFileName = data[key].ContentDocument.Title;
                obj.FileURL = '/' + data[key].ContentDocumentId;
                if(typeof data[key].Request_Tracking_ID__c === 'undefined') {
                    obj.TrackingId = null;
                    obj.TrackingName = null;
                    obj.TrackingURL = null;
                } else {
                    obj.TrackingId = data[key].Request_Tracking_ID__c;
                    obj.TrackingName = data[key].Request_Tracking_Name__c; 
                    obj.TrackingURL = '/' + data[key].Request_Tracking_ID__c;    
                }
                obj.Status = data[key].Response_Status__c;

                var regexError = new RegExp(NLPFileStatusViewer_StatusString_Error, "i"); 
                var regexUnsupported = new RegExp(NLPFileStatusViewer_StatusString_Unsupported, "i"); 
                var regexSuccess = new RegExp(NLPFileStatusViewer_StatusString_Success, "i"); 
                obj.StatusTextColor = NLPFileStatusViewer_StatusStringColor_Default;
                if(regexError.test(obj.Status) || regexUnsupported.test(obj.Status))
                {
                    obj.StatusTextColor = NLPFileStatusViewer_StatusStringColor_Error; 
                } else if(regexSuccess.test(obj.Status)) {
                    obj.StatusTextColor = NLPFileStatusViewer_StatusStringColor_Success; 
                }
                obj.ErrorMessage = data[key].Error_Message__c; 
                obj.CreatedDate = data[key].CreatedDate; 
                
                if(counter < 5)
                {
                    this.files.push(obj); 
                }
                this.allFiles.push(obj); 

                counter++; 
            }

            this.error = undefined;
        } 
        else if (error) 
        {
            this.error = error;
            this.files = undefined;
        }
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
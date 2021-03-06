import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import logo from '@salesforce/resourceUrl/surveyMonkey_logo';
import getQuestionList from '@salesforce/apex/getQuestions.getQuestionList';
import createUserSurvey from '@salesforce/apex/createSurvey.createUserSurvey';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import NAME_FIELD from '@salesforce/schema/Template__c.Name';
import Id from '@salesforce/user/Id';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

const FIELDS = [
    NAME_FIELD,
];

export default class TakeSurvey extends NavigationMixin(LightningElement) {
    surveyMonkeyLogo = logo;
    userId = Id;
    questions = [];

    //Get template ID from URL param
    @track recordId;
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            const urlValue = currentPageReference.state.c__recordId;
            if (urlValue) {
                this.recordId = urlValue;
            } else {
                this.recordId = `URL Value was not set`;
            }
        }
    }

    //Get template Name
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    templates;

    get name() {
        return getFieldValue(this.templates.data, NAME_FIELD);
    }

    connectedCallback(){
        getQuestionList({recordId: this.recordId}).then(res => {
            let parsedRes = JSON.parse(res);

            if (parsedRes.isSuccess) {
              this.questions = parsedRes.results.questions;
            } else {
               console.log(error);
            }
        }).catch((error) => {
            console.log(error);
        });
    }

    //Get questions and respective answers
    //@wire(getQuestionList, { Id: '$recordId' })
    //questions;

    //Checkbox storage
    @track index;
    @track Values;
    @track SelectedValues = [];
    handleCheckBoxChange(event) {
        this.Values =  event.target.value;
        if (event.target.checked) {
            this.SelectedValues.push( this.Values );
        } else {
            try {
                this.index = this.SelectedValues.indexOf( this.Values );
                this.SelectedValues.splice(this.index, 1);
            } catch (err) {
                console.log(error);
            }
        }
     }

     //Handle submission on button click
     handleOnClick(event) {
         let self = this;
        createUserSurvey({recordId: this.recordId, answers: this.SelectedValues, userId: this.userId}).then(result => {
            
            //Checkbox reset
            let checkboxes = self.template.querySelectorAll('[data-id="checkbox"]');
            if(checkboxes.length > 0) {
                checkboxes.forEach(element=> {
                    element.checked = false;
                });
            }

            //Toast
            const event = new ShowToastEvent({
                title: 'Survey Submitted',
                message: 'You can now view it in the "Personal Surveys" tab.',
                variant: 'success'
            });
            this.dispatchEvent(event);
            //Change Page
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Template__c',
                    actionName: 'view'
                }
            });

        }).catch(error => {
            //Error toast
            const event = new ShowToastEvent({
                title : 'Error',
                message : error.message ? error.message : error,
                variant : 'error'
            });
            console.log(error);
            this.dispatchEvent(event);
        });
    }
}
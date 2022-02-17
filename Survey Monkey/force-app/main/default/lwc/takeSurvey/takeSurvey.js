import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import logo from '@salesforce/resourceUrl/surveyMonkey_logo';
import getQuestionList from '@salesforce/apex/getQuestions.getQuestionList';
import createUserSurvey from '@salesforce/apex/createSurvey.createUserSurvey';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import NAME_FIELD from '@salesforce/schema/Template__c.Name';

const FIELDS = [
    NAME_FIELD,
];

export default class TakeSurvey extends NavigationMixin(LightningElement) {
    surveyMonkeyLogo = logo;

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
    template;

    get name() {
        return getFieldValue(this.template.data, NAME_FIELD);
    }

    //Get questions and respective answers
    @wire(getQuestionList, { Id: '$recordId' })
    questions;

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
        createUserSurvey({recordId: this.recordId, answers: this.SelectedValues}).then(result => {
            const event = new ShowToastEvent({
                title: 'Survey Submitted',
                message: 'You can now view it in the "Personal Surveys" tab.',
                variant: 'success'
            });
            this.dispatchEvent(event);
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title : 'Error',
                    message : 'Error submitting survey...',
                    variant : 'error'
                });
                console.log(error);
                this.dispatchEvent(event);
            });

            //Change Page
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Template__c', // objectApiName is optional
                    actionName: 'view'
                }
            });
    }
}

//TODO or ?s

//Q# Size and formatting
//$recordId thing --> fixed
//How to view other peoples surveys
//Getting user answers --> fixed, needs optimization
//Page redirect to survey template page? --> Done
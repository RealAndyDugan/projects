import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import logo from '@salesforce/resourceUrl/surveyMonkey_logo';
import getQuestionList from '@salesforce/apex/getQuestions.getQuestionList';
import getTemplateList from '@salesforce/apex/getTemplate.getTemplateList';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Template__c.Name';

const FIELDS = [
    NAME_FIELD,
];

export default class TakeSurvey extends LightningElement {
    surveyMonkeyLogo = logo;
    //Get template param
    //@api recordId;
    @track recordId;
    //@track template;
    //@track questions;
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

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    template;

    get name() {
        return getFieldValue(this.template.data, NAME_FIELD);
    }



}
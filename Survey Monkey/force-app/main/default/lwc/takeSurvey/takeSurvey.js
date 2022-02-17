import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import logo from '@salesforce/resourceUrl/surveyMonkey_logo';
import getQuestionList from '@salesforce/apex/getQuestions.getQuestionList';
import getTemplateList from '@salesforce/apex/getTemplate.getTemplateList';
import { getRecord } from 'lightning/uiRecordApi';

export default class TakeSurvey extends LightningElement {
    surveyMonkeyLogo = logo;
    //Get template param
    @api recordId;
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

    @wire(getTemplateList, { Id: '$recordId' })
    template;
    
}
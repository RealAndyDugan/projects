import { LightningElement, track } from 'lwc';

import logo from '@salesforce/resourceUrl/surveyMonkey_logo';

export default class ViewAllResponses extends LightningElement {
    surveyMonkeyLogo = logo;

    @track customerSurveyOpen = false;

    get customerSurveyIconName() {
        return 'utility:' + (this.customerSurveyOpen ? 'chevrondown' : 'chevronright');
    }

    get customerSurveyClassList() {
        return this.customerSurveyOpen ? 'slds-section__content slds-p-horizontal_medium' : 'slds-hide';
    }

    customerSurveyButtonClick() {
        this.customerSurveyOpen = !this.customerSurveyOpen;
    }
}
import { LightningElement, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getAllSurveysList from '@salesforce/apex/getAllSurveys.getAllSurveysList';

import logo from '@salesforce/resourceUrl/surveyMonkey_logo';

export default class ViewAllResponses extends LightningElement {
    surveyMonkeyLogo = logo;

    @track customerSurveyOpen = false;

    get customerSurveyIconName() {
        return 'utility:' + 'chevronright';
    }

    get customerSurveyClassList() {
        return 'slds-hide';
    }

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

    customerSurveyButtonClick(event) {
        // VVV
        let index = event.currentTarget.dataset.index;
        let survey = this.surveys.data[index];
        // ^^^
        let htmlIndex = '[data-survey-id="' + survey.Id + '"]';
        if(this.template.querySelector(htmlIndex).classList.contains('slds-hide')) {
            this.template.querySelector(htmlIndex).classList.remove("slds-hide");
            this.template.querySelector(htmlIndex).classList.add(["slds-section__content", "slds-p-horizontal_medium"]);
        } else if (this.template.querySelector(htmlIndex).classList.contains('slds-section__content,slds-p-horizontal_medium')){
            this.template.querySelector(htmlIndex).classList.remove(["slds-section__content", "slds-p-horizontal_medium"]);
            this.template.querySelector(htmlIndex).classList.add("slds-hide");
        }
        let buttonIndex = '[data-button="' + survey.Id + '"]';
        if(this.template.querySelector(buttonIndex).iconName == 'utility:chevronright') {
            this.template.querySelector(buttonIndex).iconName = "utility:chevrondown";
        } else if (this.template.querySelector(buttonIndex).iconName == 'utility:chevrondown'){
            this.template.querySelector(buttonIndex).iconName = "utility:chevronright";
        }
        this.customerSurveyOpen = !this.customerSurveyOpen;
    }

    @wire(getAllSurveysList, { recordId: '$recordId' })
    surveys;
}
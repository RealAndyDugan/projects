import { LightningElement, track, wire } from 'lwc';
import Id from '@salesforce/user/Id';
import logo from '@salesforce/resourceUrl/surveyMonkey_logo';
import getSurveyList from '@salesforce/apex/getSurveys.getSurveyList';

export default class ViewMyResponses extends LightningElement {
    surveyMonkeyLogo = logo;
    userId = Id;
    @track customerSurveyOpen = false;

    get customerSurveyIconName() {
        return 'utility:' + 'chevronright';
    }

    get customerSurveyClassList() {
        return 'slds-hide';
    }

    //get customerSurveyClassList() {
    //    return this.customerSurveyOpen ? 'slds-section__content slds-p-horizontal_medium' : 'slds-hide';
    //}


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

    //*****************************************//

    @wire(getSurveyList, { Id: '$userId' })
    surveys;
}
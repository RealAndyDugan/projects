import { LightningElement, track } from 'lwc';
import Id from '@salesforce/user/Id';
import logo from '@salesforce/resourceUrl/surveyMonkey_logo';

export default class ViewMyResponses extends LightningElement {
    surveyMonkeyLogo = logo;
    userId = Id;
    @track customerSurveyOpen = false;
    @track productReviewOpen = false;

    get customerSurveyIconName() {
        return 'utility:' + (this.customerSurveyOpen ? 'chevrondown' : 'chevronright');
    }

    get productReviewIconName() {
        return 'utility:' + (this.productReviewOpen ? 'chevrondown' : 'chevronright');
    }

    get customerSurveyClassList() {
        return this.customerSurveyOpen ? 'slds-section__content slds-p-horizontal_medium' : 'slds-hide';
    }

    get productReviewClassList() {
        return this.productReviewOpen ? 'slds-section__content slds-p-horizontal_medium' : 'slds-hide';
    }

    customerSurveyButtonClick() {
        this.customerSurveyOpen = !this.customerSurveyOpen;
    }

    productReviewButtonClick() {
        this.productReviewOpen = !this.productReviewOpen;
    }

    //*****************************************//


}
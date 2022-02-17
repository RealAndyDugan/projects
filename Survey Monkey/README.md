# Training App

## Getting Started
* Clone this repo and create your own private repo that mirrors it
* Create a scratch org and push
* Check out the Survey Monkey Design App

## Specifications
* https://docs.google.com/document/d/1Cic3WnUG6vkI4SJZHmImuLRU90knvrtDiL2-GaOrPME/edit?usp=sharing

<!-- Response -->
                            <div class="slds-text-heading_small slds-m-left_medium">
                                <div class="col">
                                    <lightning-input id="checkbox-1"
                                                     type="checkbox"
                                                     label="Awesome">
                                    </lightning-input>
                                </div>
                            </div>




                                                                <template if:true={answers.data}>
                                        <template for:each={answers.data} for:item="answer">
                                            <div key={answer.Question__c.ID} class="slds-text-heading_small slds-m-left_medium">
                                                <div class="col">
                                                    <lightning-input    
                                                        id={answer.ID}
                                                        type="checkbox"
                                                        label={answer.Name}>
                                                    </lightning-input>
                                                </div>
                                            </div>
                                        </template>
                                    </template>
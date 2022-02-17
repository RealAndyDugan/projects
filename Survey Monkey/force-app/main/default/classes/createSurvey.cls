public with sharing class createSurvey {
    @AuraEnabled
    public static User_Survey__c createUserSurvey(ID recordId, List<ID> answers) {
        
        List<Template__c> cheese = [SELECT Name FROM Template__c WHERE ID = :recordId LIMIT 1];
        
        User_Survey__c newSurvey = new User_Survey__c (
            Name = cheese.get(0).Name, 
            Template__c = cheese.get(0).ID
        );

        insert newSurvey;
        
        //system.debug('survey'+survey);
        if(answers.size() != 0){
        for(ID ans : answers) {
            //system.debug('ans'+ans);
            List<Answer__c> answer = [SELECT Name FROM Answer__c WHERE ID = :ans LIMIT 1];
            User_Answer__c newAnswer = new User_Answer__c (
                Name = answer.get(0).Name,
                User_Survey__c = newSurvey.ID,
                Answer__c = answer.get(0).ID,
                Checked__c = true
            );
            insert newAnswer;
        }}

        return newSurvey;
    }
}
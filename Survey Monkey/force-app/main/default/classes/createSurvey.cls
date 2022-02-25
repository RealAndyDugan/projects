public with sharing class createSurvey {
    @AuraEnabled
    public static User_Survey__c createUserSurvey(ID recordId, List<ID> answers, ID userId) {
        
        Template__c template = [SELECT Name FROM Template__c WHERE ID = :recordId LIMIT 1];
        List<Question__c> questionsDB = [SELECT ID, Name, Position__c, Template__c FROM Question__c WHERE Template__r.ID = :recordID];
        List<Answer__c> answersDB = [SELECT ID, Name, Position__c, Question__c FROM Answer__c WHERE Question__c IN :questionsDB];

        User_Survey__c newSurvey = new User_Survey__c (
            Name = template.Name, 
            User__c = userId,
            Template__c = template.ID
        );

        insert newSurvey;
        
        if(answers.size() != 0){
        for(ID ans : answers) {
            for(Answer__c dbAns : answersDB) {
                if(ans == dbAns.ID) {
                    Question__c theQuestion = new Question__c();
                    for(Question__c ques : questionsDB) {
                        if(ques.ID == dbAns.Question__c) {
                            theQuestion = ques;
                        }
                    }
                    User_Answer__c newAnswer = new User_Answer__c (
                        Name = dbAns.Name,
                        User_Survey__c = newSurvey.ID,
                        Answer__c = dbAns.ID,
                        Checked__c = true,
                        //QuesPos and QuesName are not being queried correctly
                        QuestionPosition__c = theQuestion.Position__c,
                        QuestionName__c = theQuestion.Name,
                        AnswerPosition__c = dbAns.Position__c,
                        AnswerName__c = dbAns.Name
                    );
            
                    insert newAnswer;
                }
            }
        }}

        return newSurvey;
    }
}
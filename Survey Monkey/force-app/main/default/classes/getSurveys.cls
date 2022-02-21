public with sharing class getSurveys {
    
    List<User_Survey__c> surveys;
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getSurveyList(ID Id) {
        //List of survey objects
        List<Map<String, Object>> surveys = new List<Map<String, Object>>();
        //List of surveys from DB, unformatted and without any questions or answers
        List<User_Survey__c> dbSurveys = [SELECT ID, Name, CreatedDate FROM User_Survey__c WHERE CreatedById = :Id ORDER BY CreatedDate DESC];
        //List of questions from DB
        List<User_Answer__c> dbQuestions = [SELECT ID, questionSnap__c, User_Survey__c, questionPos__c FROM User_Answer__c WHERE CreatedById = :Id ORDER BY questionPos__c];
        //List of answers from DB
        List<User_Answer__c> dbAnswers = [SELECT ID, answerSnap__c, questionSnap__c, User_Survey__c FROM User_Answer__c WHERE CreatedById = :Id ORDER BY answerPos__c];

        for(User_Survey__c survey : dbSurveys) {
            Map<String, Object> surv = new Map<String, Object>();
            surv.put('Id', survey.Id);
            surv.put('name', survey.Name);
            surv.put('date', formatDate(survey.CreatedDate));
            List<Map<String, Object>> questions = new List<Map<String, Object>>();
            List<String> iterated = new List<String>();
            for(User_Answer__c q : dbQuestions) {
                Map<String, Object> question = new Map<String, Object>();
                
                if(iterated.contains(q.questionSnap__c) == false && q.User_Survey__c == survey.ID) {
                    iterated.add(q.questionSnap__c);
                    question.put('name', q.questionSnap__c);
                    //Something wrong here
                    question.put('position', q.questionPos__c);
                    // ^^^^
                    List<String> allAnswers = new List<String>();
                    for(User_Answer__c a : dbAnswers) {
                        //If statement errors out for some reason
                        if(a.questionSnap__c == q.questionSnap__c && a.User_Survey__c == survey.ID) {
                            allAnswers.add(a.answerSnap__c);
                        }
                    }
                    String finalAnswers = String.join(allAnswers,', ');
                    question.put('answers', finalAnswers);
                    questions.add(question);
                    surv.put('questions', questions);
                }
                
            }

            
            surveys.add(surv);
        }
        
        return surveys;

    }

    //Format Date
    public static Datetime formatDate(Datetime theDate) {
        Datetime formatted = theDate;
        return formatted;
    }
    
}
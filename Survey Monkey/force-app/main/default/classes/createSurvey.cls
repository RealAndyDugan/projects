public with sharing class createSurvey {
    @AuraEnabled
    public static User_Survey__c createUserSurvey(ID recordId, List<ID> answers, ID userId) {
        
        Template__c template = [SELECT Name FROM Template__c WHERE ID = :recordId LIMIT 1];
        List<Question__c> questionsDB = [SELECT ID, Name, Position__c, Template__c FROM Question__c WHERE Template__r.ID = :recordId];
        List<Answer__c> answersDB = [SELECT ID, Name, Position__c, Question__c FROM Answer__c WHERE Question__c IN :questionsDB];

        User_Survey__c newSurvey = new User_Survey__c (
            Name = template.Name, 
            User__c = userinfo.getUserId(),
            Template__c = template.ID
        );
        dmlManager.checkAccess(new Map<String, Map<String, Set<String>>> {
            'User_Survey__c' => new Map<String, Set<String>> {
                'Create' => new Set<String> {
                    'Name',
                    'User__c',
                    'Template__c'
                }
            }
        });
        insert newSurvey;
        createUserAnswers(answers, questionsDB, answersDB, newSurvey);

        return newSurvey;
    }

    @AuraEnabled
    public static List<User_Answer__c> createUserAnswers(List<ID> answers, List<Question__c> questionsDB, List<Answer__c> answersDB, User_Survey__c newSurvey) {
        List<User_Answer__c> submissions = new List<User_Answer__c>();
        List<ID> iterated = new List<ID>();
        for(Answer__c answer : answersDB) {
            if(answers.contains(answer.ID)) {
                Question__c question = new Question__c();
                for(Question__c q : questionsDB) {
                    if(q.ID == answer.Question__c) {
                        question = q;
                    }
                }
                User_Answer__c newAnswer = new User_Answer__c (
                    Name = answer.Name,
                    User_Survey__c = newSurvey.ID,
                    Answer__c = answer.ID,
                    Checked__c = true,
                    QuestionPosition__c = question.Position__c,
                    QuestionName__c = question.Name,
                    AnswerPosition__c = answer.Position__c,
                    AnswerName__c = answer.Name
                );
                submissions.add(newAnswer);
                dmlManager.checkAccess(new Map<String, Map<String, Set<String>>> {
                    'User_Answer__c' => new Map<String, Set<String>> {
                        'Create' => new Set<String> {
                            'Name',
                            'User_Survey__c',
                            'Answer__c',
                            'Checked__c',
                            'QuestionPosition__c',
                            'QuestionName__c',
                            'AnswerPosition__c',
                            'AnswerName__c'
                        }
                    }
                });
                insert newAnswer;
            }
            else {
                Question__c question = new Question__c();
                for(Question__c q : questionsDB) {
                    if(q.ID == answer.Question__c) {
                        question = q;
                    }
                }
                User_Answer__c newAnswer = new User_Answer__c (
                    Name = answer.Name,
                    User_Survey__c = newSurvey.ID,
                    Answer__c = answer.ID,
                    Checked__c = false,
                    QuestionPosition__c = question.Position__c,
                    QuestionName__c = question.Name,
                    AnswerPosition__c = answer.Position__c,
                    AnswerName__c = answer.Name
                );
                submissions.add(newAnswer);
                dmlManager.checkAccess(new Map<String, Map<String, Set<String>>> {
                    'User_Answer__c' => new Map<String, Set<String>> {
                        'Create' => new Set<String> {
                            'Name',
                            'User_Survey__c',
                            'Answer__c',
                            'Checked__c',
                            'QuestionPosition__c',
                            'QuestionName__c',
                            'AnswerPosition__c',
                            'AnswerName__c'
                        }
                    }
                });
                insert newAnswer;
            }
        }
        return submissions;
    }
}
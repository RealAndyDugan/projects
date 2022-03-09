public with sharing class getAllSurveys {
    
    List<User_Survey__c> surveys;
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getAllSurveysList(ID recordId) {
        //DML Check
        dmlManager.checkAccess(new Map<String, Map<String, Set<String>>> {
            'User_Answer__c' => new Map<String, Set<String>> {
                'Read' => new Set<String> {
                    'ID',
                    'Name',
                    'User_Survey__c',
                    'Answer__c',
                    'Checked__c',
                    'QuestionPosition__c',
                    'QuestionName__c',
                    'AnswerPosition__c',
                    'AnswerName__c'
                }
            },
            'User_Survey__c' => new Map<String, Set<String>> {
                'Read' => new Set<String> {
                    'ID',
                    'Name',
                    'CreatedDate',
                    'CreatedById'
                }
            },
            'User' => new Map<String, Set<String>> {
                'Read' => new Set<String> {
                    'ID',
                    'Name'
                }
            },
            'Question__c' => new Map<String, Set<String>> {
                'Read' => new Set<String> {
                    'ID',
                    'Name',
                    'Template__c'
                }
            }
        });
        //List of survey objects (empty)
        List<Map<String, Object>> surveys = new List<Map<String, Object>>();
        //List of surveys from DB, unformatted and without any questions or answers - for a specified template
        List<User_Survey__c> dbSurveys = [SELECT ID, Name, CreatedDate, CreatedById FROM User_Survey__c WHERE Template__r.ID = :recordId ORDER BY CreatedDate DESC];
        //List of questions from DB for specified template
        List<User_Answer__c> dbQuestions = [SELECT ID, QuestionName__c, User_Survey__c, QuestionPosition__c FROM User_Answer__c WHERE User_Survey__r.Template__r.ID = :recordId ORDER BY QuestionPosition__c];
        //List of answers from DB for specified template
        List<User_Answer__c> dbAnswers = [SELECT ID, AnswerName__c, QuestionName__c, User_Survey__c, Checked__c FROM User_Answer__c WHERE User_Survey__r.Template__r.ID = :recordId ORDER BY AnswerPosition__c];
        //List of all users
        List<User> users = [SELECT ID, Name FROM User];
        //List of questions
        List<Question__c> allQuestions = [SELECT ID, Name, Template__c FROM Question__c WHERE Template__r.ID = :recordId];

        for(User_Survey__c survey : dbSurveys) {
            Map<String, Object> surv = new Map<String, Object>();
            surv.put('Id', survey.Id);
            surv.put('user', getName(survey.CreatedById, users));
            surv.put('name', survey.Name);
            surv.put('date', formatDate(survey.CreatedDate));
            List<Map<String, Object>> questions = new List<Map<String, Object>>();
            List<String> iterated = new List<String>();
                
            for(User_Answer__c q : dbQuestions) {
                Map<String, Object> question = new Map<String, Object>();
                
                if(iterated.contains(q.QuestionName__c) == false && q.User_Survey__c == survey.ID) {
                    iterated.add(q.QuestionName__c);
                    question.put('name', q.QuestionName__c);
                    question.put('position', q.QuestionPosition__c);
                    List<String> allAnswers = new List<String>();
                    for(User_Answer__c a : dbAnswers) {
                        if(a.QuestionName__c == q.QuestionName__c && a.User_Survey__c == survey.ID && a.Checked__c == true) {
                            allAnswers.add(a.AnswerName__c);
                        }
                    }
                    if(allAnswers.size() > 0) {
                        question.put('answers', String.join(allAnswers,', '));
                    }
                    else {
                        question.put('answers', 'N/A');
                    }
                    questions.add(question);
                    surv.put('questions', questions);
                }
            }
            
            surveys.add(surv);
        }
        return surveys;
    }

    //Format Date
    public static String formatDate(Datetime theDate) {
        String formatted = string.valueOf(theDate);
        String month = formatted.substring(5,7);
        String day = formatted.substring(8,10);
        String year = formatted.substring(0,4);
        String result = month + '/' + day + '/' + year;
        return result;
    }

    public static String getName(ID Id, List<User> users) {
        String name = '';
        for(User user : users) {
            if(user.ID == Id) {
                name = user.Name;
            }
        }
        return name;
    }
    
}
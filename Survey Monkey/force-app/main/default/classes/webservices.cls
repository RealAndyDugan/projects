@RestResource(urlMapping='/SurveyMonkey/*')
global with sharing class webservices {
    @HttpGet
    global static void doGet() {
        RestResponse res = RestContext.response;
        RestRequest req = RestContext.request;

        try { 
            //String recordId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
            req.requestURI = '/templates/';
            
            //Handling Data
            List<Template__c> allTemplates = [SELECT ID, Name FROM Template__c];
            List<Question__c> allQuestions = [SELECT ID, Name, Position__c, Template__c FROM Question__c];
            List<Answer__c> allAnswers = [SELECT ID, Name, Position__c, Question__c FROM Answer__c];
            //Return object
            Map<String, Object> data = new Map<String, Object>();
            //Get templates
            List<Map<String, Object>> templates = new List<Map<String, Object>>();
            for(Template__c template : allTemplates) {
                Map<String, Object> temp = new Map<String, Object>();
                temp.put('id', template.ID);
                temp.put('name', template.Name);
                //Get questions
                List<Map<String, Object>> questions = new List<Map<String, Object>>();
                for(Question__c question : allQuestions) {
                    if(question.Template__c == template.ID) {
                        Map<String, Object> ques = new Map<String, Object>();
                        ques.put('id', question.ID);
                        ques.put('question', question.Name);
                        ques.put('position', question.Position__c);
                        //Get answers
                        List<Map<String, Object>> answers = new List<Map<String, Object>>();
                        for(Answer__c answer : allAnswers) {
                            if(answer.Question__c == question.ID) {
                                Map<String, Object> ans = new Map<String, Object>();
                                ans.put('id', answer.ID);
                                ans.put('answer', answer.Name);
                                ans.put('position', answer.Position__c);
                                answers.add(ans);
                            }
                        }
                        ques.put('answers', answers);
                        questions.add(ques);
                    }
                }
                temp.put('questions', questions);
                templates.add(temp);
            }
            data.put('data', templates);
            //Done with handling data
            res.responseBody = Blob.valueof(JSON.serialize(data));
            res.statusCode = 200;

        } catch(Exception e) {                
            res.statusCode = 500;
            res.responseBody = Blob.valueof('ERROR: ' + e.getStackTraceString());
        }
    }
       
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //Rework, put everything into an object on return
        try { 
            //Get template ID
            req.requestURI = '/surveys/';
            ID recordId = req.params.get('id');
            //Return object
            Map<String, Object> data = new Map<String, Object>();
            //Handle incoming JSON Object list
            Object params = (Object) JSON.deserializeUntyped(req.requestBody.toString());
            Map<String, Object> mapParams = (Map<String, Object>) params;
            //List<Object> questionObjects = (List<Object>) mapParams.get('questions');
            //List<Object> answerObjects = (List<Object>) mapParams.get('answers');
            //Storage lists
            List<ID> answers = new List<ID>();
            List<Object> answerIDs = new List<Object>();
            //Get username
            String username = (String) mapParams.get('username');
            //User doesnt exist handling
            ID userId;
            System.debug('Check 1');
            List<User> users = [SELECT ID, Username FROM User WHERE Username = :username];
            System.debug('Check 2');
            
            if(users.size() == 0) {
                data.put('data', 'Error: User Not Found');
                res.responseBody = Blob.valueof(JSON.serialize(data));
                res.statusCode = 404;
            }
            else {
                userId = users.get(0).ID;
                //Iterate questions for answers
                List<Object> answerObjects = (List<Object>) mapParams.get('answers');
                //Add answers to answer list
                for(Object answer : answerObjects) {
                    Map<String, Object> answerMap = (Map<String, Object>) answer;
                    answers.add(ID.valueOf((String)answerMap.get('answer')));
                }
                
                createSurvey.createUserSurvey(recordId, answers, userId);
                List<String> output = new List<String>();
                data.put('data', output);
                res.statusCode = 201;
                res.responseBody = Blob.valueof(JSON.serialize(data));
            }

        } catch(Exception e) { 
            res.statusCode = 500;
            Map<String, Object> data = new Map<String, Object>();
            data.put('data', 'ERROR: ' + e.getStackTraceString());
            res.responseBody = Blob.valueof(JSON.serialize(data));
        } 
    }
}
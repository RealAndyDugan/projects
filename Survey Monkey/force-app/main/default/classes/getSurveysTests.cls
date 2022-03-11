@isTest 
public class getSurveysTests {

    @isTest static void testGetSurveys() {
        User user = [SELECT ID, Name FROM User WHERE Name = 'Andy Dugan'];
        Template__c template = new Template__c(
            Name = 'Test Template'
        );
        insert template;
        Question__c question = new Question__c(
            Name = 'Test Question',
            Position__c = 1,
            Template__c = template.ID
        );
        insert question;
        Answer__c answer = new Answer__c(
            Name = 'Test Answer',
            Position__c = 1,
            Question__c = question.ID
        );
        insert answer;
        User_Survey__c userSurvey = new User_Survey__c (
            Name = template.Name,
            Template__c = template.ID,
            User__c = user.ID
        );
        insert userSurvey;
        User_Answer__c userAnswer = new User_Answer__c(
            Name = answer.Name,
            User_Survey__c = userSurvey.ID,
            Answer__c = answer.ID,
            Checked__c = true,
            QuestionPosition__c = question.Position__c,
            QuestionName__c = question.Name,
            AnswerPosition__c = answer.Position__c,
            AnswerName__c = answer.Name,
            Id = null
        );
        insert userAnswer;

        List<Map<String, Object>> questionList = new List<Map<String, Object>>();
        Map<String, Object> questions = new Map<String, Object>();
        questions.put('name', question.Name);
        questions.put('position', question.Position__c);
        questions.put('answers', userAnswer.AnswerName__c);
        questionList.add(questions);

        List<Map<String, Object>> correctList = new List<Map<String, Object>>();
        Map<String, Object> correctSurvey = new Map<String, Object>();
        correctSurvey.put('Id', userSurvey.ID);
        correctSurvey.put('name', userSurvey.Name);
        //Change to todays date
        correctSurvey.put('date', null);
        correctSurvey.put('questions', questionList);
        correctList.add(correctSurvey);
        
        //Results
        List<Map<String, Object>> results = getSurveys.getSurveyList(user.ID);
        for(Map<String, Object> indvSurvey : results) {
            indvSurvey.put('date', null);
        }
        System.assertEquals(correctList, results);
    }
}
@isTest 
public class getQuestionsTests {

    @isTest static void testGetAllQuestions() {
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

        Map<String, Object> correctQuestion = new Map<String, Object>();
        correctQuestion.put('Name', question.Name);

        String JSONString = getQuestions.getQuestionList(template.ID);
        Map<String, Object> parsedRes = (Map<String, Object>)JSON.deserializeUntyped(JSONString);
        Map<String, Object> results = (Map<String, Object>) parsedRes.get('results');
        List<Object> questions = (List<Object>)results.get('questions');
        Map<String, Object> result = (Map<String, Object>) questions.get(0);

        Map<String, Object> resultQuestion = new Map<String, Object>();
        resultQuestion.put('Name', (String) result.get('Name'));

        System.assertEquals(question.Name, (String) resultQuestion.get('Name'));
    }
}
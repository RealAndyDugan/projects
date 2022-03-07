@isTest 
public class getQuestionsTests {
    //List<Template__c> templates = [SELECT ID, Name FROM Template__c];
    //List<Question__c> questions = [SELECT ID, Name, Template__c FROM Question__c];
    //List<Answer__c> answers = [SELECT ID, Name, Question__c FROM Answer__c];
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
        correctQuestion.put('Position', question.Position__c);
        correctQuestion.put('ID', question.ID);

        List<Question__c> results = getQuestions.getQuestionList(template.ID);
        Question__c result = results.get(0);

        Map<String, Object> resultQuestion = new Map<String, Object>();
        resultQuestion.put('Name', result.Name);
        resultQuestion.put('Position', result.Position__c);
        resultQuestion.put('ID', result.ID);

        System.assertEquals(correctQuestion, resultQuestion);
    }
}
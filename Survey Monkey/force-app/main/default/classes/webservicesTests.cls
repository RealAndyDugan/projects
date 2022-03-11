@isTest 
public class webservicesTests {
    //Get all templates -- Compare result objects (as strings)
    @isTest static void testDoGet() {
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
        //Ugly
        String correctResult = '{"data":[{"questions":[{"answers":[{"position":1,"answer":"Test Answer","id":"'+answer.ID+'"}],"position":1,"question":"Test Question","id":"'+question.ID+'"}],"name":"Test Template","id":"'+template.id+'"}]}';

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/templates';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        webservices.doGet();
        Test.stopTest();

        String data = res.responseBody.toString();
        System.assertEquals(correctResult, data);
    }

    //Create Survey -- Compare answer names
    @isTest static void testDoPost() {
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
        //Get profile
        Profile profile = [SELECT Id, Name, Description
        FROM Profile
        WHERE Name = 'System Administrator'];
        //User Creation
        User user = new User(
            ProfileId = profile.ID, // change id?
            Alias = 'test',
            Username = 'testtester@email.com',
            Email = 'test@email.com',
            FirstName = 'test',
            LastName = 'test',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            TimeZoneSidKey = 'America/Los_Angeles'
        );
        insert user;
        //End User Creation
        //Basic user creation for my org
        //String user = 'andy.dugan@resourceful-raccoon-7j34h6.com';
        Map<String, Object> data = new Map<String, Object>();
        List<Map<String, Object>> answers = new List<Map<String, Object>>();
        Map<String, Object> answerObject = new Map<String, Object>();
        answerObject.put('answer', answer.ID);
        answers.add(answerObject);
        data.put('answers', answers);
        data.put('username', user.Username);

        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        String uri = '/surveys';
        req.requestURI = uri;
        req.params.put('id', template.ID);
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serializePretty(data));

        RestContext.request = req;
        RestContext.response= res;

        Test.startTest();
        webservices.doPost();
        Test.stopTest();
        User_Answer__c result = [SELECT AnswerName__c FROM User_Answer__c LIMIT 1];
        System.assertEquals(answer.Name, result.AnswerName__c);
    }
}
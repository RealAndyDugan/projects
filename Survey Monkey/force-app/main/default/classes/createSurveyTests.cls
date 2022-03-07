@isTest 
public class createSurveyTests {
    //List<Template__c> templates = [SELECT ID, Name FROM Template__c];
    //List<Question__c> questions = [SELECT ID, Name, Template__c FROM Question__c];
    //List<Answer__c> answers = [SELECT ID, Name, Question__c FROM Answer__c];
    @isTest static void testCreateSurvey() {
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
        List<ID> ids = new List<ID>();
        ids.add(answer.ID);
        User user = [SELECT ID FROM User LIMIT 1];
        User_Survey__c survey = createSurvey.createUserSurvey(template.ID, ids, user.ID);

        //Correct Answer
        User_Survey__c newSurvey = new User_Survey__c (
            Name = template.Name, 
            User__c = user.ID,
            Template__c = template.ID
        );
        insert newSurvey;
        User_Survey__c thisSurvey = [SELECT Name, User__c, Template__c, ID FROM User_Survey__c WHERE Name = :template.Name LIMIT 1];
        

        System.assertEquals(thisSurvey, survey);
    }

    @isTest static void testCreateAnswersChecked() {
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
        List<Question__c> questionsDB = new List<Question__c>();
        questionsDB.add(question);
        List<Answer__c> answersDB = new List<Answer__c>();
        answersDB.add(answer);
        List<ID> ids = new List<ID>();
        ids.add(answer.ID);
        User user = [SELECT ID FROM User LIMIT 1];
        User_Survey__c newSurvey = new User_Survey__c (
            Name = template.Name, 
            User__c = user.ID,
            Template__c = template.ID
        );
        insert newSurvey;

        //Correct answer
        User_Answer__c thisAnswer = new User_Answer__c(
            Name = answer.Name,
            User_Survey__c = newSurvey.ID,
            Answer__c = answer.ID,
            Checked__c = true,
            QuestionPosition__c = question.Position__c,
            QuestionName__c = question.Name,
            AnswerPosition__c = answer.Position__c,
            AnswerName__c = answer.Name,
            Id = null
        );
        List<User_Answer__c> submissions = new List<User_Answer__c>();
        submissions.add(thisAnswer);

        List<User_Answer__c> testedData = createSurvey.createUserAnswers(ids, questionsDB, answersDB, newSurvey);
        User_Answer__c result = testedData.get(0);
        result.Id = null;
        System.assertEquals(thisAnswer, result);
    }

    @isTest static void testCreateAnswersUnchecked() {
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
        List<Question__c> questionsDB = new List<Question__c>();
        questionsDB.add(question);
        List<Answer__c> answersDB = new List<Answer__c>();
        answersDB.add(answer);
        List<ID> ids = new List<ID>();
        //ids.add(answer.ID);
        User user = [SELECT ID FROM User LIMIT 1];
        User_Survey__c newSurvey = new User_Survey__c (
            Name = template.Name, 
            User__c = user.ID,
            Template__c = template.ID
        );
        insert newSurvey;

        //Correct answer
        User_Answer__c thisAnswer = new User_Answer__c(
            Name = answer.Name,
            User_Survey__c = newSurvey.ID,
            Answer__c = answer.ID,
            Checked__c = false,
            QuestionPosition__c = question.Position__c,
            QuestionName__c = question.Name,
            AnswerPosition__c = answer.Position__c,
            AnswerName__c = answer.Name,
            Id = null
        );
        List<User_Answer__c> submissions = new List<User_Answer__c>();
        submissions.add(thisAnswer);

        List<User_Answer__c> testedData = createSurvey.createUserAnswers(ids, questionsDB, answersDB, newSurvey);
        User_Answer__c result = testedData.get(0);
        result.Id = null;
        System.assertEquals(thisAnswer, result);
    }
}
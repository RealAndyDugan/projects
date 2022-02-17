public with sharing class getQuestions {
    @AuraEnabled(cacheable=true)
    public static List<Question__c> getQuestionList(ID Id) {
        return [
            SELECT ID, Name, Position__c,
            (
                SELECT ID, Name, Position__c
                FROM Answers__r
                ORDER BY Position__c
            )
            FROM Question__c
            WHERE Template__r.ID = :Id
            ORDER BY Position__c
        ];
    }
}
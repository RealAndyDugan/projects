public with sharing class getAnswers {
    @AuraEnabled(cacheable=true)
    public static List<Answer__c> getAnswerList(ID Id) {
        return [
            SELECT ID, Name, Position__c, Question__c
            FROM Answer__c
            WHERE Question__r.ID = :Id
            ORDER BY Position__c
        ];
    }
}
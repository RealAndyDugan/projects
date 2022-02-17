public with sharing class getQuestions {
    @AuraEnabled(cacheable=true)
    public static List<Question__c> getQuestionList(String id) {
        return [
            SELECT ID, Name
            FROM Question__c
            WHERE Template__r.ID = :id
            WITH SECURITY_ENFORCED
        ];
    }
}
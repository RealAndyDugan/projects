public with sharing class getAns {
    @AuraEnabled(cacheable=true)
    public static List<Answer__c> getAnsList(ID Id) {
        return [
            SELECT ID, Name, Position__c, Question__c
            FROM Answer__c
            WHERE Question__r.ID = :Id
            ORDER BY Position__c
        ];
    }
}
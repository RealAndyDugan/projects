public with sharing class getTemplate {
    @AuraEnabled(cacheable=true)
    public static Template__c getTemplateList(String Id) {
        return [
            SELECT ID, Name
            FROM Template__c
            WHERE ID = :Id
        ];
    }
}
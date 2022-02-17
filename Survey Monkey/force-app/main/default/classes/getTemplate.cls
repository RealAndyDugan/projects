public with sharing class getTemplate {
    @AuraEnabled(cacheable=true)
    public static List<Template__c> getTemplateList(ID Id) {
        return [
            SELECT ID, Name
            FROM Template__c
            WHERE ID = :Id
            LIMIT 1
        ];
    }
}
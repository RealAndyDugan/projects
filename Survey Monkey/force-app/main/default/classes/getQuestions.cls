public with sharing class getQuestions {
    @AuraEnabled(cacheable=true)
    public static List<Question__c> getQuestionList(ID Id) {
        //DML Check
        dmlManager.checkAccess(new Map<String, Map<String, Set<String>>> {
            'Question__c' => new Map<String, Set<String>> {
                'Read' => new Set<String> {
                    'ID',
                    'Name',
                    'Position__c',
                    'Template__c'
                }
            },
            'Answer__c' => new Map<String, Set<String>> {
                'Read' => new Set<String> {
                    'ID',
                    'Name',
                    'Position__c',
                    'Question__c'
                }
            }
        });
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
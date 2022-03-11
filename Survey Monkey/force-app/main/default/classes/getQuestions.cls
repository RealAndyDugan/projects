public with sharing class getQuestions {
    @AuraEnabled
    public static String getQuestionList(String recordId) {
        responseData rd = new responseData();

        try {
            //ID id = (ID) recordId;
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
            rd.put('questions', [
                SELECT ID, Name, Position__c,
                (
                    SELECT ID, Name, Position__c
                    FROM Answers__r
                    ORDER BY Position__c
                )
                FROM Question__c
                WHERE Template__r.ID = :recordId
                ORDER BY Position__c
            ]);
        } catch (Exception e) {
            rd.addError(e);
        }

        return rd.getJsonString();
    }
}
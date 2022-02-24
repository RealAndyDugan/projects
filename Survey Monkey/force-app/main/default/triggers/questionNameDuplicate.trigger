trigger questionNameDuplicate on Question__c (before insert) {
    Set<String> question = new Set<String>();
    Set<ID> templates = new Set<ID>();
	for(Question__c ques : trigger.new)
	{
		question.add(ques.Name);
        templates.add(ques.Template__c);
	}

    List<Question__c> allQuestions = [ SELECT Name FROM Question__c WHERE Template__c = :templates AND Name IN :question ];

    for(Question__c ques : trigger.new) {
        if(allQuestions.size() > 0) {
            ques.Name.addError('Question Already Exists');
        }
    }
}
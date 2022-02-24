trigger questionPosDuplicate on Question__c (before insert) {
    Set<Decimal> question = new Set<Decimal>();
    Set<ID> templates = new Set<ID>();
	for(Question__c ques : trigger.new)
	{
		question.add(ques.Position__c);
        templates.add(ques.Template__c);
	}

    List<Question__c> allQuestions = [ SELECT Position__c FROM Question__c WHERE Template__c = :templates AND Position__c IN :question ];

    for(Question__c ques : trigger.new) {
        if(allQuestions.size() > 0) {
            ques.Position__c.addError('Question Already In This Position');
        }
    }
}
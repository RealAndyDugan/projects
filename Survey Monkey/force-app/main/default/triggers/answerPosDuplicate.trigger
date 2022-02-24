trigger answerPosDuplicate on Answer__c (before insert) {
    Set<Decimal> answer = new Set<Decimal>();
    Set<ID> questions = new Set<ID>();
	for(Answer__c ans : trigger.new)
	{
		answer.add(ans.Position__c);
        questions.add(ans.Question__c);
	}

    List<Answer__c> allAnswers = [ SELECT Position__c FROM Answer__c WHERE Question__c = :questions AND Position__c IN :answer ];

    for(Answer__c ans : trigger.new) {
        if(allAnswers.size() > 0) {
            ans.Position__c.addError('Answer Already In This Position');
        }
    }
}
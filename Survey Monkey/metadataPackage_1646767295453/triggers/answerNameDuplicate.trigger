trigger answerNameDuplicate on Answer__c (before insert, before update) {
    Set<String> answer = new Set<String>();
    Set<ID> questions = new Set<ID>();
	for(Answer__c ans : trigger.new)
	{
		answer.add(ans.Name);
        questions.add(ans.Question__c);
	}

    List<Answer__c> allAnswers = [ SELECT Name FROM Answer__c WHERE Question__c = :questions AND Name IN :answer ];

    for(Answer__c ans : trigger.new) {
        if(allAnswers.size() > 0) {
            ans.Name.addError('Answer Already Exists');
        }
    }
}
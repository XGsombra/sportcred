package com.sportcred.dto;

import java.util.ArrayList;
import java.util.List;

import com.sportcred.dto.wrapper.QuestionOutput;

public class GetQuestionSetOutput {
	private List<QuestionOutput> questionSet = new ArrayList<>();

	public List<QuestionOutput> getQuestionSet() {
		return questionSet;
	}

	public void setQuestionSet(List<QuestionOutput> questionSet) {
		this.questionSet = questionSet;
	}
}

package com.sportcred.dto.wrapper;

import java.util.ArrayList;
import java.util.List;

public class QuestionOutput {
	private String question;
	
	private List<String> answers = new ArrayList<>();
	
	private int correctAnswerIndex;

	public List<String> getAnswers() {
		return answers;
	}

	public void setAnswers(List<String> answers) {
		this.answers = answers;
	}

	public int getCorrectAnswerIndex() {
		return correctAnswerIndex;
	}

	public void setCorrectAnswerIndex(int correctAnswerIndex) {
		this.correctAnswerIndex = correctAnswerIndex;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}
}

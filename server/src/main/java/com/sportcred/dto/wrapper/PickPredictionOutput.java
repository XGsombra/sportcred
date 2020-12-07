package com.sportcred.dto.wrapper;

import java.util.List;

public class PickPredictionOutput {
	private Long id;
	
	private String content;
	
	private List<String> options;
	
	private int answerIndex;
	
	private int userAnswerIndex;
	
	private List<Integer> optionSelectedNumber;
	
	private List<String> logos;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public List<String> getOptions() {
		return options;
	}

	public void setOptions(List<String> options) {
		this.options = options;
	}

	public int getAnswerIndex() {
		return answerIndex;
	}

	public void setAnswerIndex(int answerIndex) {
		this.answerIndex = answerIndex;
	}

	public int getUserAnswerIndex() {
		return userAnswerIndex;
	}

	public void setUserAnswerIndex(int userAnswerIndex) {
		this.userAnswerIndex = userAnswerIndex;
	}

	public List<Integer> getOptionSelectedNumber() {
		return optionSelectedNumber;
	}

	public void setOptionSelectedNumber(List<Integer> optionSelectedNumber) {
		this.optionSelectedNumber = optionSelectedNumber;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<String> getLogos() {
		return logos;
	}

	public void setLogos(List<String> logos) {
		this.logos = logos;
	}
}

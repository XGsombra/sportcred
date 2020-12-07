package com.sportcred.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "trivia_question",
	indexes = {@Index(name = "question",  columnList="question", unique = true)})
public class TriviaQuestion {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column
	private String question;
	
	@Column
	private String correctAnswer;
	
	@Column
	private String otherAnswerA;
	
	@Column
	private String otherAnswerB;
	
	@Column
	private String otherAnswerC;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getCorrectAnswer() {
		return correctAnswer;
	}

	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}

	public String getOtherAnswerA() {
		return otherAnswerA;
	}

	public void setOtherAnswerA(String otherAnswerA) {
		this.otherAnswerA = otherAnswerA;
	}

	public String getOtherAnswerB() {
		return otherAnswerB;
	}

	public void setOtherAnswerB(String otherAnswerB) {
		this.otherAnswerB = otherAnswerB;
	}

	public String getOtherAnswerC() {
		return otherAnswerC;
	}

	public void setOtherAnswerC(String otherAnswerC) {
		this.otherAnswerC = otherAnswerC;
	}
	
	
}

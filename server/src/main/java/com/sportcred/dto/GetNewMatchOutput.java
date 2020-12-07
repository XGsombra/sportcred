package com.sportcred.dto;

import java.util.ArrayList;
import java.util.List;

import com.sportcred.dto.wrapper.QuestionOutput;

public class GetNewMatchOutput {
	private List<QuestionOutput> questionSet = new ArrayList<>();
	
	private Integer roomId;

	public List<QuestionOutput> getQuestionSet() {
		return questionSet;
	}

	public void setQuestionSet(List<QuestionOutput> questionSet) {
		this.questionSet = questionSet;
	}

	public Integer getRoomId() {
		return roomId;
	}

	public void setRoomId(Integer roomId) {
		this.roomId = roomId;
	}
}

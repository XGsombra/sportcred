package com.sportcred.dto;

import com.sportcred.entity.DebateTopic;

import java.util.List;

public class GetTopicsOutput {
    private List<DebateTopic> topicList;

	public List<DebateTopic> getTopicList() {
		return topicList;
	}

	public void setTopicList(List<DebateTopic> topicList) {
		this.topicList = topicList;
	}
}

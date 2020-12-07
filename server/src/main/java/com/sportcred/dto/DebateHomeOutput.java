package com.sportcred.dto;

import java.util.List;

import com.sportcred.dto.wrapper.DebateHomeTopic;

public class DebateHomeOutput {
	private String tier;
	
	private List<DebateHomeTopic> topics;

	public String getTier() {
		return tier;
	}

	public void setTier(String tier) {
		this.tier = tier;
	}

	public List<DebateHomeTopic> getTopics() {
		return topics;
	}

	public void setTopics(List<DebateHomeTopic> topics) {
		this.topics = topics;
	}
}

package com.sportcred.dto;

import java.util.List;

public class GetAnalyzePostOutput {
	private Long postId;
	
	private Long userId;
	
	private String content;
	
	private Long createdTime;
	
	private String agreeRate;
	
	private Integer rateCount;
	
	private Integer userAgreeRate;
	
	private List<String> pictures;
	
	private String topic;
	
	private String tier;
	
	private Boolean active;

	public Long getPostId() {
		return postId;
	}

	public void setPostId(Long postId) {
		this.postId = postId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Long createdTime) {
		this.createdTime = createdTime;
	}

	public List<String> getPictures() {
		return pictures;
	}

	public void setPictures(List<String> pictures) {
		this.pictures = pictures;
	}

	public String getAgreeRate() {
		return agreeRate;
	}

	public void setAgreeRate(String agreeRate) {
		this.agreeRate = agreeRate;
	}

	public Integer getRateCount() {
		return rateCount;
	}

	public void setRateCount(Integer rateCount) {
		this.rateCount = rateCount;
	}

	public Integer getUserAgreeRate() {
		return userAgreeRate;
	}

	public void setUserAgreeRate(Integer userAgreeRate) {
		this.userAgreeRate = userAgreeRate;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getTier() {
		return tier;
	}

	public void setTier(String tier) {
		this.tier = tier;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

}

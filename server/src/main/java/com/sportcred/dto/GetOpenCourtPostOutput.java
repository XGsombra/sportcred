package com.sportcred.dto;

import java.util.List;

public class GetOpenCourtPostOutput {
	private Long postId;
	
	private Long userId;
	
	private String content;
	
	private Long likeCount;
	
	private Long createdTime;
	
	private String likeCondition;
	
	// Added
	private List<String> pictures;
	
	private List<String> tags;

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

	public Long getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(Long likeCount) {
		this.likeCount = likeCount;
	}

	public String getLikeCondition() {
		return likeCondition;
	}

	public void setLikeCondition(String likeCondition) {
		this.likeCondition = likeCondition;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}
}

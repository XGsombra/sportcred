package com.sportcred.dto;

public class AddSubcommentInput {
	private Long commentId;
	
	private String content;
	
	private Long commentToUserId;

	public Long getCommentId() {
		return commentId;
	}

	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Long getCommentToUserId() {
		return commentToUserId;
	}

	public void setCommentToUserId(Long commentToUserId) {
		this.commentToUserId = commentToUserId;
	}
}

package com.sportcred.dto.wrapper;

public class SubcommentOutput {
    private Long id;

    private Long commentId;

    private Long userId;
    
    private Long commentToUserId;

    private String content;

    private Long createdTime;

    private Long likeCount;
    
    private String likeCondition;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCommentId() {
		return commentId;
	}

	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getCommentToUserId() {
		return commentToUserId;
	}

	public void setCommentToUserId(Long commentToUserId) {
		this.commentToUserId = commentToUserId;
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
}

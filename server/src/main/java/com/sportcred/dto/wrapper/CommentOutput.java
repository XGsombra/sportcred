package com.sportcred.dto.wrapper;

public class CommentOutput {
    private Long id;

    private Long postId;

    private Long userId;

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

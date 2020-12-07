package com.sportcred.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "analyze_post_agree",
indexes = {@Index(name = "rate_unit",  columnList="postId, userId", unique = true)})
public class AnalyzePostAgree {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column
    private Long postId;
	
	@Column
	private Long userId;
	
	@Column
	private Integer agreeRate;

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

	public Integer getAgreeRate() {
		return agreeRate;
	}

	public void setAgreeRate(Integer agreeRate) {
		this.agreeRate = agreeRate;
	}
}

package com.sportcred.entity;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "analyze_post",
	  indexes = {@Index(name = "topic_id",  columnList="topicId", unique = false),
			  	 @Index(name = "is_active",  columnList="isActive", unique = false)})
public class AnalyzePost {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column
	private Long userId;
	
	@Column
	private Long topicId;
	
	@Column(length = 4096)
	private String content;
	
	@Column
	private Long createdTime;
	
	@Column
	private Integer rateCount;
	
	@Column
	private BigDecimal agreeRate;
	
	@Column
	private Boolean isActive;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getTopicId() {
		return topicId;
	}

	public void setTopicId(Long topicId) {
		this.topicId = topicId;
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

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Integer getRateCount() {
		return rateCount;
	}

	public void setRateCount(Integer rateCount) {
		this.rateCount = rateCount;
	}

	public BigDecimal getAgreeRate() {
		return agreeRate;
	}

	public void setAgreeRate(BigDecimal agreeRate) {
		this.agreeRate = agreeRate;
	}
}

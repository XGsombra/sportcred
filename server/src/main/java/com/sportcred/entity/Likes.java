package com.sportcred.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "likes",
	   indexes = {@Index(name = "like_unit",  columnList="type, contentId, userId", unique = true)})
public class Likes{
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column(length = 16)
    private String type;
	
	@Column
    private Long contentId;
	
	@Column
	private Long userId;
	
	@Column
	private Boolean isLik;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getContentId() {
		return contentId;
	}

	public void setContentId(Long contentId) {
		this.contentId = contentId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Boolean getIsLik() {
		return isLik;
	}

	public void setIsLik(Boolean isLike) {
		this.isLik = isLike;
	}
}

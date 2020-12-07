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
@Table(name = "user",
	   indexes = {@Index(name = "email",  columnList="email", unique = true),
			      @Index(name = "username",  columnList="username", unique = true)})
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column(length = 64)
	private String username;
	
	@Column(length = 64)
	private String email;
	
	@Column
	private String bio;
	
	@Column(length = 64)
	private String favoriteSport;
	
	@Column
	private Integer age;
	
	@Column(length = 64)
	private String wantToKnowSport;
	
	@Column(length = 64)
	private String favoriteSportTeam;
	
	@Column
	private String levelOfSportPlay;
	
	@Column
	private BigDecimal acsPoint;
	
	@Column
	private BigDecimal triviaAcsPoint;
	
	@Column
	private BigDecimal picksAcsPoint;
	
	@Column
	private BigDecimal debateAcsPoint;
	
	@Column
	private BigDecimal participationAcsPoint;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFavoriteSport() {
		return favoriteSport;
	}

	public void setFavoriteSport(String favoriteSport) {
		this.favoriteSport = favoriteSport;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getWantToKnowSport() {
		return wantToKnowSport;
	}

	public void setWantToKnowSport(String wantToKnowSport) {
		this.wantToKnowSport = wantToKnowSport;
	}

	public String getFavoriteSportTeam() {
		return favoriteSportTeam;
	}

	public void setFavoriteSportTeam(String favoriteSportTeam) {
		this.favoriteSportTeam = favoriteSportTeam;
	}

	public String getLevelOfSportPlay() {
		return levelOfSportPlay;
	}

	public void setLevelOfSportPlay(String levelOfSportPlay) {
		this.levelOfSportPlay = levelOfSportPlay;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public BigDecimal getAcsPoint() {
		return acsPoint;
	}

	public void setAcsPoint(BigDecimal acsPoint) {
		this.acsPoint = acsPoint;
	}

	public BigDecimal getTriviaAcsPoint() {
		return triviaAcsPoint;
	}

	public void setTriviaAcsPoint(BigDecimal triviaAcsPoint) {
		this.triviaAcsPoint = triviaAcsPoint;
	}

	public BigDecimal getPicksAcsPoint() {
		return picksAcsPoint;
	}

	public void setPicksAcsPoint(BigDecimal picksAcsPoint) {
		this.picksAcsPoint = picksAcsPoint;
	}

	public BigDecimal getDebateAcsPoint() {
		return debateAcsPoint;
	}

	public void setDebateAcsPoint(BigDecimal debateAcsPoint) {
		this.debateAcsPoint = debateAcsPoint;
	}

	public BigDecimal getParticipationAcsPoint() {
		return participationAcsPoint;
	}

	public void setParticipationAcsPoint(BigDecimal participationAcsPoint) {
		this.participationAcsPoint = participationAcsPoint;
	}
}

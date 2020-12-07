package com.sportcred.dto;

public class UpdateUserProfileInput {
	private String favoriteSport;
	
	private Integer age;
	
	private String wantToKnowSport;
	
	private String favoriteSportTeam;

	private String levelOfSportPlay;
	
	private String bio;

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
}

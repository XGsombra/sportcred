package com.sportcred.dto;

public class SignUpInput {
	private String email;
	
	private String username;
	
	private String password;
	
	private String favoriteSport;
	
	private Integer age;
	
	private String wantToKnowSport;
	
	private String favoriteSportTeam;

	private String levelOfSportPlay;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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
}

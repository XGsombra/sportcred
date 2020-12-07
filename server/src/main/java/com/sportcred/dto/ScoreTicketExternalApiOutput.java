package com.sportcred.dto;

import java.util.List;
import java.util.stream.Collectors;

import com.sportcred.dto.ScoreTickerResponse.ScoreTickerItem;
import com.sportcred.dto.ScoreTickerResponse.ScoreTickerItem.ScoreTickerTeamAndScore;

public class ScoreTicketExternalApiOutput {
	public static class ScoreTicketExternalApiOutputDatum {
		private String matchId;
		private String leagueId;
		private String leagueName;
		private Integer quarterCount;
		private Integer matchTime;
		private Integer status;
		private String homeName;
		private String awayName;
		private Integer homeScore;
		private Integer awayScore;
		private String explain;
		private Boolean neutral;
		public ScoreTickerItem getEssence() {
			ScoreTickerItem score = new ScoreTickerItem();
			ScoreTickerTeamAndScore home = new ScoreTickerTeamAndScore();
			home.setScore(getHomeScore());
			home.setTeamName(getHomeName());
			ScoreTickerTeamAndScore away = new ScoreTickerTeamAndScore();
			away.setScore(getAwayScore());
			away.setTeamName(getAwayName());
			score.setAway(away);
			score.setHome(home);
			score.setTime(getMatchTime());
			return score;
		}
		public String getMatchId() {
			return matchId;
		}
		public void setMatchId(String matchId) {
			this.matchId = matchId;
		}
		public String getLeagueId() {
			return leagueId;
		}
		public void setLeagueId(String leagueId) {
			this.leagueId = leagueId;
		}
		public String getLeagueName() {
			return leagueName;
		}
		public void setLeagueName(String leagueName) {
			this.leagueName = leagueName;
		}
		public Integer getQuarterCount() {
			return quarterCount;
		}
		public void setQuarterCount(Integer quarterCount) {
			this.quarterCount = quarterCount;
		}
		public Integer getMatchTime() {
			return matchTime;
		}
		public void setMatchTime(Integer matchTime) {
			this.matchTime = matchTime;
		}
		public Integer getStatus() {
			return status;
		}
		public void setStatus(Integer status) {
			this.status = status;
		}
		public String getHomeName() {
			return homeName;
		}
		public void setHomeName(String homeName) {
			this.homeName = homeName;
		}
		public String getAwayName() {
			return awayName;
		}
		public void setAwayName(String awayName) {
			this.awayName = awayName;
		}
		public Integer getHomeScore() {
			return homeScore;
		}
		public void setHomeScore(Integer homeScore) {
			this.homeScore = homeScore;
		}
		public Integer getAwayScore() {
			return awayScore;
		}
		public void setAwayScore(Integer awayScore) {
			this.awayScore = awayScore;
		}
		public String getExplain() {
			return explain;
		}
		public void setExplain(String explain) {
			this.explain = explain;
		}
		public Boolean getNeutral() {
			return neutral;
		}
		public void setNeutral(Boolean neutral) {
			this.neutral = neutral;
		}
	}
	private String code;
	private String message;
	private List<ScoreTicketExternalApiOutputDatum> data;
	public ScoreTickerResponse getEssence() {
		ScoreTickerResponse response = new ScoreTickerResponse();
		response.setScores(data.stream()
				.map(d->d.getEssence())
				.collect(Collectors.toList()));
		return response;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public List<ScoreTicketExternalApiOutputDatum> getData() {
		return data;
	}
	public void setData(List<ScoreTicketExternalApiOutputDatum> data) {
		this.data = data;
	}
}

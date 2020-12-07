package com.sportcred.dto;

import java.util.List;

public class ScoreTickerResponse {
	public static class ScoreTickerItem {
		public static class ScoreTickerTeamAndScore {
			private String teamName;
			private Integer score;
			public String getTeamName() {
				return teamName;
			}
			public void setTeamName(String teamName) {
				this.teamName = teamName;
			}
			public Integer getScore() {
				return score;
			}
			public void setScore(Integer score) {
				this.score = score;
			}
		}
		private ScoreTickerTeamAndScore home;
		private ScoreTickerTeamAndScore away;
		private Integer time;
		public ScoreTickerTeamAndScore getHome() {
			return home;
		}
		public void setHome(ScoreTickerTeamAndScore home) {
			this.home = home;
		}
		public ScoreTickerTeamAndScore getAway() {
			return away;
		}
		public void setAway(ScoreTickerTeamAndScore away) {
			this.away = away;
		}
		public Integer getTime() {
			return time;
		}
		public void setTime(Integer time) {
			this.time = time;
		}
	}
	private List<ScoreTickerItem> scores;

	public List<ScoreTickerItem> getScores() {
		return scores;
	}
	public void setScores(List<ScoreTickerItem> scores) {
		this.scores = scores;
	}

}

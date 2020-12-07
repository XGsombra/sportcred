package com.sportcred.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sportcred.dao.AcsHistoryDao;
import com.sportcred.dao.TriviaQuestionDao;
import com.sportcred.dao.UserDao;
import com.sportcred.dto.AddSoloResultInput;
import com.sportcred.dto.GetNewMatchOutput;
import com.sportcred.dto.GetQuestionSetOutput;
import com.sportcred.dto.wrapper.QuestionOutput;
import com.sportcred.entity.AcsHistory;
import com.sportcred.entity.TriviaQuestion;
import com.sportcred.helper.Helper;



@Service
public class TriviaService {
	@Autowired
	private TriviaQuestionDao triviaQuestionDao;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AcsHistoryDao acsHistoryDao;
	
	
//	private HashMap<String, Queue<Match>> pendingMatches = new HashMap<>();
	
	private Integer nextRoomId;
	
	private Map<Integer, Match> playingMatches;
	
	private Match pendingMatch;
	
	private class Match {
		private Long player1Id;
		private Long player2Id;
		private List<QuestionOutput> questionSet;
		private Integer roomId;
		public Long getPlayer1Id() {
			return player1Id;
		}
		public void setPlayer1Id(Long player1Id) {
			this.player1Id = player1Id;
		}
		public Long getPlayer2Id() {
			return player2Id;
		}
		public void setPlayer2Id(Long player2Id) {
			this.player2Id = player2Id;
		}
		public List<QuestionOutput> getQuestionSet() {
			return questionSet;
		}
		public void setQuestionSet(List<QuestionOutput> questionSet) {
			this.questionSet = questionSet;
		}
		public Integer getRoomId() {
			return roomId;
		}
		public void setRoomId(Integer roomId) {
			this.roomId = roomId;
		}
	}
	
	@PostConstruct
	public void setup() {
//		pendingMatches.put("default", new LinkedList<>());
		nextRoomId = 1;
		playingMatches = new HashMap<>();
	}
	
	public GetQuestionSetOutput getQuestionSet() {
		GetQuestionSetOutput output = new GetQuestionSetOutput();
		List<TriviaQuestion> questions = triviaQuestionDao.getByIds(Helper.randomIndexPermutation(20, 10));
		Collections.shuffle(questions);
		output.setQuestionSet(convertQuestionsToOutput(questions));
		return output;
	}
	
	public void addSoloResult(AddSoloResultInput input, Long userId) {
		Integer correctNum = input.getCorrectAnswerNumber();
		Integer wrongNum = 10 - correctNum;
		BigDecimal changeAmount = new BigDecimal(correctNum - wrongNum);
		userDao.changeTriviaAcsPoint(userId, changeAmount);
		userDao.changeAcsPoint(userId, changeAmount.multiply(new BigDecimal("0.1")));
		AcsHistory history = new AcsHistory();
		history.setChangeAmount(changeAmount);
		history.setDescription("Got " + changeAmount + " points from trivia solo");
		history.setModule("Trivia");
		history.setTime(System.currentTimeMillis());
		history.setUserId(userId);
		acsHistoryDao.save(history);
	}
	
	public GetNewMatchOutput getNewMatch(Long userId) {
		GetNewMatchOutput output = new GetNewMatchOutput();
		List<QuestionOutput> questionSet;
		Integer roomId = nextRoomId;
		if(pendingMatch == null) {
			Match match = new Match();
			match.setPlayer1Id(userId);
			List<TriviaQuestion> questions = triviaQuestionDao.findAll();
			Collections.shuffle(questions);
			questionSet = convertQuestionsToOutput(questions);
			match.setQuestionSet(questionSet);
			roomId = nextRoomId;
			match.setRoomId(roomId);
			nextRoomId++;
			pendingMatch = match;
		} else {
			pendingMatch.setPlayer2Id(userId);
			questionSet = pendingMatch.getQuestionSet();
			roomId = pendingMatch.getRoomId();
			playingMatches.put(pendingMatch.getRoomId(), pendingMatch);
			pendingMatch = null;
		}
		output.setRoomId(roomId);
		output.setQuestionSet(questionSet);
		return output;
	}
	
	public void cancelNewMatch(Long userId) {
		pendingMatch = null;
	}
	
	public void addHeadToHeadResult(Integer roomId, Long winnerId) {
		Match match = playingMatches.get(roomId);
		if(match == null) return;
		playingMatches.remove(roomId);
		Long loserId;
		if(match.getPlayer1Id().equals(winnerId)) loserId = match.getPlayer2Id();
		else loserId = match.getPlayer1Id();
		userDao.changeAcsPoint(winnerId, new BigDecimal(2));
		userDao.changeAcsPoint(loserId, new BigDecimal(-2));
		AcsHistory winnerHistory = new AcsHistory();
		winnerHistory.setChangeAmount(new BigDecimal(2));
		winnerHistory.setDescription("Won head-to-head trivia game");
		winnerHistory.setModule("Trivia Head-to-head");
		winnerHistory.setTime(System.currentTimeMillis());
		winnerHistory.setUserId(winnerId);
		acsHistoryDao.save(winnerHistory);
		AcsHistory loserHistory = new AcsHistory();
		loserHistory.setChangeAmount(new BigDecimal(-2));
		loserHistory.setDescription("Lost head-to-head trivia game");
		loserHistory.setModule("Trivia");
		loserHistory.setTime(System.currentTimeMillis());
		loserHistory.setUserId(loserId);
		acsHistoryDao.save(loserHistory);
	}
	
	private List<QuestionOutput> convertQuestionsToOutput(List<TriviaQuestion> questions) {
		List<QuestionOutput> result = new ArrayList<>();
		for(TriviaQuestion question: questions) {
			QuestionOutput questionOutput = new QuestionOutput();
			List<String> answers = questionOutput.getAnswers();
			answers.add(question.getOtherAnswerA());
			answers.add(question.getOtherAnswerB());
			answers.add(question.getOtherAnswerC());
			Collections.shuffle(answers);
			int correctAnswerIndex = new Random().nextInt(4);
			answers.add(correctAnswerIndex, question.getCorrectAnswer());
			questionOutput.setCorrectAnswerIndex(correctAnswerIndex);
			questionOutput.setQuestion(question.getQuestion());
			result.add(questionOutput);
		}
		return result;
	}
}

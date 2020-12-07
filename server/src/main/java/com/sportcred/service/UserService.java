package com.sportcred.service;

import java.io.File;
import java.io.FilenameFilter;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import com.sportcred.entity.RecentViewTag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sportcred.dao.AcsHistoryDao;
import com.sportcred.dao.UserDao;
import com.sportcred.dto.GetAcsHistoryOutput;
import com.sportcred.dto.GetUserProfileOutput;
import com.sportcred.dto.SignUpInput;
import com.sportcred.dto.UpdateUserProfileInput;
import com.sportcred.dto.wrapper.AcsHistoryOutput;
import com.sportcred.entity.AcsHistory;
import com.sportcred.entity.User;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AcsHistoryDao acsHistoryDao;

//	@Autowired
//	private RecentViewTagService recentViewTagService;
	
	@Value("${sportcred.files-location}")
	private String filesLocation;
	
	public Long addUser(SignUpInput newUser) {
		User user = new User();
		user.setEmail(newUser.getEmail());
		user.setUsername(newUser.getUsername());
		user.setAge(newUser.getAge());
		user.setFavoriteSport(newUser.getFavoriteSport());
		user.setFavoriteSportTeam(newUser.getFavoriteSportTeam());
		user.setLevelOfSportPlay(newUser.getLevelOfSportPlay());
		user.setWantToKnowSport(newUser.getWantToKnowSport());
		user.setAcsPoint(new BigDecimal(0));
		user.setTriviaAcsPoint(new BigDecimal(0));
		user.setPicksAcsPoint(new BigDecimal(0));
		user.setDebateAcsPoint(new BigDecimal(0));
		user.setParticipationAcsPoint(new BigDecimal(0));
		user.setBio("Tell us about youself");
		user = userDao.save(user);
		Long uid = user.getId();
//		recentViewTagService.getRecentViewTagByUid(uid);
//		recentViewTagService.addRecentViewTag(uid, newUser.getFavoriteSport());
		return uid;
	}
	
	public User findByEmail(String email) {
		return userDao.findByEmail(email);
	}
	
	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}
	
	public User findByUserId(Long userId) {
		Optional<User> user = userDao.findById(userId);
		if(user.isPresent()) {
			return user.get();
		} else {
			return null;
		}
	}
	
	public GetUserProfileOutput getUserProfileByUserId(Long userId) {
		User user = findByUserId(userId);
		if(user == null) {
			return null;
		}
		GetUserProfileOutput userProfile = new GetUserProfileOutput();
		userProfile.setAge(user.getAge());
		userProfile.setAvatarUrl(getAvatarUrlByUserId(userId));
		userProfile.setEmail(user.getEmail());
		userProfile.setFavoriteSport(user.getFavoriteSport());
		userProfile.setFavoriteSportTeam(user.getFavoriteSportTeam());
		userProfile.setLevelOfSportPlay(user.getLevelOfSportPlay());
		userProfile.setUsername(user.getUsername());
		userProfile.setWantToKnowSport(user.getWantToKnowSport());
		userProfile.setBio(user.getBio());
		userProfile.setAcsPoint(user.getAcsPoint().stripTrailingZeros().toPlainString());
		userProfile.setTriviaAcsPoint(user.getTriviaAcsPoint().stripTrailingZeros().toPlainString());
		userProfile.setDebateAcsPoint(user.getDebateAcsPoint().stripTrailingZeros().toPlainString());
		userProfile.setParticipationAcsPoint(user.getParticipationAcsPoint().stripTrailingZeros().toPlainString());
		userProfile.setPicksAcsPoint(user.getPicksAcsPoint().stripTrailingZeros().toPlainString());
		return userProfile;
	}
	
	public String getAvatarUrlByUserId(Long userId) {
		File dir = new File(filesLocation + "avatar");

		File[] matches = dir.listFiles(new FilenameFilter()
		{
		  public boolean accept(File dir, String name)
		  {
		     return name.startsWith(userId.toString() + '.');
		  }
		});
		
		if(matches.length == 0) {
			return "";
		} else {
			return "/avatar/" + matches[0].getName();
		}
	}
	
	public void updateUserProfile(UpdateUserProfileInput input, Long userId) {
		User user = findByUserId(userId);
		if(input.getAge() != null) user.setAge(input.getAge());
		if(input.getFavoriteSport() != null) user.setFavoriteSport(input.getFavoriteSport());
		if(input.getFavoriteSportTeam() != null) user.setFavoriteSportTeam(input.getFavoriteSportTeam());
		if(input.getLevelOfSportPlay() != null) user.setLevelOfSportPlay(input.getLevelOfSportPlay());
		if(input.getWantToKnowSport() != null) user.setWantToKnowSport(input.getWantToKnowSport());
		if(input.getBio() != null) user.setBio(input.getBio());
		userDao.save(user);
	}
	
	public GetAcsHistoryOutput getAcsHistory(Long userId, String module) {
		GetAcsHistoryOutput output = new GetAcsHistoryOutput();
		List<AcsHistory> historyList = null;
		if(module.equals("Overall")) {
			historyList = acsHistoryDao.findByUserId(userId);
		} else {
			historyList = acsHistoryDao.findByUserIdAndModule(userId, module);
		}
		for(AcsHistory history: historyList) {
			AcsHistoryOutput outputRecord = new AcsHistoryOutput();
			String changeAmount;
			if(!module.equals("Overall")) {
				changeAmount = history.getChangeAmount().stripTrailingZeros().toPlainString();
			} else {
				switch(history.getModule()) {
					case "Picks and Prediction":
						changeAmount = history.getChangeAmount().multiply(new BigDecimal("0.5")).stripTrailingZeros().toPlainString();
						break;
					case "Debate and Analyze":
						changeAmount = history.getChangeAmount().multiply(new BigDecimal("0.3")).stripTrailingZeros().toPlainString();
						break;
					case "Trivia":
						changeAmount = history.getChangeAmount().multiply(new BigDecimal("0.1")).stripTrailingZeros().toPlainString();
						break;
					case "Participation":
						changeAmount = history.getChangeAmount().multiply(new BigDecimal("0.1")).stripTrailingZeros().toPlainString();
						break;
					case "Trivia Head-to-head":
						changeAmount = history.getChangeAmount().stripTrailingZeros().toPlainString();
						break;
					default:
						changeAmount = "0";
				}
			}
			outputRecord.setChangeAmount(changeAmount);
			outputRecord.setDescription(history.getDescription());
			outputRecord.setModule(history.getModule());
			outputRecord.setTime(history.getTime());
			output.getAcsHistory().add(outputRecord);
		}
		return output;
	}
	
}
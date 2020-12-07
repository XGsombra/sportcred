package com.sportcred.service;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sportcred.dao.AcsHistoryDao;
import com.sportcred.dao.AnalyzePostAgreeDao;
import com.sportcred.dao.AnalyzePostDao;
import com.sportcred.dao.UserDao;
import com.sportcred.dto.AddAnalyzePostInput;
import com.sportcred.dto.DebateHomeOutput;
import com.sportcred.dto.GetAnalyzePostOutput;
import com.sportcred.dto.GetAnalyzePostsByUserIdOutput;
import com.sportcred.dto.wrapper.DebateHomeTopic;
import com.sportcred.entity.AcsHistory;
import com.sportcred.entity.AnalyzePost;
import com.sportcred.entity.AnalyzePostAgree;
import com.sportcred.entity.DebateTopic;
import com.sportcred.exception.OutOfPostException;
import com.sportcred.helper.Helper;

@Service
public class DebateAndAnalyzeService {
	@Autowired
	private AnalyzePostDao analyzePostDao;
	
	@Autowired
	private AnalyzePostAgreeDao analyzePostAgreeDao;
	
	@Autowired
	private DebateTopicService debateTopicService;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private AcsHistoryDao acsHistoryDao;
	
	@Value("${sportcred.files-location}")
	private String filesLocation;
	
	private String apiImagesLocation = "/analyze_posts/";
	
	private String getImagesLocation() {
		return filesLocation + apiImagesLocation;
	}
	
	public DebateHomeOutput getHome(Long userId) {
		DebateHomeOutput output = new DebateHomeOutput();
		String tier = getTier(userId);
		List<DebateHomeTopic> topics = new ArrayList<>();
		List<DebateTopic> rawTopics = debateTopicService.getTopicByTier(tier);
		for(DebateTopic rawTopic: rawTopics) {
			DebateHomeTopic topic = new DebateHomeTopic();
			topic.setId(rawTopic.getTid());
			topic.setTopic(rawTopic.getTopic());
			AnalyzePost post = analyzePostDao.findFirstByTopicIdOrderByAgreeRateDesc(topic.getId());
			if(post != null) {
				topic.setPopularAnalyzeId(analyzePostDao.findFirstByTopicIdOrderByAgreeRateDesc(topic.getId()).getId());
			} else {
				topic.setPopularAnalyzeId(0L);
			}
			topics.add(topic);
		}
		output.setTier(tier);
		output.setTopics(topics);
		return output;
	}
	
	private String getTier(Long userId) {
		BigDecimal acsPoint = userDao.findById(userId).get().getDebateAcsPoint();
		String tier;
		if(acsPoint.compareTo(new BigDecimal(100)) < 0) {
			tier = "Fanalyst";
		} else if(acsPoint.compareTo(new BigDecimal(200)) < 0) {
			tier = "Analyst";
		} else if(acsPoint.compareTo(new BigDecimal(300)) < 0) {
			tier = "Pro analyst";
		} else {
			tier = "Expert analyst";
		}
		return tier;
	}
	
	public void addPost(AddAnalyzePostInput input, Long userId, MultipartFile[] pictures) throws IllegalStateException, IOException {
		AnalyzePost post = new AnalyzePost();
		post.setAgreeRate(new BigDecimal(0));
		post.setContent(input.getContent());
		post.setCreatedTime(new Date().getTime());
		post.setRateCount(0);
		post.setTopicId(input.getTopicId());
		post.setUserId(userId);
		post.setIsActive(true);
		Long postId = analyzePostDao.save(post).getId();
		for (int i = 0; i < pictures.length;i++) {
			File imageDir = new File(getImagesLocation() + postId.toString());
			imageDir.mkdirs();
			pictures[i].transferTo(new File(imageDir.getPath() + "/" + i + Helper.getExtension(
					pictures[i].getOriginalFilename())));
		}
	}
	
	public void agreeOrDisagreePost(Long postId, Long userId, Integer agreeRate) {
		AnalyzePostAgree agree = new AnalyzePostAgree();
		agree.setAgreeRate(agreeRate);
		agree.setPostId(postId);
		agree.setUserId(userId);
		analyzePostAgreeDao.save(agree);
		
		AnalyzePost post = findPostById(postId);
		Integer rateCount = post.getRateCount();
		post.setRateCount(rateCount + 1);
		post.setAgreeRate(post.getAgreeRate().multiply(new BigDecimal(rateCount)).add(new BigDecimal(agreeRate)).divide(new BigDecimal(rateCount + 1), 2, RoundingMode.CEILING));
		analyzePostDao.save(post);
	}
	
	public AnalyzePost findPostById(Long id)  {
		Optional<AnalyzePost> post = analyzePostDao.findById(id);
		if(post.isPresent()) {
			return post.get();
		} else {
			return null;
		}
	}
	
	public GetAnalyzePostOutput getPostById(Long postId, Long userId) {
		AnalyzePost post = findPostById(postId);
		if(post == null) return null;
		List<String> pictures = new ArrayList<String>();
		File[] imgs = new File(getImagesLocation() + postId.toString()).listFiles();
		if (imgs != null) {
			for (File f: imgs) {
				String pathString = apiImagesLocation + postId.toString() + "/" + f.getName();
				pictures.add(pathString);
			}
		}
		GetAnalyzePostOutput output = new GetAnalyzePostOutput();
		output.setAgreeRate(post.getAgreeRate().toString());
		output.setContent(post.getContent());
		output.setCreatedTime(post.getCreatedTime());
		output.setRateCount(post.getRateCount());
		output.setPictures(pictures);
		output.setPostId(post.getId());
		output.setUserId(post.getUserId());
		output.setActive(post.getIsActive());
		DebateTopic topic = debateTopicService.getTopicById(post.getTopicId());
		output.setTopic(topic.getTopic());
		output.setTier(topic.getTier());
		
		AnalyzePostAgree agree = analyzePostAgreeDao.findByPostIdAndUserId(postId, userId);
		if(agree == null) output.setUserAgreeRate(-1);
		else output.setUserAgreeRate(agree.getAgreeRate());
		
		return output;
	}
	
	public GetAnalyzePostsByUserIdOutput GetAnalyzePostsByUserId(Long userId) {
		GetAnalyzePostsByUserIdOutput output = new GetAnalyzePostsByUserIdOutput();
		output.setPostIds(analyzePostDao.getPostsByUserId(userId));
		return output;
	}
	
	public Long getRandomUnreadActivePostIdByTopic(Long topicId, Long userId) throws OutOfPostException {
		List<Long> postIds = analyzePostDao.getActivePostsByTopicId(topicId);
		Long postId;
		int attemptNum = 0;
		while(attemptNum < 10) {
			postId = Helper.randomElement(postIds);
			if(!analyzePostAgreeDao.existsByPostIdAndUserId(postId, userId)) {
				return postId;
			}
			attemptNum++;
		}
		for(Long postIdx: postIds) {
			if(!analyzePostAgreeDao.existsByPostIdAndUserId(postIdx, userId)) {
				return postIdx;
			}
		}
		throw new OutOfPostException();
	}
	
	public void newRoundPosts() {
		List<AnalyzePost> posts = analyzePostDao.getActivePosts();
		for(AnalyzePost post:posts) {
			BigDecimal changeAmount = post.getAgreeRate().divide(new BigDecimal(10), 0, RoundingMode.CEILING);
			AcsHistory history = new AcsHistory();
			history.setChangeAmount(changeAmount);
			history.setDescription("Analyze got " + post.getAgreeRate() + "% agree rate");
			history.setModule("Debate and Analyze");
			history.setTime(System.currentTimeMillis());
			history.setUserId(post.getUserId());
			acsHistoryDao.save(history);
			userDao.changeAcsPoint(post.getUserId(), changeAmount.multiply(new BigDecimal("0.3")));
			userDao.changeDebateAcsPoint(post.getUserId(), changeAmount);
		}
		analyzePostDao.deactivateAllPosts();
	}
}

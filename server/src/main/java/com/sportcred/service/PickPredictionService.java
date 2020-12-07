package com.sportcred.service;

import com.sportcred.dao.AcsHistoryDao;
import com.sportcred.dao.PickPredictionTopicDao;
import com.sportcred.dao.PickPredictionUserAnswerDao;
import com.sportcred.dao.UserDao;
import com.sportcred.dto.GetPickPredictionOutput;
import com.sportcred.dto.wrapper.PickPredictionOutput;
import com.sportcred.entity.AcsHistory;
import com.sportcred.entity.PickPredictionTopic;
import com.sportcred.entity.PickPredictionUserAnswer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FilenameFilter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

@Service
public class PickPredictionService {

    @Autowired
    private PickPredictionTopicDao pickPredictionTopicDao;

    @Autowired
    private PickPredictionUserAnswerDao pickPredictionUserAnswerDao;
    
    @Autowired
    private UserDao userDao;
    
    @Autowired
    private AcsHistoryDao acsHistoryDao;
    
    @Value("${sportcred.files-location}")
	private String filesLocation;
    
    public GetPickPredictionOutput getPickPredictions(String type, Long userId) {
    	GetPickPredictionOutput output = new GetPickPredictionOutput();
    	List<PickPredictionOutput> lst = new ArrayList<>();
    	output.setPickPredictions(lst);
    	List<PickPredictionTopic> topics = pickPredictionTopicDao.findByTypeOrderByPpid(type);
    	for(PickPredictionTopic topic:topics) {
    		PickPredictionOutput oTopic = new PickPredictionOutput();
    		oTopic.setId(topic.getPpid());
    		oTopic.setContent(topic.getContent());
    		List<String> options = new ArrayList<>();
    		List<Integer> optionSelectedNumber = new ArrayList<>();
    		options.add(topic.getOp1());
    		options.add(topic.getOp2());
    		optionSelectedNumber.add(topic.getOp1Num());
    		optionSelectedNumber.add(topic.getOp2Num());
    		if(type.equals("prediction")) {
    			options.add(topic.getOp3());
    			options.add(topic.getOp4());
    			optionSelectedNumber.add(topic.getOp3Num());
    			optionSelectedNumber.add(topic.getOp4Num());
    		}
    		oTopic.setOptions(options);
    		oTopic.setOptionSelectedNumber(optionSelectedNumber);
    		oTopic.setAnswerIndex(topic.getAnswerIndex() == null ? -1: topic.getAnswerIndex());
    		PickPredictionUserAnswer userAnswer = pickPredictionUserAnswerDao.findByUidAndPpid(userId, topic.getPpid());
    		oTopic.setUserAnswerIndex(userAnswer == null ? -1: userAnswer.getUserAnswerIndex());
    		List<String> logos = new ArrayList<>();
    		if(type.equals("playoff")) {
    			if(!options.get(0).isEmpty()) {
    				logos.add(getLogoUrl(options.get(0)));
    			} else {
    				logos.add("");
    			}
    			if(!options.get(1).isEmpty()) {
    				logos.add(getLogoUrl(options.get(1)));
    			} else {
    				logos.add("");
    			}
    		}
    		oTopic.setLogos(logos);
    		lst.add(oTopic);
    	}
    	return output;
    }
    
    public String getLogoUrl(String team) {
		File dir = new File(filesLocation + "team_logo");

		File[] matches = dir.listFiles(new FilenameFilter()
		{
		  public boolean accept(File dir, String name)
		  {
		     return name.startsWith(team.toLowerCase() + '.');
		  }
		});
		
		if(matches.length == 0) {
			return "";
		} else {
			return "/team_logo/" + matches[0].getName();
		}
	}
    
    public void addUserAnswer(Long ppid, Long userId, Integer answerIndex) {
    	PickPredictionUserAnswer answer = new PickPredictionUserAnswer();
    	answer.setPpid(ppid);
    	answer.setUid(userId);
    	answer.setUserAnswerIndex(answerIndex);
    	pickPredictionUserAnswerDao.save(answer);
    	switch(answerIndex) {
    		case 0:
    			pickPredictionTopicDao.changeOp1Num(ppid, 1);
    			break;
    		case 1:
    			pickPredictionTopicDao.changeOp2Num(ppid, 1);
    			break;
    		case 2:
    			pickPredictionTopicDao.changeOp3Num(ppid, 1);
    			break;
    		case 3:
    			pickPredictionTopicDao.changeOp4Num(ppid, 1);
    			break;
    	}
    }
    
    public void addAnswer(Long ppid, Integer answerIndex) {
    	pickPredictionTopicDao.changeAnswer(ppid, answerIndex);
    	List<Long> rightUids = pickPredictionUserAnswerDao.getUidsByPpidAndAnswerIndex(ppid, answerIndex);
    	List<Long> wrongUids = pickPredictionUserAnswerDao.getUidsByPpidAndNotEqualAnswerIndex(ppid, answerIndex);
    	for(Long uid:rightUids) {
    		userDao.changeAcsPoint(uid, new BigDecimal("2.5"));
    		userDao.changePicksAcsPoint(uid, new BigDecimal(5));
    		AcsHistory history = new AcsHistory();
    		history.setChangeAmount(new BigDecimal(5));
    		history.setDescription("Successful prediction");
    		history.setModule("Picks and Prediction");
    		history.setTime(System.currentTimeMillis());
    		history.setUserId(uid);
    		acsHistoryDao.save(history);
    	}
    	for(Long uid:wrongUids) {
    		userDao.changeAcsPoint(uid, new BigDecimal("-2.5"));
    		userDao.changePicksAcsPoint(uid, new BigDecimal(-5));
    		AcsHistory history = new AcsHistory();
    		history.setChangeAmount(new BigDecimal(-5));
    		history.setDescription("Wrong prediction");
    		history.setModule("Picks and Prediction");
    		history.setTime(System.currentTimeMillis());
    		history.setUserId(uid);
    		acsHistoryDao.save(history);
    	}
    }
    
//    public void addPickTopic(String content, String op1, String op2){
//        pickPredictionTopicDao.insertPickTopic(content, op1, op2);
//    }
//
//    public void addPredictionTopic(String content, String op1, String op2, String op3, String op4){
//        pickPredictionTopicDao.insertPredictionTopic(content, op1, op2, op3, op4);
//    }
//
//    public void deactivate(Long ppid){
//        pickPredictionTopicDao.deactivateTopicByPpid(ppid);
//    }
//
//    public void activate(Long ppid){
//        pickPredictionTopicDao.activateTopicByPpid(ppid);
//    }
//
//    public List<PickPredictionTopic> getPickTopics(){
//        return pickPredictionTopicDao.getPickTopics();
//    }
//
//    public List<PickPredictionTopic> getPredictionTopics(){
//        return pickPredictionTopicDao.getPredictionTopics();
//    }
//
//    public String getAnswerByPpid(Long ppid){
//        return pickPredictionAnswerDao.getCorrectAnswerByPpid(ppid);
//    }
//
//    public void addAnswerByPpid(Long ppid, String answer){
//        pickPredictionAnswerDao.addCorrectAnswerByPpid(ppid, answer);
//    }
//
//    public void changeAnswerByPpid(Long ppid, String answer){
//        pickPredictionAnswerDao.changeCorrectAnswerByPpid(ppid, answer);
//    }
//
//    public List<Long> getCorrectUserByPpid(Long ppid){
//        String answer;
//        answer = pickPredictionAnswerDao.getCorrectAnswerByPpid(ppid);
//        return pickPredictionUserAnswerDao.getCorrectUser(ppid, answer);
//    }
//
//    public void addUserAnswer(Long uid, Long ppid, String answer){
//        pickPredictionUserAnswerDao.addUserAnswer(uid, ppid, answer);
//    }
//
//    public HashMap<String, Integer> getUserAnswerCountByPpid(Long ppid){
//        HashMap<String, Integer> count = new HashMap<>();
//        PickPredictionTopic pickPredictionTopic = pickPredictionTopicDao.getPickPredictionTopicByPpid(ppid);
//        count.put(pickPredictionTopic.getOp1(), 0);
//        count.put(pickPredictionTopic.getOp2(), 0);
//        if (pickPredictionTopic.getOp3() == null || pickPredictionTopic.getOp4() == null) {
//            count.put("op3", 0);
//            count.put("op4", 0);
//        } else {
//            count.put(pickPredictionTopic.getOp3(), 0);
//            count.put(pickPredictionTopic.getOp4(), 0);
//        }
//        System.out.println(count);
//        List<PickPredictionUserAnswer> userAnswerList = pickPredictionUserAnswerDao.getUserAnswerByPpid(ppid);
//        Iterator<PickPredictionUserAnswer> iterator = userAnswerList.iterator();
//        while (iterator.hasNext()){
//            PickPredictionUserAnswer pickPredictionUserAnswer = iterator.next();
//            String answer = pickPredictionUserAnswer.getUserAnswer();
//            count.put(answer, count.get(answer)+1);
//        }
//        return count;
//    }
}

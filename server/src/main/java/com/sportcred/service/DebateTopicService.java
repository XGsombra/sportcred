package com.sportcred.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sportcred.dao.DebateTopicDao;
import com.sportcred.entity.DebateTopic;
import com.sportcred.helper.Helper;

@Service
public class DebateTopicService {

    @Autowired
    DebateTopicDao debateTopicDao;

    public List<DebateTopic> getTopicByTier(String tier){
        return debateTopicDao.getTopicsByTier(tier);
    }

    public void regenerateTopics(){
        debateTopicDao.deactivateAllTopics();
        activateRandomTopics("Fanalyst");
        activateRandomTopics("Analyst");
        activateRandomTopics("Pro analyst");
        activateRandomTopics("Expert analyst");
    }
    
    private void activateRandomTopics(String tier) {
    	List<Long> topics = Helper.randomElements(debateTopicDao.getTidByTier(tier), 3);
    	for(Long topic:topics) {
    		debateTopicDao.activateTopicByTid(topic);
    	}
    }

    public void addTopic(String tier, String topic){
        debateTopicDao.addTopic(tier, topic);
    }

    public void activateTopicByTid(Long tid){
        debateTopicDao.activateTopicByTid(tid);
    }

    public void activeThreeTopicsForTier(Long seed, String tier){
        List<Long> tidList = debateTopicDao.getTidByTier(tier);
        Long[] tidArray = (Long[])tidList.toArray();
        int tidArrayLen = tidArray.length;
        Random random = new Random(seed);
        int topicToActivateNum = 3 - debateTopicDao.getActiveTopicNumByTier(tier);
        for (int i=0;i<topicToActivateNum;i++){
            int randomTid = random.nextInt(tidArrayLen);
            Long tidToActivate = tidList.get(randomTid);
            debateTopicDao.activateTopicByTid(tidToActivate);
        }
    }
    
    public DebateTopic getTopicById(Long topicId) {
		return debateTopicDao.findById(topicId).get();
	}
}

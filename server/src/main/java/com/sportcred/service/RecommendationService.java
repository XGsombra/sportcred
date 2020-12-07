package com.sportcred.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Scanner;
import java.util.Set;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.sportcred.dao.FollowDao;
import com.sportcred.dao.OpenCourtPostDao;
import com.sportcred.dao.TagDao;
import com.sportcred.dao.UserDao;
import com.sportcred.entity.OpenCourtPost;
import com.sportcred.entity.User;
import com.sportcred.helper.Helper;

@Service
public class RecommendationService {
	@Autowired
	private TagDao tagDao;
	
	@Autowired
	private FollowDao followDao;
	
	@Autowired
	private OpenCourtPostDao openCourtPostDao;
	
	@Autowired
	private UserDao userDao;
	
	private HashSet<String> potentialTags;
	
	private Map<Long, UserRecommendationData> allUsersData;
	
	public void setup() {
		allUsersData = new HashMap<>();
		List<User> users = userDao.findAll();
		for(User user:users) {
			UserRecommendationData userData = new UserRecommendationData();
			while(userData.recentTags.add(user.getFavoriteSportTeam().toLowerCase()));
			allUsersData.put(user.getId(), userData);
		}
		System.out.println("im run");
		
		//initialize tags
		List<String> tags = new ArrayList<>();
        String filename = "tags.csv";
        InputStream inputStream = null;
        try {
            inputStream = new ClassPathResource(filename).getInputStream();
            Scanner scanner = new Scanner(inputStream).useDelimiter(",");
            while (scanner.hasNext())
            {
                tags.add(scanner.next());
            }
            scanner.close();
        } catch (Exception e){
            System.out.println("Recommendation initialization failed.");
            e.printStackTrace();
        }
        potentialTags = new HashSet<String>(tags);
        System.out.println(potentialTags);
	}
	
	private class UserRecommendationData {
		private RecentTags recentTags = new RecentTags(5);
		private RecentViews recentViews = new RecentViews(100);
	}
	
	private class RecentTags implements Iterable<String> {
		private Queue<String> queue = new LinkedList<>();
		private Map<String, Integer> map = new HashMap<>();
		private int maxSize;
		private int size = 0;
		private RecentTags(int maxSize) {
			this.maxSize = maxSize;
		}
		private boolean add(String element) {
			queue.add(element);
			Integer num = map.get(element);
			if(num == null) {
				map.put(element, 1);
			} else {
				map.put(element, num + 1);
			}
			if(size == maxSize) {
				String removed = queue.remove();
				map.put(removed, map.get(removed)-1);
				return false;
			} else {
				size++;
				return true;
			}
		}
		private Integer getTagNum(String tag) {
			return map.get(tag);
		}
		@Override
		public Iterator<String> iterator() {
			return queue.iterator();
		}
	}
	
	private class RecentViews implements Iterable<Long> {
		private Queue<Long> queue = new LinkedList<>();
		private Set<Long> set = new HashSet<>();
		private int maxSize;
		private int size = 0;
		private RecentViews(int maxSize) {
			this.maxSize = maxSize;
		}
		private void add(Long element) {
			queue.add(element);
			set.add(element);
			if(size == maxSize) {
				queue.remove();
				set.remove(element);
			} else {
				size++;
			}
		}
		private boolean contains(Long element) {
			return set.contains(element);
		}
		@Override
		public Iterator<Long> iterator() {
			return queue.iterator();
		}
	}
	
	public void viewPost(Long postId, Long userId) {
		List<String> tagList = tagDao.getTagByPid(postId);
		RecentTags recentTags = allUsersData.get(userId).recentTags;
		for (String tag:tagList){
			recentTags.add(tag);
		}
	}
	
	public void addPostTags(OpenCourtPost post) {
		List<String> tagList = getTagFromPost(post.getContent());
		for (String tag:tagList){
			tagDao.addTag(post.getId(), tag);
		}
	}
	
	public List<Long> recommend(Long userId, int neededNum) {
		UserRecommendationData data = allUsersData.get(userId);
		RecentTags recentTags =  data.recentTags;
		RecentViews recentViews = data.recentViews;
		int i;
		List<Long> postIds;
		Long postId;
		Set<Long> selected = new HashSet<>();
//		if(recentViews.size == 0) {
//			selected.add(1L);
//			recentViews.add(1L);
//		}
		System.out.println("by tags");
		for(String tag:recentTags) {
			postIds = tagDao.getPidByTag(tag);
			addRandom(selected, postIds, recentTags.getTagNum(tag), recentViews);
		}
		System.out.println("by follow");
		List<Long> following = followDao.getAllFollowed(userId);
		postIds = openCourtPostDao.getByUserIds(following);
		i = 0;
		while(i < 2) {
			addRandom(selected, postIds, 2, recentViews);
			i++;
		}
		if(neededNum-selected.size() > 0) {
			System.out.println("by random");
			postIds = openCourtPostDao.getAllIds();
			while(neededNum > selected.size()) {
				if(postIds.size() == recentViews.size) return new ArrayList<>(selected);
				postId = Helper.randomElement(postIds);
				if(!selected.contains(postId) && !recentViews.contains(postId)) {
					selected.add(postId);
					recentViews.add(postId);
					System.out.println("added "+postId);
				}
			}
			System.out.println("finished");
		}
		return new ArrayList<>(selected);
	}
	
	private List<String> getTagFromPost(String content){
        String[] contentList = content.split("\\s+");
        List<String> containedTags = new ArrayList<>();
        for (int i=0;i<contentList.length;i++){
            String word = contentList[i].toLowerCase();
            if (potentialTags.contains(word)){
                containedTags.add(word);
            }
        }
        return containedTags;
    }
	
	private void addRandom(Set<Long> selected, List<Long> candidates, Integer neededNum, RecentViews recentViews) {
		int attemptNum = 0;
		boolean found = false;
		while(attemptNum < 10) {
			Long postId = Helper.randomElement(candidates);
			if(!selected.contains(postId) && !recentViews.contains(postId)) {
				selected.add(postId);
				System.out.println("added "+postId);
				recentViews.add(postId);
				found= true;
				break;
			}
			attemptNum++;
		}
		if(!found && (candidates.size() >= neededNum)) {
			for(Long postIdx: candidates) {
				if(!selected.contains(postIdx) && !recentViews.contains(postIdx)) {
					selected.add(postIdx);
					System.out.println("added "+postIdx);
					recentViews.add(postIdx);
					break;
				}
			}
		}
	}
}

package com.sportcred.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import com.sportcred.dao.TagDao;
import com.sportcred.entity.RecentViewTag;

@Service
public class TagsService {

    public HashSet<String> potentialTags;

    @Autowired
    private TagDao tagDao;

    @Autowired
    private OpenCourtService openCourtService;

    @Autowired
    private RecentViewTagService recentViewTagService;
    
    @PostConstruct
    public void initializePotentialTags(){
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

    public List<Long> getPidByTag(String tag){
        return tagDao.getPidByTag(tag);
    }

    public void addTag(Long pid, String tag){
        tagDao.addTag(pid, tag);
    }

    public List<String> getTagFromPost(String content){
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

    public List<Long> getRecommendationPid(Long uid, Long time){
        // returns at most 10 topics related.
        RecentViewTag recentViewTag = recentViewTagService.getRecentViewTagByUid(uid);
        List<Long> pidList = new ArrayList<Long>();
        List<String> tagList = new ArrayList<String>();
        if (recentViewTag.getTag1()!=null) tagList.add(recentViewTag.getTag1());
        if (recentViewTag.getTag2()!=null) tagList.add(recentViewTag.getTag2());
        if (recentViewTag.getTag3()!=null)tagList.add(recentViewTag.getTag3());
        if (recentViewTag.getTag4()!=null)tagList.add(recentViewTag.getTag4());
        if (recentViewTag.getTag5()!=null)tagList.add(recentViewTag.getTag5());
        if (recentViewTag.getTag6()!=null)tagList.add(recentViewTag.getTag6());
        if (recentViewTag.getTag7()!=null)tagList.add(recentViewTag.getTag7());
        if (recentViewTag.getTag8()!=null)tagList.add(recentViewTag.getTag8());
        if (recentViewTag.getTag9()!=null)tagList.add(recentViewTag.getTag9());
        if (recentViewTag.getTag10()!=null)tagList.add(recentViewTag.getTag10());
        for (String tag:tagList){
            Random rand = new Random();
            Long pid;
            List<Long> pids = tagDao.getPidByTag(tag);
            if (pids.isEmpty()){
                continue;
            }
            do {
                pid = pids.get(rand.nextInt(pids.size()));
            } while (pidList.contains(pid) || openCourtService.findPostById(pid).getCreatedTime() < time);
            pidList.add(pid);
        }
        return pidList;
    }
}

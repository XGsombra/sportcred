package com.sportcred.service;

import com.sportcred.dao.ViewPostDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ViewPostService {

    @Autowired
    private ViewPostDao viewPostDao;

    @Autowired
    private OpenCourtService openCourtService;

    @Autowired
    private RecentViewTagService recentViewTagService;

    @Autowired
    private TagsService tagsService;

    public List<Long> getViewPostPidByUid(Long uid){
        return viewPostDao.getViewPostPidByUid(uid);
    }

    public void addViewPost(Long uid, Long pid){
        viewPostDao.addViewPost(uid, pid);
        String content = openCourtService.getPost(pid, uid).getContent();
        List<String> tagList = tagsService.getTagFromPost(content);
        for (String tag:tagList){
            recentViewTagService.addRecentViewTag(uid, tag);
        }
    }
}

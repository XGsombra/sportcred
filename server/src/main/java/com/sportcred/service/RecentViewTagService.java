package com.sportcred.service;

import com.sportcred.dao.RecentViewTagDao;
import com.sportcred.entity.RecentViewTag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecentViewTagService {

    @Autowired
    private RecentViewTagDao recentViewTagDao;

    public void addRecentViewTag(Long uid, String tag){
        Long pointer = recentViewTagDao.getRecentViewTagPointer(uid);
        String tagX = "tag" + pointer.toString();
        recentViewTagDao.updateRecentViewTag(tagX, uid, tag);
        Long new_pointer = pointer + 1;
        if (new_pointer > 10) new_pointer = new_pointer - 10;
        recentViewTagDao.updateRecentViewTagPointer(new_pointer, uid);
    }

    public RecentViewTag getRecentViewTagByUid(Long uid){
        return recentViewTagDao.getRecentViewTagByUid(uid);
    }
}

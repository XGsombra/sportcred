package com.sportcred.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sportcred.dao.FollowDao;

@Service
public class FollowService {

    @Autowired
    FollowDao followDao;

    @Autowired
    AuthorizationService authorizationService;

    public List<Long> getAllFollower(Long followed){
        return followDao.getAllFollower(followed);
    }

    public List<Long> getAllFollowed(Long follower){
        return followDao.getAllFollowed(follower);
    }

    public void follow(Long follower, Long followed){
        followDao.follow(follower, followed);
    }

    public void unfollow(Long follower, Long followed){
        followDao.unfollow(follower, followed);
    }
    
    public Boolean existFollow(Long follower, Long followed) {
    	return followDao.existsByFollowerAndFollowed(follower, followed);
    }

}

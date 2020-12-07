package com.sportcred.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.sportcred.dao.CommentDao;
import com.sportcred.dao.LikesDao;
import com.sportcred.dao.OpenCourtPostDao;
import com.sportcred.dao.SubcommentDao;
import com.sportcred.entity.Likes;
import com.sportcred.exception.ImproperLikeOrCancelException;

@Service
public class LikesService {
	@Autowired
	private LikesDao likesDao;
	
	@Autowired
	private OpenCourtPostDao openCourtPostDao;
	
	@Autowired
    private CommentDao commentDao;
	
	@Autowired
    private SubcommentDao subcommentDao;
	
	/* like */
    public void addOrDeleteLikeOrUnlike(String type, Long id, Boolean isLike, Boolean isAdd, Long userId) throws ImproperLikeOrCancelException{
    	Integer changeAmount;
    	if(isAdd) {
    		Likes like = new Likes();
		    like.setContentId(id);
		    like.setType(type);
		    like.setUserId(userId);
		    like.setIsLik(isLike);
		    try {
		    	likesDao.save(like);
		    } catch (DataIntegrityViolationException e) {
		    	throw new ImproperLikeOrCancelException();
		    }
		    if(isLike) changeAmount = 1;
		    else changeAmount = -1;
    	} else {
    		if(likesDao.deleteByTypeAndContentIdAndUserIdAndIsLik(type, id, userId, isLike) == 0) {
    			throw new ImproperLikeOrCancelException();
    		}
    		if(isLike) changeAmount = -1;
    		else changeAmount = 1;
    	}
	     
	    switch(type) {
	    	case "openCourtPost":
	     		openCourtPostDao.changeLikes(id, changeAmount);
	     		break;
	    	case "comment":
	    		commentDao.changeLikes(id, changeAmount);
	    		break;
	    	case "subcomment":
	    		subcommentDao.changeLikes(id, changeAmount);
	    		break;
	    }
    }
    
    /* helper */
    public String getLikeCondition(String type, Long contentId, Long userId) {
    	String likeCondition;
		Likes like = likesDao.findByTypeAndContentIdAndUserId(type, contentId, userId);
		if(like == null) {
			likeCondition = "";
		} else if(like.getIsLik()) {
			likeCondition = "liked";
		} else {
			likeCondition = "unliked";
		}
		return likeCondition;
    }
}

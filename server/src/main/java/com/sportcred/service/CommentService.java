package com.sportcred.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sportcred.dao.CommentDao;
import com.sportcred.dao.SubcommentDao;
import com.sportcred.dto.AddCommentInput;
import com.sportcred.dto.AddSubcommentInput;
import com.sportcred.dto.GetCommentsByPostOutput;
import com.sportcred.dto.GetSubcommentByCommentOutput;
import com.sportcred.dto.wrapper.CommentOutput;
import com.sportcred.dto.wrapper.SubcommentOutput;
import com.sportcred.entity.Comment;
import com.sportcred.entity.Subcomment;

@Service
public class CommentService {
	@Autowired
    private CommentDao commentDao;
	
	@Autowired
    private SubcommentDao subcommentDao;
	
	@Autowired
    private LikesService likesService;
	
	/* comment */
	public Comment findCommentById(Long id)  {
		Optional<Comment> comment = commentDao.findById(id);
		if(comment.isPresent()) {
			return comment.get();
		} else {
			return null;
		}
	}

    public GetCommentsByPostOutput getCommentsByPost(Long postId, Long userId, String postType){
    	List<Comment> comments = commentDao.findByPostTypeAndPostIdOrderByCreatedTime(postType, postId);
    	List<CommentOutput> resultList = new ArrayList<>();
    	for(Comment comment: comments) {
    		CommentOutput outputComment = new CommentOutput();
    		outputComment.setContent(comment.getContent());
    		outputComment.setCreatedTime(comment.getCreatedTime());
    		outputComment.setId(comment.getId());
    		outputComment.setLikeCondition(likesService.getLikeCondition("comment", comment.getId(), userId));
    		outputComment.setLikeCount(comment.getLikeCount());
    		outputComment.setPostId(comment.getPostId());
    		outputComment.setUserId(comment.getUserId());
    		resultList.add(outputComment);
    	}
    	GetCommentsByPostOutput result = new GetCommentsByPostOutput();
    	result.setCommentList(resultList);
    	return result;
    }

    public void addComment(AddCommentInput input, Long userId, String postType){
        Comment comment = new Comment();
        comment.setContent(input.getContent());
        comment.setCreatedTime(new Date().getTime());
        comment.setLikeCount(0L);
        comment.setPostId(input.getPostId());
        comment.setUserId(userId);
        comment.setPostType(postType);
        commentDao.save(comment);
    }
    
    /* subcomment */
    public GetSubcommentByCommentOutput getSubcommentsByComment(Long commentId, Long userId){
    	List<Subcomment> subcomments = subcommentDao.findByCommentIdOrderByCreatedTime(commentId);
    	List<SubcommentOutput> resultList = new ArrayList<>();
    	for(Subcomment subcomment: subcomments) {
    		SubcommentOutput outputSubcomment = new SubcommentOutput();
    		outputSubcomment.setContent(subcomment.getContent());
    		outputSubcomment.setCreatedTime(subcomment.getCreatedTime());
    		outputSubcomment.setId(subcomment.getId());
    		outputSubcomment.setLikeCondition(likesService.getLikeCondition("subcomment", subcomment.getId(), userId));
    		outputSubcomment.setLikeCount(subcomment.getLikeCount());
    		outputSubcomment.setCommentId(subcomment.getCommentId());
    		outputSubcomment.setUserId(subcomment.getUserId());
    		outputSubcomment.setCommentToUserId(subcomment.getCommentToUserId());
    		resultList.add(outputSubcomment);
    	}
    	GetSubcommentByCommentOutput result = new GetSubcommentByCommentOutput();
    	result.setSubcomments(resultList);
    	return result;
    }
    
    public void addSubcomment(AddSubcommentInput input, Long userId){
        Subcomment subcomment = new Subcomment();
        subcomment.setContent(input.getContent());
        subcomment.setCreatedTime(new Date().getTime());
        subcomment.setLikeCount(0L);
        subcomment.setCommentId(input.getCommentId());
        subcomment.setUserId(userId);
        subcomment.setCommentToUserId(input.getCommentToUserId());
        subcommentDao.save(subcomment);
    }
}

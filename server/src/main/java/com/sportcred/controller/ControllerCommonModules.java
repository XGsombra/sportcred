package com.sportcred.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sportcred.dto.AddCommentInput;
import com.sportcred.dto.AddSubcommentInput;
import com.sportcred.dto.GetCommentsByPostOutput;
import com.sportcred.dto.GetSubcommentByCommentOutput;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.exception.ImproperLikeOrCancelException;
import com.sportcred.service.AuthorizationService;
import com.sportcred.service.CommentService;
import com.sportcred.service.LikesService;

@Component
public class ControllerCommonModules {
	@Autowired
    private AuthorizationService authorizationService;
    
    @Autowired
    private CommentService commentService;
    
    @Autowired
    private LikesService likesService;
    
    /* comment */
	public ResponseEntity<String> addComment(String token, String inputDataJson, String postType) {
    	try {
    		AddCommentInput inputData = new ObjectMapper().readValue(inputDataJson, AddCommentInput.class);
    		Long userId = authorizationService.parseToken(token);
            commentService.addComment(inputData, userId, postType);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e){
        	e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
	public ResponseEntity<GetCommentsByPostOutput> getCommentsByPost(String token, Long postId, String postType) {
        try {
        	Long userId = authorizationService.parseToken(token);
            GetCommentsByPostOutput outputData = commentService.getCommentsByPost(postId, userId, postType);
            return new ResponseEntity<>(outputData, HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e){
			e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
	/* subcomment */
	public ResponseEntity<String> addSubcomment(String token, String inputDataJson) {
    	try {
    		AddSubcommentInput inputData = new ObjectMapper().readValue(inputDataJson, AddSubcommentInput.class);
    		Long userId = authorizationService.parseToken(token);
            commentService.addSubcomment(inputData, userId);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e){
        	e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
	public ResponseEntity<GetSubcommentByCommentOutput> getSubcommentsByComment(String token, Long commentId) {
        try {
        	Long userId = authorizationService.parseToken(token);
            if (commentService.findCommentById(commentId) == null){
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            GetSubcommentByCommentOutput outputData = commentService.getSubcommentsByComment(commentId, userId);
            return new ResponseEntity<>(outputData, HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e){
			e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
	
	/* like */
	public ResponseEntity<String> addOrDeleteLikeOrUnlike(String token, String type, Long id, Boolean isLike, Boolean isAdd) {
        try {
        	Long userId = authorizationService.parseToken(token);
            likesService.addOrDeleteLikeOrUnlike(type, id, isLike, isAdd, userId);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch(ImproperLikeOrCancelException e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}

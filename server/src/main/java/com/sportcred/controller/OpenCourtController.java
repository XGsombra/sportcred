package com.sportcred.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sportcred.dto.AddOpenCourtPostInput;
import com.sportcred.dto.GetNewOpenCourtPostsOutput;
import com.sportcred.dto.GetCommentsByPostOutput;
import com.sportcred.dto.GetOpenCourtPostOutput;
import com.sportcred.dto.GetSubcommentByCommentOutput;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.service.AuthorizationService;
import com.sportcred.service.OpenCourtService;
import com.sportcred.service.RecommendationService;


@RestController
@RequestMapping(value = "open-court")
public class OpenCourtController {
	@Autowired
	private ControllerCommonModules commonModules;
	
	@Autowired
	private OpenCourtService openCourtService;

    @Autowired
    private AuthorizationService authorizationService;
    
    @Autowired
    private RecommendationService recommendationService;
    
	@PostMapping(value="/init")
	public void init() throws IllegalStateException, IOException {		
		openCourtService.dataSetup();
	}
	
	@PostMapping(value="/reset-recommendation")
	public void reset() throws IllegalStateException, IOException {		
		recommendationService.setup();
	}
    
    /* post */
	@PostMapping(value="/post", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> addOpenCourtPost(
			@RequestPart("data") String inputDataJson,
			@RequestPart MultipartFile[] pictures,
			@RequestHeader("Authorization") String token) {		
		try {
			AddOpenCourtPostInput inputData = new ObjectMapper().readValue(inputDataJson, AddOpenCourtPostInput.class);
			Long userId = authorizationService.parseToken(token);
			openCourtService.addPost(userId, inputData.getContent(), pictures);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping(value = "/new-posts", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetNewOpenCourtPostsOutput> getNewOpenCourtPosts(
			@RequestHeader("Authorization") String token) {
		try {
			Long uid = authorizationService.parseToken(token);
			// List<Long> postIds = openCourtService.getNewPosts(time);
			List<Long> postIds = openCourtService.getNewPostsWithRecommendation(uid, 7);
			GetNewOpenCourtPostsOutput outputData = new GetNewOpenCourtPostsOutput();
			outputData.setPostIds(postIds);
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value="/post/{id}/view")
	public ResponseEntity<String> viewOpenCourtPost(
			@RequestHeader("Authorization") String token,
			@PathVariable Long id) {		
		try {
			Long userId = authorizationService.parseToken(token);
			openCourtService.viewPost(id, userId);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping(value = "/post/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetOpenCourtPostOutput> getOpenCourtPost(
			@PathVariable Long id,
			@RequestHeader("Authorization") String token) {
		try {
			Long userId = authorizationService.parseToken(token);
			GetOpenCourtPostOutput outputData = openCourtService.getPost(id, userId);
			if(outputData == null) {
				return new ResponseEntity<>(outputData, HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
    
    /* comment */
	@PostMapping(value = "/comment", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<String> addOpenCourtComment(
            @RequestHeader("Authorization") String token,
            @RequestPart("data") String inputDataJson) {
    	return commonModules.addComment(token, inputDataJson, "openCourt");
    }
	
    @GetMapping(value = "/comment", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<GetCommentsByPostOutput> getOpenCourtCommentsByPost(
            @RequestHeader("Authorization") String token,
            @RequestParam Long postId) {
        return commonModules.getCommentsByPost(token, postId, "openCourt");
    }
    
    /* subcomment */
    @PostMapping(value = "/subcomment", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<String> addOpenCourtSubcomment(
            @RequestHeader("Authorization") String token,
            @RequestPart("data") String inputDataJson) {
    	return commonModules.addSubcomment(token, inputDataJson);
    }
    
    @GetMapping(value = "/subcomment", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<GetSubcommentByCommentOutput> getOpenCourtSubcommentsByComment(
            @RequestHeader("Authorization") String token,
            @RequestParam Long commentId) {
        return commonModules.getSubcommentsByComment(token, commentId);
    }
    
    /* like */
	@PostMapping(value = "/post/{id}/like")
    public ResponseEntity<String> likeOpenCourtPost(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "openCourtPost", id, true, true);
    }
	
	@PostMapping(value = "/post/{id}/unlike")
    public ResponseEntity<String> unlikeOpenCourtPost(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "openCourtPost", id, false, true);
    }
	
	@PostMapping(value = "/comment/{id}/like")
    public ResponseEntity<String> likeOpenCourtComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, true, true);
    }
	
	@PostMapping(value = "/comment/{id}/unlike")
    public ResponseEntity<String> unlikeOpenCourtComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, false, true);
    }
	
	@PostMapping(value = "/subcomment/{id}/like")
    public ResponseEntity<String> likeOpenCourtSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, true, true);
    }
	
	@PostMapping(value = "/subcomment/{id}/unlike")
    public ResponseEntity<String> unlikeOpenCourtSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, false, true);
    }
	
	@DeleteMapping(value = "/post/{id}/like")
    public ResponseEntity<String> deleteLikeOpenCourtPost(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "openCourtPost", id, true, false);
    }
	
	@DeleteMapping(value = "/post/{id}/unlike")
    public ResponseEntity<String> deleteUnlikeOpenCourtPost(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "openCourtPost", id, false, false);
    }
	
	@DeleteMapping(value = "/comment/{id}/like")
    public ResponseEntity<String> deleteLikeOpenCourtComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, true, false);
    }
	
	@DeleteMapping(value = "/comment/{id}/unlike")
    public ResponseEntity<String> deleteUnlikeOpenCourtComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, false, false);
    }
	
	@DeleteMapping(value = "/subcomment/{id}/like")
    public ResponseEntity<String> deleteLikeOpenCourtSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, true, false);
    }
	
	@DeleteMapping(value = "/subcomment/{id}/unlike")
    public ResponseEntity<String> deleteUnlikeOpenCourtSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, false, false);
    }
}

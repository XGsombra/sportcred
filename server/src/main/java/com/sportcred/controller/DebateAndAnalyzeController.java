package com.sportcred.controller;

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
import com.sportcred.dto.AddAnalyzePostInput;
import com.sportcred.dto.AddTopicInput;
import com.sportcred.dto.DebateHomeOutput;
import com.sportcred.dto.GetAnalyzePostOutput;
import com.sportcred.dto.GetAnalyzePostsByUserIdOutput;
import com.sportcred.dto.GetCommentsByPostOutput;
import com.sportcred.dto.GetSubcommentByCommentOutput;
import com.sportcred.dto.GetTopicsOutput;
import com.sportcred.dto.RateAnalyzePostInput;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.exception.OutOfPostException;
import com.sportcred.service.AuthorizationService;
import com.sportcred.service.DebateAndAnalyzeService;
import com.sportcred.service.DebateTopicService;

@RestController
@RequestMapping(value = "debate-and-analyze")
public class DebateAndAnalyzeController {
	@Autowired
	private ControllerCommonModules commonModules;
	
	@Autowired
    private AuthorizationService authorizationService;
	
	@Autowired
	private DebateAndAnalyzeService debateAndAnalyzeService;

	@Autowired
	private DebateTopicService debateTopicService;

	/* post */
	@GetMapping(value="/home", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<DebateHomeOutput> DebateHome(
			@RequestHeader("Authorization") String token) {		
		try {
			Long userId = authorizationService.parseToken(token);
			DebateHomeOutput outputData = debateAndAnalyzeService.getHome(userId);
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value="/post", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> addAnalyzePost(
			@RequestPart("data") String inputDataJson,
			@RequestPart MultipartFile[] pictures,
			@RequestHeader("Authorization") String token) {		
		try {
			AddAnalyzePostInput inputData = new ObjectMapper().readValue(inputDataJson, AddAnalyzePostInput.class);
			Long userId = authorizationService.parseToken(token);
			debateAndAnalyzeService.addPost(inputData, userId, pictures);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value="/post/{id}/agree-rate")
	public ResponseEntity<String> rateAnalyzePost(
			@RequestHeader("Authorization") String token,
			@PathVariable Long id,
			@RequestPart("data") String inputDataJson) {		
		try {
			RateAnalyzePostInput inputData = new ObjectMapper().readValue(inputDataJson, RateAnalyzePostInput.class);
			Long userId = authorizationService.parseToken(token);
			debateAndAnalyzeService.agreeOrDisagreePost(id, userId, inputData.getAgreeRate());
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
	public ResponseEntity<GetAnalyzePostOutput> getAnalyzePostById(
			@PathVariable Long id,
			@RequestHeader("Authorization") String token) {
		try {
			Long userId = authorizationService.parseToken(token);
			GetAnalyzePostOutput outputData = debateAndAnalyzeService.getPostById(id, userId);
			if(outputData == null) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
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
	
	@GetMapping(value = "/post", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetAnalyzePostsByUserIdOutput> getAnalyzePostsByUserId(
			@RequestParam Long userId,
			@RequestHeader("Authorization") String token) {
		try {
			authorizationService.parseToken(token);
			GetAnalyzePostsByUserIdOutput outputData = debateAndAnalyzeService.GetAnalyzePostsByUserId(userId);
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping(value = "/random-post", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetAnalyzePostOutput> getAnalyzePostByTopicRandom(
			@RequestParam Long topicId,
			@RequestHeader("Authorization") String token) {
		try {
			Long userId = authorizationService.parseToken(token);
			Long postId = debateAndAnalyzeService.getRandomUnreadActivePostIdByTopic(topicId, userId);
			GetAnalyzePostOutput outputData = debateAndAnalyzeService.getPostById(postId, userId);
			if(outputData == null) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(OutOfPostException e) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
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
    public ResponseEntity<String> addAnalyzeComment(
            @RequestHeader("Authorization") String token,
            @RequestPart("data") String inputDataJson) {
    	return commonModules.addComment(token, inputDataJson, "analyze");
    }
	
    @GetMapping(value = "/comment", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<GetCommentsByPostOutput> getAnalyzeCommentsByPost(
            @RequestHeader("Authorization") String token,
            @RequestParam Long postId) {
        return commonModules.getCommentsByPost(token, postId, "analyze");
    }
    
    /* subcomment */
    @PostMapping(value = "/subcomment", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<String> addAnalyzeSubcomment(
            @RequestHeader("Authorization") String token,
            @RequestPart("data") String inputDataJson) {
    	return commonModules.addSubcomment(token, inputDataJson);
    }
    
    @GetMapping(value = "/subcomment", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<GetSubcommentByCommentOutput> getAnalyzeSubcommentsByComment(
            @RequestHeader("Authorization") String token,
            @RequestParam Long commentId) {
        return commonModules.getSubcommentsByComment(token, commentId);
    }
    
    /* like */
	@PostMapping(value = "/comment/{id}/like")
    public ResponseEntity<String> likeAnalyzeComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, true, true);
    }
	
	@PostMapping(value = "/comment/{id}/unlike")
    public ResponseEntity<String> unlikeAnalyzeComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, false, true);
    }
	
	@PostMapping(value = "/subcomment/{id}/like")
    public ResponseEntity<String> likeAnalyzeSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, true, true);
    }
	
	@PostMapping(value = "/subcomment/{id}/unlike")
    public ResponseEntity<String> unlikeAnalyzeSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, false, true);
    }
	
	@DeleteMapping(value = "/comment/{id}/like")
    public ResponseEntity<String> deleteLikeAnalyzeComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, true, false);
    }
	
	@DeleteMapping(value = "/comment/{id}/unlike")
    public ResponseEntity<String> deleteUnlikeAnalyzeComment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "comment", id, false, false);
    }
	
	@DeleteMapping(value = "/subcomment/{id}/like")
    public ResponseEntity<String> deleteLikeAnalyzeSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, true, false);
    }
	
	@DeleteMapping(value = "/subcomment/{id}/unlike")
    public ResponseEntity<String> deleteUnlikeAnalyzeSubcomment(
            @RequestHeader("Authorization") String token,
            @PathVariable Long id) {
        return commonModules.addOrDeleteLikeOrUnlike(token, "subcomment", id, false, false);
    }
	
	
	/* topic */
	@PostMapping(value = "/topic")
	public ResponseEntity<String> getTopicName(
			@RequestPart("data") String inputDataJson) {
		try{
			AddTopicInput inputData = new ObjectMapper().readValue(inputDataJson, AddTopicInput.class);
			String topic = inputData.getTopic();
			String tier = inputData.getTier();
			debateTopicService.addTopic(tier, topic);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping(value = "/topic/tier")
	public ResponseEntity<GetTopicsOutput> getTopicsByTier(
			@RequestParam String tier,
			@RequestHeader("Authorization") String token) {
		try{
			GetTopicsOutput outputData = new GetTopicsOutput();
			outputData.setTopicList(debateTopicService.getTopicByTier(tier));
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/* new round */
	@PostMapping(value = "/new-round")
	public ResponseEntity<String> newRound(
			@RequestHeader("Authorization") String token) {
		try{
			debateTopicService.regenerateTopics();
			debateAndAnalyzeService.newRoundPosts();
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}

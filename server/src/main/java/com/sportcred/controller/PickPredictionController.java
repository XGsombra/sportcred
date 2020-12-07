package com.sportcred.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sportcred.dto.AddAnswerInput;
import com.sportcred.dto.AddOpenCourtPostInput;
import com.sportcred.dto.AddPickInput;
import com.sportcred.dto.AddPickPredictionAnswerInput;
import com.sportcred.dto.AddPredictionInput;
import com.sportcred.dto.GetCorrectAnswerOutput;
import com.sportcred.dto.GetCorrectUserOutput;
import com.sportcred.dto.GetFollowerFollowedOutput;
import com.sportcred.dto.GetPickPredictionOutput;
import com.sportcred.dto.GetUserAnswerCountOutput;
import com.sportcred.entity.PickPredictionTopic;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.service.AuthorizationService;
import com.sportcred.service.PickPredictionService;

@RestController
@RequestMapping(value = "pick-prediction")
public class PickPredictionController {

    @Autowired
    private PickPredictionService pickPredictionService;

    @Autowired
    private AuthorizationService authorizationService;

    @GetMapping(value = "/topic", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<GetPickPredictionOutput> getAllPicks(
            @RequestHeader("Authorization") String token,
            @RequestParam String type) {
        try {
            Long userId = authorizationService.parseToken(token);
            return new ResponseEntity<>(pickPredictionService.getPickPredictions(type, userId), HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping(value="/topic/{topicId}/user-answer", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> addPickPredictionUserAnswer(
			@RequestPart("data") String inputDataJson,
			@PathVariable Long topicId,
			@RequestHeader("Authorization") String token) {		
		try {
			AddPickPredictionAnswerInput inputData = new ObjectMapper().readValue(inputDataJson, AddPickPredictionAnswerInput.class);
			Long userId = authorizationService.parseToken(token);
			pickPredictionService.addUserAnswer(topicId, userId, inputData.getAnswerIndex());
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
    
    @PostMapping(value="/topic/{topicId}/answer", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> addPickPredictionAnswer(
			@RequestPart("data") String inputDataJson,
			@PathVariable Long topicId,
			@RequestHeader("Authorization") String token) {		
		try {
			AddPickPredictionAnswerInput inputData = new ObjectMapper().readValue(inputDataJson, AddPickPredictionAnswerInput.class);
			Long userId = authorizationService.parseToken(token);
			pickPredictionService.addAnswer(topicId, inputData.getAnswerIndex());
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

//    @GetMapping(value = "/prediction", produces = MediaType.APPLICATION_JSON_VALUE)
//    public ResponseEntity<GetPickPredictionOutput> getAllPredictions(
//            @RequestHeader("Authorization") String token) {
//        try {
//            authorizationService.parseToken(token);
//            List<PickPredictionTopic> topics = pickPredictionService.getPredictionTopics();
//            GetPickPredictionOutput outputData = new GetPickPredictionOutput();
//            outputData.setPickPredictionTopicList(topics);
//            return new ResponseEntity<>(outputData, HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PostMapping(value="/pick", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
//    public ResponseEntity<String> addPickTopic(
//            @RequestPart("data") String inputDataJson,
//            @RequestHeader("Authorization") String token) {
//        try {
//            AddPickInput inputData = new ObjectMapper().readValue(inputDataJson, AddPickInput.class);
//            authorizationService.parseToken(token);
//            String content = inputData.getContent();
//            String op1 = inputData.getOp1();
//            String op2 = inputData.getOp2();
//            pickPredictionService.addPickTopic(content, op1, op2);
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PostMapping(value="/prediction", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
//    public ResponseEntity<String> addPredictionTopic(
//            @RequestPart("data") String inputDataJson,
//            @RequestHeader("Authorization") String token) {
//        try {
//            AddPredictionInput inputData = new ObjectMapper().readValue(inputDataJson, AddPredictionInput.class);
//            authorizationService.parseToken(token);
//            String content = inputData.getContent();
//            String op1 = inputData.getOp1();
//            String op2 = inputData.getOp2();
//            String op3 = inputData.getOp3();
//            String op4 = inputData.getOp4();
//            pickPredictionService.addPredictionTopic(content, op1, op2, op3, op4);
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PostMapping(value = "/activate/{ppid}")
//    public ResponseEntity<GetFollowerFollowedOutput> activate(
//            @PathVariable Long ppid,
//            @RequestHeader("Authorization") String token) {
//        try {
//            Long follower = authorizationService.parseToken(token);
//            pickPredictionService.activate(ppid);
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e){
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PostMapping(value = "/deactivate/{ppid}")
//    public ResponseEntity<GetFollowerFollowedOutput> deactivate(
//            @PathVariable Long ppid,
//            @RequestHeader("Authorization") String token) {
//        try {
//            Long follower = authorizationService.parseToken(token);
//            pickPredictionService.deactivate(ppid);
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e){
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @GetMapping(value = "/answer/{ppid}", produces = MediaType.APPLICATION_JSON_VALUE)
//    public ResponseEntity<GetCorrectAnswerOutput> getCorrectAnswer(
//            @PathVariable Long ppid,
//            @RequestHeader("Authorization") String token) {
//        try {
//            authorizationService.parseToken(token);
//            GetCorrectAnswerOutput outputData = new GetCorrectAnswerOutput();
//            outputData.setAnswer(pickPredictionService.getAnswerByPpid(ppid));
//
//            return new ResponseEntity<>(outputData, HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @GetMapping(value = "/user/{ppid}", produces = MediaType.APPLICATION_JSON_VALUE)
//    public ResponseEntity<GetCorrectUserOutput> getCorrectUsers(
//            @PathVariable Long ppid,
//            @RequestHeader("Authorization") String token) {
//        try {
//            authorizationService.parseToken(token);
//            List<Long> uids = pickPredictionService.getCorrectUserByPpid(ppid);
//            GetCorrectUserOutput outputData = new GetCorrectUserOutput();
//            outputData.setUids(uids);
//            return new ResponseEntity<>(outputData, HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @GetMapping(value = "/user/count/{ppid}", produces = MediaType.APPLICATION_JSON_VALUE)
//    public ResponseEntity<GetUserAnswerCountOutput> getUserAnswerCount(
//            @PathVariable Long ppid,
//            @RequestHeader("Authorization") String token) {
//        try {
//            authorizationService.parseToken(token);
//            GetUserAnswerCountOutput outputData = new GetUserAnswerCountOutput();
//            HashMap<String, Integer> count = pickPredictionService.getUserAnswerCountByPpid(ppid);
//            Iterator<String> keyIterator = count.keySet().iterator();
//            String key = keyIterator.next();
//            outputData.setAnswer1(key);
//            outputData.setCount1(count.get(key));
//            key = keyIterator.next();
//            outputData.setAnswer2(key);
//            outputData.setCount2(count.get(key));
//            key = keyIterator.next();
//            outputData.setAnswer3(key);
//            outputData.setCount3(count.get(key));
//            key = keyIterator.next();
//            outputData.setAnswer4(key);
//            outputData.setCount4(count.get(key));
//            return new ResponseEntity<>(outputData, HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PostMapping(value = "/answer", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
//    public ResponseEntity<GetFollowerFollowedOutput> addCorrectAnswer(
//            @RequestPart("data") String inputDataJson,
//            @RequestHeader("Authorization") String token) {
//        try {
//            authorizationService.parseToken(token);
//            AddAnswerInput inputData = new ObjectMapper().readValue(inputDataJson, AddAnswerInput.class);
//            Long ppid = inputData.getPpid();
//            String answer = inputData.getAnswer();
//            pickPredictionService.addAnswerByPpid(ppid, answer);
//
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e){
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PutMapping(value = "/answer", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
//    public ResponseEntity<GetFollowerFollowedOutput> changeCorrectAnswer(
//            @RequestPart("data") String inputDataJson,
//            @RequestHeader("Authorization") String token) {
//        try {
//            authorizationService.parseToken(token);
//            AddAnswerInput inputData = new ObjectMapper().readValue(inputDataJson, AddAnswerInput.class);
//            Long ppid = inputData.getPpid();
//            String answer = inputData.getAnswer();
//            pickPredictionService.changeAnswerByPpid(ppid, answer);
//
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e){
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }
//
//    @PostMapping(value = "/user-answer", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
//    public ResponseEntity<GetCorrectUserOutput> addUserAnswer(
//            @RequestPart("data") String inputDataJson,
//            @RequestHeader("Authorization") String token) {
//        try {
//            Long uid = authorizationService.parseToken(token);
//            AddAnswerInput inputData = new ObjectMapper().readValue(inputDataJson, AddAnswerInput.class);
//            Long ppid = inputData.getPpid();
//            String answer = inputData.getAnswer();
//            pickPredictionService.addUserAnswer(uid, ppid, answer);
//            return new ResponseEntity<>(HttpStatus.OK);
//        } catch(AuthorizationFailureException e) {
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
//        } catch (Exception e){
//            e.printStackTrace();
//            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        }
//    }



}

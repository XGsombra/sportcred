package com.sportcred.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sportcred.dto.AddHeadToHeadResultInput;
import com.sportcred.dto.AddSoloResultInput;
import com.sportcred.dto.GetNewMatchOutput;
import com.sportcred.dto.GetQuestionSetOutput;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.service.AuthorizationService;
import com.sportcred.service.TriviaService;

@RestController
@RequestMapping(value = "trivia")
public class TriviaController {
	@Autowired
	private TriviaService triviaService;
	
	@Autowired
    private AuthorizationService authorizationService;
	
	/* solo */
	@GetMapping(value="/solo/question-set", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetQuestionSetOutput> getQuestionSet(
			@RequestHeader("Authorization") String token) {		
		try {
			authorizationService.parseToken(token);
			GetQuestionSetOutput outputData = triviaService.getQuestionSet();
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value="/solo/result", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> addSoloResult(
			@RequestHeader("Authorization") String token,
			@RequestPart("data") String inputDataJson) {		
		try {
			AddSoloResultInput inputData = new ObjectMapper().readValue(inputDataJson, AddSoloResultInput.class);
			Long userId = authorizationService.parseToken(token);
			triviaService.addSoloResult(inputData, userId);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/* head to head */
	@GetMapping(value="/head-to-head/new-match", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetNewMatchOutput> getNewMatch(
			@RequestHeader("Authorization") String token) {		
		try {
			Long userId = authorizationService.parseToken(token);
			GetNewMatchOutput outputData = triviaService.getNewMatch(userId);
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@DeleteMapping(value="/head-to-head/new-match")
	public ResponseEntity<String> cancelNewMatch(
			@RequestHeader("Authorization") String token) {		
		try {
			Long userId = authorizationService.parseToken(token);
			triviaService.cancelNewMatch(userId);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value="/head-to-head/result", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> addHeadToHeadResult(
			@RequestHeader("Authorization") String token,
			@RequestPart("data") String inputDataJson) {		
		try {
			AddHeadToHeadResultInput inputData = new ObjectMapper().readValue(inputDataJson, AddHeadToHeadResultInput.class);
			Long userId = authorizationService.parseToken(token);
			triviaService.addHeadToHeadResult(inputData.getRoomId(), userId);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}

package com.sportcred.controller;

import java.sql.Time;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.StaticApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.sportcred.dto.GetPickPredictionOutput;
import com.sportcred.dto.ScoreTickerResponse;
import com.sportcred.dto.ScoreTicketExternalApiOutput;
import com.sportcred.entity.PickPredictionTopic;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.service.AuthorizationService;

@RestController
@RequestMapping(value = "score-ticker")
public class ScoreTickerController {
	private static ScoreTickerResponse cache;
	private static long lastUpdateTime = 0; 
	private AuthorizationService authorizationService;
	public static final long CACHE_TIME = 600000;
	public static final String NBA_API = "http://api.isportsapi.com/sport/basketball/schedule/basic?api_key=BOr2pVIwwQdvRvQJ&leagueId=111";
	@Autowired
	private RestTemplate restTemplate;
	
	@Configuration
	public static class RestTemplateConfig {
	    @Bean
	    public RestTemplate restTemplate(ClientHttpRequestFactory factory){
	        return new RestTemplate(factory);
	    }
	    @Bean
	    public ClientHttpRequestFactory simpleClientHttpRequestFactory(){
	        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
	        factory.setReadTimeout(10000);
	        factory.setConnectTimeout(10000);
	        return factory;
	    }
	}
	
	@GetMapping(value = "/NBA", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ScoreTickerResponse> getAllPicks(
            //@RequestHeader("Authorization") String token
            ) {
        try {
        	long currentTime = (new Date()).getTime();
        	if (cache == null || currentTime - lastUpdateTime > CACHE_TIME) {
        		cache = restTemplate.getForEntity(NBA_API, ScoreTicketExternalApiOutput.class).getBody().getEssence();
        	}
        	//authorizationService.parseToken(token);
            return new ResponseEntity<>(cache, HttpStatus.OK);
        /*} catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);*/
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}

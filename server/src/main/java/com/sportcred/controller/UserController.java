package com.sportcred.controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
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
import com.sportcred.dto.AuthenticateInput;
import com.sportcred.dto.AuthenticateOutput;
import com.sportcred.dto.CheckEmailUsernameExistenceOutput;
import com.sportcred.dto.GetAcsHistoryOutput;
import com.sportcred.dto.GetFollowerFollowedOutput;
import com.sportcred.dto.GetUserProfileOutput;
import com.sportcred.dto.SignUpInput;
import com.sportcred.dto.UpdateUserProfileInput;
import com.sportcred.entity.User;
import com.sportcred.exception.AuthorizationFailureException;
import com.sportcred.helper.Helper;
import com.sportcred.service.AuthorizationService;
import com.sportcred.service.FollowService;
import com.sportcred.service.UserAuthService;
import com.sportcred.service.UserService;

@RestController
@RequestMapping(value = "user")
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserAuthService userAuthService;
	
	@Autowired
	private FollowService followService;
	
	@Autowired
	private AuthorizationService authorizationService;
	
	@Value("${sportcred.files-location}")
	private String filesLocation;
	
	/* sign up */
	@GetMapping(value = "/email-username-existence", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CheckEmailUsernameExistenceOutput> checkEmailUsernameExistence(
			@RequestParam String email, 
			@RequestParam String username){
		try {
			boolean emailExists = userService.findByEmail(email) != null;
			boolean usernameExists = userService.findByUsername(username) != null;
			CheckEmailUsernameExistenceOutput outputData = new CheckEmailUsernameExistenceOutput();
			outputData.setEmailExists(emailExists);
			outputData.setUsernameExists(usernameExists);
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CheckEmailUsernameExistenceOutput> signUp(
			@RequestPart("data") String inputDataJson,
			@RequestPart MultipartFile avatar) {
		try {
			SignUpInput inputData = new ObjectMapper().readValue(inputDataJson, SignUpInput.class);
			boolean emailExists = userService.findByEmail(inputData.getEmail()) != null;
			boolean usernameExists = userService.findByUsername(inputData.getUsername()) != null;
			if(!emailExists && !usernameExists) {
				Long userId = userService.addUser(inputData);
				userAuthService.addUserAuth(userId, "email", inputData.getEmail(), inputData.getPassword());
				userAuthService.addUserAuth(userId, "username", inputData.getUsername(), inputData.getPassword());
				avatar.transferTo(new File(filesLocation + "avatar/" + userId + Helper.getExtension(avatar.getOriginalFilename())));
				return new ResponseEntity<>(null, HttpStatus.OK);
			} else {
				CheckEmailUsernameExistenceOutput outputData = new CheckEmailUsernameExistenceOutput();
				outputData.setEmailExists(emailExists);
				outputData.setUsernameExists(usernameExists);
				return new ResponseEntity<>(outputData, HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/* sign in */
	@PostMapping(value = "/authentication", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<AuthenticateOutput> authenticate(
			@RequestPart("data") String inputDataJson){
		try {
			AuthenticateInput inputData = new ObjectMapper().readValue(inputDataJson, AuthenticateInput.class);
			String type;
			User user;
			if(inputData.getId().contains("@")) {
				type = "email";
				user = userService.findByEmail(inputData.getId());
			} else {
				type = "username";
				user = userService.findByUsername(inputData.getId());
			}
			if(userAuthService.authenticate(type, inputData.getId(), inputData.getPassword())) {	
				AuthenticateOutput outputData = new AuthenticateOutput();
				outputData.setAccessToken(authorizationService.generateToken(user.getId()));
				outputData.setUserId(user.getId());
				return new ResponseEntity<>(outputData, HttpStatus.OK);
			} else {
				return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/* profile */
	@GetMapping(value = "/{userId}/profile", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<GetUserProfileOutput> getUserProfile(
			@PathVariable Long userId,
			@RequestHeader("Authorization") String token) {
		try {
			Long myUserId = authorizationService.parseToken(token);
			GetUserProfileOutput outputData = userService.getUserProfileByUserId(userId);
			outputData.setFollowed(followService.existFollow(myUserId, userId));
			return new ResponseEntity<>(outputData, HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PutMapping(value = "/{userId}/profile")
	public ResponseEntity<String> updateUserProfile(
			@RequestHeader("Authorization") String token,
			@RequestPart(value="data", required=false) String inputDataJson,
			@RequestPart(required=false) MultipartFile avatar,
			@PathVariable Long userId){
		try {
			Long myUserId = authorizationService.parseToken(token);
			if(myUserId != userId) {
				return new ResponseEntity<>(HttpStatus.FORBIDDEN);
			}
			if(inputDataJson != null) {
				UpdateUserProfileInput inputData = new ObjectMapper().readValue(inputDataJson, UpdateUserProfileInput.class);
				userService.updateUserProfile(inputData, userId);
			}
			if(avatar != null) {
				new File(filesLocation.substring(0, filesLocation.length()-1) + userService.getAvatarUrlByUserId(userId)).delete();
				avatar.transferTo(new File(filesLocation + "avatar/" + userId + Helper.getExtension(avatar.getOriginalFilename())));
			}
			return new ResponseEntity<>(HttpStatus.OK);
		} catch(AuthorizationFailureException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/* follow */
	@GetMapping(value = "/{userId}/followed")
    public ResponseEntity<GetFollowerFollowedOutput> getAllFollowed(
            @RequestHeader("Authorization") String token,
            @PathVariable Long userId) {
        try {
            authorizationService.parseToken(token);
            GetFollowerFollowedOutput outputData = new GetFollowerFollowedOutput();
            List<Long> resultList = followService.getAllFollowed(userId);
            outputData.setUserList(resultList);
            return new ResponseEntity<>(outputData, HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping(value = "/{userId}/follower")
    public ResponseEntity<GetFollowerFollowedOutput> getAllFollower(
            @RequestHeader("Authorization") String token,
            @PathVariable Long userId) {
        try {
            authorizationService.parseToken(token);
            GetFollowerFollowedOutput outputData = new GetFollowerFollowedOutput();
            List<Long> resultList = followService.getAllFollower(userId);
            outputData.setUserList(resultList);
            return new ResponseEntity<>(outputData, HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping(value = "/{userId}/follow")
    public ResponseEntity<GetFollowerFollowedOutput> follow(
            @PathVariable Long userId,
            @RequestHeader("Authorization") String token) {
        try {
            Long myUserId = authorizationService.parseToken(token);
            followService.follow(myUserId, userId);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping(value = "/{userId}/follow")
    public ResponseEntity<GetFollowerFollowedOutput> unfollow(
            @PathVariable Long userId,
            @RequestHeader("Authorization") String token) {
        try {
            Long myUserId = authorizationService.parseToken(token);
            followService.unfollow(myUserId, userId);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /* ACS */
    @GetMapping(value = "/{userId}/acs-history")
    public ResponseEntity<GetAcsHistoryOutput> getAcsHistory(
            @RequestHeader("Authorization") String token,
            @PathVariable Long userId,
            @RequestParam String module) {
        try {
            authorizationService.parseToken(token);
            return new ResponseEntity<>(userService.getAcsHistory(userId, module), HttpStatus.OK);
        } catch(AuthorizationFailureException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        } catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
package com.sportcred.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.sportcred.dao.UserAuthDao;
import com.sportcred.entity.UserAuth;

@Service
public class UserAuthService {
	@Autowired
	private UserAuthDao userAuthDao;
	
	@Value("${sportcred.jwt-secret}")
	private String jwtSecret;
	
	
	public boolean authenticate(String type, String identifier, String credential) {
		UserAuth userAuth = userAuthDao.findByTypeAndIdentifier(type, identifier);
		if(userAuth == null) {
			return false;
		} else {
			String storedHashedCredential = userAuth.getHashedCredential();
			return BCrypt.checkpw(credential, storedHashedCredential);
		}
		
	}
	
	public void addUserAuth(Long userId, String type, String identifier, String credential) {
		UserAuth userAuth = new UserAuth();
		userAuth.setUserId(userId);
		userAuth.setType(type);
		userAuth.setIdentifier(identifier);
		userAuth.setHashedCredential(BCrypt.hashpw(credential, BCrypt.gensalt()));
		userAuthDao.save(userAuth);
	}
}
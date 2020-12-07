package com.sportcred.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sportcred.exception.AuthorizationFailureException;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtParser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@Service
public class AuthorizationService {
	@Value("${sportcred.jwt-secret}")
	private String jwtSecret;
	
	public String generateToken(Long userId) {
        String compactTokenString = Jwts.builder()
                .claim("id", userId)
                .signWith(Keys.hmacShaKeyFor(jwtSecret.getBytes()), SignatureAlgorithm.HS256)
                .compact();

        return "Bearer " + compactTokenString;
    }
    
    public Long parseToken(String token) throws AuthorizationFailureException {
    	token = token.substring(7);
    	
    	JwtParser parser = Jwts.parserBuilder()
                .setSigningKey(jwtSecret.getBytes())
                .build();
    	
    	Jws<Claims> jwsClaims = null;
    	try {
    		jwsClaims = parser.parseClaimsJws(token);
    	} catch(Exception e) {
    		throw new AuthorizationFailureException();
    	}
        
        return jwsClaims.getBody().get("id", Long.class);
    }
}
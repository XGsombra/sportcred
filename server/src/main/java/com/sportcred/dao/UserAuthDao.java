package com.sportcred.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.UserAuth;

@Repository
public interface UserAuthDao extends JpaRepository<UserAuth, Long> {
	public UserAuth findByTypeAndIdentifier(String type, String identifier);
}

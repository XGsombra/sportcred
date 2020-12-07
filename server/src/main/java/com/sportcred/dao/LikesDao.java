package com.sportcred.dao;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.Likes;

@Transactional
@Repository
public interface LikesDao extends JpaRepository<Likes, Long> {
	public Likes findByTypeAndContentIdAndUserId(String type, Long contentId, Long userId);
	
	public long deleteByTypeAndContentIdAndUserIdAndIsLik(String type, Long contentId, Long userId, Boolean isLike);
}


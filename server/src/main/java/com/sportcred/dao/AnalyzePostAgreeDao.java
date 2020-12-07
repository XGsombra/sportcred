package com.sportcred.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.AnalyzePostAgree;

@Repository
public interface AnalyzePostAgreeDao extends JpaRepository<AnalyzePostAgree, Long> {
	public AnalyzePostAgree findByPostIdAndUserId(Long postId, Long userId);
	
	public Boolean existsByPostIdAndUserId(Long postId, Long userId);
}

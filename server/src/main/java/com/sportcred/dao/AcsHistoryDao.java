package com.sportcred.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.AcsHistory;

@Repository
public interface AcsHistoryDao extends JpaRepository<AcsHistory, Long> {
	public List<AcsHistory> findByUserId(Long userId);
	
	public List<AcsHistory> findByUserIdAndModule(Long userId, String module);
}

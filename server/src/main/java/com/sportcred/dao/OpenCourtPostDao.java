package com.sportcred.dao;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.OpenCourtPost;

@Repository
public interface OpenCourtPostDao extends JpaRepository<OpenCourtPost, Long> {
	@Query(value = "SELECT p.id FROM open_court_post p WHERE p.created_time > ?1", nativeQuery = true)
    public List<Long> getNewPosts(Long time);
	
	@Query(value = "SELECT p.id FROM open_court_post p WHERE p.user_id IN :user_ids", nativeQuery = true)
    public List<Long> getByUserIds(@Param("user_ids") List<Long> userIds);
	
	@Query(value = "SELECT p.id FROM open_court_post p", nativeQuery = true)
    public List<Long> getAllIds();
	
    @Modifying
    @Transactional
    @Query(value = "UPDATE open_court_post p SET p.like_count = (p.like_count + :change_amount) WHERE p.id = :id", nativeQuery = true)
    int changeLikes(@Param("id") Long id, @Param("change_amount") Integer changeAmount);
}

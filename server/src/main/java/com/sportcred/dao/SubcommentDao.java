package com.sportcred.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.Subcomment;

@Repository
public interface SubcommentDao extends JpaRepository<Subcomment, Long> {
	public List<Subcomment> findByCommentIdOrderByCreatedTime(Long commentId);
	
	@Modifying
	@Transactional
    @Query(value = "UPDATE subcomment s SET s.like_count = (s.like_count + :change_amount) WHERE s.id = :id", nativeQuery = true)
    public void changeLikes(@Param("id") Long id, @Param("change_amount") Integer changeAmount);
}

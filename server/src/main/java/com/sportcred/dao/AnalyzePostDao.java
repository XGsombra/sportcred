package com.sportcred.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.AnalyzePost;

@Repository
public interface AnalyzePostDao extends JpaRepository<AnalyzePost, Long> {
	@Query(value = "SELECT p.id FROM analyze_post p WHERE p.is_active = 1 and p.topic_id = :topicId", nativeQuery = true)
	public List<Long> getActivePostsByTopicId(@Param("topicId") Long topicId);
	
	@Query(value = "SELECT * FROM analyze_post WHERE is_active = 1", nativeQuery = true)
	public List<AnalyzePost> getActivePosts();
	
	@Query(value = "SELECT p.id FROM analyze_post p WHERE p.user_id = :userId", nativeQuery = true)
	public List<Long> getPostsByUserId(@Param("userId") Long userId);
	
	public AnalyzePost findFirstByTopicIdOrderByAgreeRateDesc(Long topicId);
	
	@Modifying
    @Transactional
    @Query(
            value = "UPDATE analyze_post SET is_active = False WHERE is_active = true",
            nativeQuery = true
    )
    public void deactivateAllPosts();
}

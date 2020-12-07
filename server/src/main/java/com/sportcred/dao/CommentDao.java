package com.sportcred.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.Comment;

@Repository
public interface CommentDao extends JpaRepository<Comment, Long> {
    List<Comment> findByPostTypeAndPostIdOrderByCreatedTime(String postType, Long postId);

    @Modifying
    @Transactional
    @Query(value = "UPDATE comment c SET c.like_count = (c.like_count + :change_amount) WHERE c.id = :id", nativeQuery = true)
    public void changeLikes(@Param("id") Long id, @Param("change_amount") Integer changeAmount);
}

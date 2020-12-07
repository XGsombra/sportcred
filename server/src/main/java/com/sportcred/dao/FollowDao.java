package com.sportcred.dao;

import com.sportcred.entity.Follow;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface FollowDao extends JpaRepository<Follow, Long> {

    @Query(
            value = "SELECT follower FROM follow WHERE followed = :followed",
            nativeQuery = true
    )
    public List<Long> getAllFollower(
            @Param("followed") Long followed
    );

    @Query(
            value = "SELECT followed FROM follow WHERE follower = :follower",
            nativeQuery = true
    )
    public List<Long> getAllFollowed(
            @Param("follower") Long follower
    );

    @Modifying
    @Transactional
    @Query(
            value = "INSERT INTO follow (follower, followed) VALUE (:follower, :followed)",
            nativeQuery = true
    )
    public void follow(
            @Param("follower") Long follower,
            @Param("followed") Long followed
    );

    @Modifying
    @Transactional
    @Query(
            value = "DELETE FROM follow WHERE follower = :follower AND followed = :followed",
            nativeQuery = true
    )
    public void unfollow(
            @Param("follower") Long follower,
            @Param("followed") Long followed
    );
    
    public Boolean existsByFollowerAndFollowed(Long follower, Long followed);
}

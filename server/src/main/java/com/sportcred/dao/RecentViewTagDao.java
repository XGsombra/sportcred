package com.sportcred.dao;

import com.sportcred.entity.RecentViewTag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface RecentViewTagDao extends JpaRepository<RecentViewTag, Long> {

    @Query(
            value = "SELECT * FROM recent_view_tag WHERE uid = :uid",
            nativeQuery = true
    )
    public RecentViewTag getRecentViewTagByUid(@Param("uid") Long uid);

    @Query(
            value = "SELECT pointer FROM recent_view_tag WHERE uid = :uid",
            nativeQuery = true
    )
    public Long getRecentViewTagPointer(@Param("uid") Long uid);

    @Modifying
    @Transactional
    @Query(
            value = "UPDATE recent_view_tag SET :tagX = :tag WHERE uid = :uid",
            nativeQuery = true
    )
    public void updateRecentViewTag(@Param("tagX") String tagX, @Param("uid") Long uid, @Param("tag") String tag);


    @Modifying
    @Transactional
    @Query(
            value = "UPDATE recent_view_tag SET pointer = :pointer WHERE uid = :uid",
            nativeQuery = true
    )
    public void updateRecentViewTagPointer(@Param("pointer") Long pointer, @Param("uid") Long uid);

    @Modifying
    @Transactional
    @Query(
            value = "INSERT INTO recent_view_tag (uid, pointer) VALUES (:uid, 1)",
            nativeQuery = true
    )
    public void addRecentViewTagForUser(@Param("uid") Long uid);

}

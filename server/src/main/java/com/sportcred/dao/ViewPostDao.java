package com.sportcred.dao;

import com.sportcred.entity.ViewPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ViewPostDao extends JpaRepository<ViewPost,Long> {

    @Query(
            value = "SELECT pid FROM view_post WHERE uid = :uid",
            nativeQuery = true
    )
    public List<Long> getViewPostPidByUid(@Param("uid") Long uid);

    @Modifying
    @Transactional
    @Query(
            value = "INSERT INTO view_post (uid, pid) VALUES (:uid, :pid)",
            nativeQuery = true
    )
    public void addViewPost(@Param("uid") Long uid, @Param("pid") Long pid);

}

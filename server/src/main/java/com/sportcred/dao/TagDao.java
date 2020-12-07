package com.sportcred.dao;

import com.sportcred.entity.Tags;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface TagDao extends JpaRepository<Tags, Long> {

    @Query(
            value = "SELECT pid FROM tags WHERE tag=:tag",
            nativeQuery = true
    )
    public List<Long> getPidByTag(@Param("tag") String tag);
    
    @Query(
            value = "SELECT tag FROM tags WHERE pid=:pid",
            nativeQuery = true
    )
    public List<String> getTagByPid(@Param("pid") Long pid);

    @Modifying
    @Transactional
    @Query(
            value = "INSERT INTO tags (pid, tag) VALUES (:pid, :tag)",
            nativeQuery = true
    )
    public List<Long> addTag(@Param("pid") Long pid, @Param("tag") String tag);

}

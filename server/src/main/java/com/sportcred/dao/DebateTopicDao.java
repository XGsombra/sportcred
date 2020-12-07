package com.sportcred.dao;

import com.sportcred.entity.DebateTopic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface DebateTopicDao extends JpaRepository<DebateTopic, Long> {

    @Query(
            value = "SELECT * FROM debate_topic WHERE tier = :tier AND active = True",
            nativeQuery = true
    )
    public List<DebateTopic> getTopicsByTier(
            @Param("tier") String tier
    );

    @Query(
            value = "SELECT tid FROM debate_topic where tier = :tier",
            nativeQuery = true
    )
    public List<Long> getTidByTier(
            @Param("tier") String tier
    );

    @Query(
            value = "SELECT COUNT(*) FROM debate_topic WHERE tier = :tier",
            nativeQuery = true
    )
    public Integer getActiveTopicNumByTier(
            @Param("tier") String tier
    );


    @Modifying
    @Transactional
    @Query(
            value = "UPDATE debate_topic SET active = False WHERE active = true",
            nativeQuery = true
    )
    public void deactivateAllTopics();

    @Modifying
    @Transactional
    @Query(
            value = "UPDATE debate_topic SET active = True WHERE tid = :tid",
            nativeQuery = true
    )
    public void activateTopicByTid(
            @Param("tid") Long tid
    );

    @Modifying
    @Transactional
    @Query(
            value = "INSERT INTO debate_topic (tier, topic, active) VALUE (:tier, :topic, False)",
            nativeQuery = true
    )
    public void addTopic(
            @Param("tier") String tier,
            @Param("topic") String topic
    );
}

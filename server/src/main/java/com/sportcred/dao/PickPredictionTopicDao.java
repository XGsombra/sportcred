package com.sportcred.dao;

import com.sportcred.entity.PickPredictionTopic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface PickPredictionTopicDao extends JpaRepository<PickPredictionTopic, Long> {
	public List<PickPredictionTopic> findByTypeOrderByPpid(String type);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE pick_prediction_topic p SET p.answer_index = :answer_index WHERE p.ppid = :ppid", nativeQuery = true)
    int changeAnswer(@Param("ppid") Long ppid, @Param("answer_index") Integer answerIndex);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE pick_prediction_topic p SET p.op1num = (p.op1num + :change_amount) WHERE p.ppid = :ppid", nativeQuery = true)
    int changeOp1Num(@Param("ppid") Long ppid, @Param("change_amount") Integer changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE pick_prediction_topic p SET p.op2num = (p.op2num + :change_amount) WHERE p.ppid = :ppid", nativeQuery = true)
    int changeOp2Num(@Param("ppid") Long ppid, @Param("change_amount") Integer changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE pick_prediction_topic p SET p.op3num = (p.op3num + :change_amount) WHERE p.ppid = :ppid", nativeQuery = true)
    int changeOp3Num(@Param("ppid") Long ppid, @Param("change_amount") Integer changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE pick_prediction_topic p SET p.op4num = (p.op4num + :change_amount) WHERE p.ppid = :ppid", nativeQuery = true)
    int changeOp4Num(@Param("ppid") Long ppid, @Param("change_amount") Integer changeAmount);
	
//    @Query(
//            value = "SELECT * FROM pick_prediction_topic WHERE ppid=:ppid",
//            nativeQuery = true
//    )
//    public PickPredictionTopic getPickPredictionTopicByPpid(
//            Long ppid
//    );
//
//    @Query(
//            value = "SELECT * FROM pick_prediction_topic WHERE type='pick'",
//            nativeQuery = true
//    )
//    public List<PickPredictionTopic> getPickTopics(
//    );
//
//    @Query(
//            value = "SELECT * FROM pick_prediction_topic WHERE type='prediction'",
//            nativeQuery = true
//    )
//    public List<PickPredictionTopic> getPredictionTopics(
//    );
//
//    @Modifying
//    @Transactional
//    @Query(
//            value = "UPDATE pick_prediction_topic SET active=FALSE WHERE ppid = :ppid",
//            nativeQuery = true
//    )
//    public void deactivateTopicByPpid(
//            @Param("ppid") Long ppid
//    );
//
//    @Modifying
//    @Transactional
//    @Query(
//            value = "UPDATE pick_prediction_topic SET active=TRUE WHERE ppid = :ppid",
//            nativeQuery = true
//    )
//    public void activateTopicByPpid(
//            @Param("ppid") Long ppid
//    );
//
//    @Modifying
//    @Transactional
//    @Query(
//            value = "INSERT INTO pick_prediction_topic (content, op1, op2, active, type) VALUE (:content, :op1, :op2, TRUE, 'pick')",
//            nativeQuery = true
//    )
//    public void insertPickTopic(
//            @Param("content") String content,
//            @Param("op1") String op1,
//            @Param("op2") String op2
//    );
//
//    @Modifying
//    @Transactional
//    @Query(
//            value = "INSERT INTO pick_prediction_topic (content, op1, op2, op3, op4, active, type) VALUE (:content, :op1, :op2, :op3, :op4,  TRUE, 'prediction')",
//            nativeQuery = true
//    )
//    public void insertPredictionTopic(
//            @Param("content") String content,
//            @Param("op1") String op1,
//            @Param("op2") String op2,
//            @Param("op3") String op3,
//            @Param("op4") String op4
//    );
}

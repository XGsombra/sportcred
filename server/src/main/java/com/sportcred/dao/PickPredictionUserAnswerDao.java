package com.sportcred.dao;

import com.sportcred.entity.PickPredictionUserAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface PickPredictionUserAnswerDao extends JpaRepository<PickPredictionUserAnswer, Long> {
	public PickPredictionUserAnswer findByUidAndPpid(Long uid, Long ppid);
	
	@Query(value = "SELECT p.uid FROM pick_prediction_user_answer p WHERE p.ppid = :ppid and p.user_answer_index = :answer_index", nativeQuery = true)
	public List<Long> getUidsByPpidAndAnswerIndex(@Param("ppid") Long ppid, @Param("answer_index") Integer answerIndex);
	
	@Query(value = "SELECT p.uid FROM pick_prediction_user_answer p WHERE p.ppid = :ppid and (p.user_answer_index < :answer_index or p.user_answer_index > :answer_index)", nativeQuery = true)
	public List<Long> getUidsByPpidAndNotEqualAnswerIndex(@Param("ppid") Long ppid, @Param("answer_index") Integer answerIndex);
	
//    @Query(
//            value = "SELECT uid FROM pick_prediction_user_answer WHERE ppid=:ppid AND user_answer=:answer",
//            nativeQuery = true
//    )
//    public List<Long> getCorrectUser(
//            @Param("ppid") Long ppid,
//            @Param("answer") String answer
//    );
//
//    @Query(
//            value = "SELECT * FROM pick_prediction_user_answer WHERE ppid=:ppid",
//            nativeQuery = true
//    )
//    public List<PickPredictionUserAnswer> getUserAnswerByPpid(
//            @Param("ppid") Long ppid
//    );
//
//    @Modifying
//    @Transactional
//    @Query(
//            value = "INSERT INTO pick_prediction_user_answer (uid, ppid, user_answer) VALUE (:uid, :ppid, :answer)",
//            nativeQuery = true
//    )
//    public void addUserAnswer(
//            @Param("uid") Long uid,
//            @Param("ppid") Long ppid,
//            @Param("answer") String answer
//    );
}

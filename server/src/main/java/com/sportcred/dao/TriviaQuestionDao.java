package com.sportcred.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.TriviaQuestion;

@Repository
public interface TriviaQuestionDao extends JpaRepository<TriviaQuestion, Long> {
	public TriviaQuestion findByQuestion(String question);
	
	@Query(value="SELECT * FROM trivia_question t WHERE t.id IN :ids", nativeQuery=true)
	public List<TriviaQuestion> getByIds(@Param("ids") List<Long> ids);
}

package com.sportcred.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.sportcred.entity.User;

@Repository
public interface UserDao extends JpaRepository<User, Long> {
	public User findByEmail(String email);
	
	public User findByUsername(String username);
	
	@Query(value = "SELECT id FROM user", nativeQuery = true)
    public List<Long> getUserIds();
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE user u SET u.acs_point = (u.acs_point + :change_amount) WHERE u.id = :id", nativeQuery = true)
    public void changeAcsPoint(@Param("id") Long id, @Param("change_amount") BigDecimal changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE user u SET u.trivia_acs_point = (u.trivia_acs_point + :change_amount) WHERE u.id = :id", nativeQuery = true)
    public void changeTriviaAcsPoint(@Param("id") Long id, @Param("change_amount") BigDecimal changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE user u SET u.picks_acs_point = (u.picks_acs_point + :change_amount) WHERE u.id = :id", nativeQuery = true)
    public void changePicksAcsPoint(@Param("id") Long id, @Param("change_amount") BigDecimal changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE user u SET u.debate_acs_point = (u.debate_acs_point + :change_amount) WHERE u.id = :id", nativeQuery = true)
    public void changeDebateAcsPoint(@Param("id") Long id, @Param("change_amount") BigDecimal changeAmount);
	
	@Modifying
    @Transactional
    @Query(value = "UPDATE user u SET u.participation_acs_point = (u.participation_acs_point + :change_amount) WHERE u.id = :id", nativeQuery = true)
    public void changeParticipationAcsPoint(@Param("id") Long id, @Param("change_amount") BigDecimal changeAmount);
}

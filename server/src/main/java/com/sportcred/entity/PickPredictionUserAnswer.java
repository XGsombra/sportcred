package com.sportcred.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

@Entity
@Table(name = "pick_prediction_user_answer",
	   indexes = {@Index(name = "answer_unit",  columnList="uid, ppid", unique = true),
			      @Index(name = "ppid_answer",  columnList="ppid, userAnswerIndex", unique = false)})
public class PickPredictionUserAnswer {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
    @Column
    private Long uid;

    @Column
    private Long ppid;

    @Column
    private Integer userAnswerIndex;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public void setPpid(Long ppid) {
        this.ppid = ppid;
    }

    public Long getPpid() {
        return ppid;
    }

	public Integer getUserAnswerIndex() {
		return userAnswerIndex;
	}

	public void setUserAnswerIndex(Integer userAnswerIndex) {
		this.userAnswerIndex = userAnswerIndex;
	}
}

package com.sportcred.entity;

import javax.persistence.*;

@Entity
@Table(name = "pick_prediction_topic",
	uniqueConstraints = {@UniqueConstraint(columnNames = {"content", "op1", "op2", "op3", "op4"})},
	indexes = {@Index(name = "type",  columnList="type", unique = false)})
public class PickPredictionTopic {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ppid;

    @Column
    private String content;

    @Column
    private String op1;

    @Column
    private String op2;

    @Column
    private String op3;

    @Column
    private String op4;
    
    @Column
    private Integer op1Num;

    @Column
    private Integer op2Num;

    @Column
    private Integer op3Num;

    @Column
    private Integer op4Num;

    @Column
    private Integer answerIndex;

    @Column
    private String type;

    public Long getPpid() {
        return ppid;
    }

    public void setPpid(Long ppid) {
        this.ppid = ppid;
    }

    public void setOp1(String op1) {
        this.op1 = op1;
    }

    public String getOp1() {
        return op1;
    }

    public void setOp2(String op2) {
        this.op2 = op2;
    }

    public String getOp2() {
        return op2;
    }

    public void setOp3(String op3) {
        this.op3 = op3;
    }

    public String getOp3() {
        return op3;
    }

    public void setOp4(String op4) {
        this.op4 = op4;
    }

    public String getOp4() {
        return op4;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContent() {
        return content;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

	public Integer getAnswerIndex() {
		return answerIndex;
	}

	public void setAnswerIndex(Integer answerIndex) {
		this.answerIndex = answerIndex;
	}

	public Integer getOp1Num() {
		return op1Num;
	}

	public void setOp1Num(Integer op1Num) {
		this.op1Num = op1Num;
	}

	public Integer getOp2Num() {
		return op2Num;
	}

	public void setOp2Num(Integer op2Num) {
		this.op2Num = op2Num;
	}

	public Integer getOp3Num() {
		return op3Num;
	}

	public void setOp3Num(Integer op3Num) {
		this.op3Num = op3Num;
	}

	public Integer getOp4Num() {
		return op4Num;
	}

	public void setOp4Num(Integer op4Num) {
		this.op4Num = op4Num;
	}
}

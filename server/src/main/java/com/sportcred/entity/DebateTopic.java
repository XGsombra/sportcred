package com.sportcred.entity;

import javax.persistence.*;

@Entity
@Table(name = "debate_topic",
	uniqueConstraints = {@UniqueConstraint(columnNames = {"tier", "topic"})})
public class DebateTopic{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long tid;

    @Column
    private String tier;

    @Column
    private String topic;

    @Column
    private Boolean active;

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    public String getTier() {
        return tier;
    }

    public void setTier(String tier) {
        this.tier = tier;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }
}

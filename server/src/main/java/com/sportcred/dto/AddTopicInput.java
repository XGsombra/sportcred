package com.sportcred.dto;

public class AddTopicInput {
    private String topic;
    private String tier;

    public String getTopic() {
        return topic;
    }

    public String getTier() {
        return tier;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public void setTier(String tier) {
        this.tier = tier;
    }
}

package com.sportcred.dto;

public class GetUserAnswerCountOutput {
    private String answer1;

    private String answer2;

    private String answer3;

    private String answer4;

    private Integer count1;

    private Integer count2;

    private Integer count3;

    private Integer count4;

    public Integer getCount1() {
        return count1;
    }

    public Integer getCount2() {
        return count2;
    }

    public Integer getCount3() {
        return count3;
    }

    public Integer getCount4() {
        return count4;
    }

    public String getAnswer1() {
        return answer1;
    }

    public String getAnswer2() {
        return answer2;
    }

    public String getAnswer3() {
        return answer3;
    }

    public String getAnswer4() {
        return answer4;
    }

    public void setAnswer1(String answer1) {
        this.answer1 = answer1;
    }

    public void setAnswer2(String answer2) {
        this.answer2 = answer2;
    }

    public void setAnswer3(String answer3) {
        this.answer3 = answer3;
    }

    public void setAnswer4(String answer4) {
        this.answer4 = answer4;
    }

    public void setCount1(Integer count1) {
        this.count1 = count1;
    }

    public void setCount2(Integer count2) {
        this.count2 = count2;
    }

    public void setCount3(Integer count3) {
        this.count3 = count3;
    }

    public void setCount4(Integer count4) {
        this.count4 = count4;
    }
}

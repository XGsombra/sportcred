package com.sportcred.entity;

import org.springframework.stereotype.Repository;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="recent_view_tag")
public class RecentViewTag {
    @Id
    @Column
    private Long uid;

    @Column
    private Long pointer;

    @Column
    private String tag1;

    @Column
    private String tag2;

    @Column
    private String tag3;

    @Column
    private String tag4;

    @Column
    private String tag5;

    @Column
    private String tag6;

    @Column
    private String tag7;

    @Column
    private String tag8;

    @Column
    private String tag9;

    @Column
    private String tag10;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Long getPointer() {
        return pointer;
    }

    public void setPointer(Long pointer) {
        this.pointer = pointer;
    }

    public String getTag1() {
        return tag1;
    }

    public void setTag1(String tag1) {
        this.tag1 = tag1;
    }

    public String getTag2() {
        return tag2;
    }

    public void setTag2(String tag2) {
        this.tag2 = tag2;
    }

    public String getTag3() {
        return tag3;
    }

    public void setTag3(String tag3) {
        this.tag3 = tag3;
    }

    public String getTag4() {
        return tag4;
    }

    public void setTag4(String tag4) {
        this.tag4 = tag4;
    }

    public String getTag5() {
        return tag5;
    }

    public void setTag5(String tag5) {
        this.tag5 = tag5;
    }

    public String getTag6() {
        return tag6;
    }

    public void setTag6(String tag6) {
        this.tag6 = tag6;
    }

    public String getTag7() {
        return tag7;
    }

    public void setTag7(String tag7) {
        this.tag7 = tag7;
    }

    public String getTag8() {
        return tag8;
    }

    public void setTag8(String tag8) {
        this.tag8 = tag8;
    }

    public String getTag9() {
        return tag9;
    }

    public void setTag9(String tag9) {
        this.tag9 = tag9;
    }

    public String getTag10() {
        return tag10;
    }

    public void setTag10(String tag10) {
        this.tag10 = tag10;
    }
}

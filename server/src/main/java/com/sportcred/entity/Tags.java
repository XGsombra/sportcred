package com.sportcred.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@IdClass(Tags.class)
@Table(name="tags")
public class Tags implements Serializable {
    @Id
    @Column
    private Long pid;

    @Id
    @Column
    private String tag;

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}

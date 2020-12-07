package com.sportcred.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@IdClass(ViewPost.class)
@Table(name="view_post")
public class ViewPost implements Serializable {

    @Id
    @Column
    private Long uid;

    @Id
    @Column
    private Long pid;

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }
}

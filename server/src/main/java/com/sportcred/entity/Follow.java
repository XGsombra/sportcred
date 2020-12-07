package com.sportcred.entity;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@IdClass(Follow.class)
@Table(name = "follow")
public class Follow implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
    @Column
    private Long follower;

    @Id
    @Column
    private Long followed;

    public Long getFollower() {
        return follower;
    }

    public Long getFollowed() {
        return followed;
    }

    public void setFollower(Long follower) {
        this.follower = follower;
    }

    public void setFollowed(Long followed) {
        this.followed = followed;
    }
}

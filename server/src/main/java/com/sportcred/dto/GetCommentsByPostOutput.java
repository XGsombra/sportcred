package com.sportcred.dto;

import java.util.List;

import com.sportcred.dto.wrapper.CommentOutput;

public class GetCommentsByPostOutput {
    private List<CommentOutput> commentList;

	public List<CommentOutput> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<CommentOutput> commentList) {
		this.commentList = commentList;
	}
}

package com.sportcred.dto;

import java.util.List;

import com.sportcred.dto.wrapper.SubcommentOutput;

public class GetSubcommentByCommentOutput {
	private List<SubcommentOutput> subcomments;

	public List<SubcommentOutput> getSubcomments() {
		return subcomments;
	}

	public void setSubcomments(List<SubcommentOutput> subcomments) {
		this.subcomments = subcomments;
	}
}

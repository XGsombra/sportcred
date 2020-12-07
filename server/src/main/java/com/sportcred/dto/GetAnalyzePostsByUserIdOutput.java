package com.sportcred.dto;

import java.util.List;

public class GetAnalyzePostsByUserIdOutput {
	private List<Long> postIds;

	public List<Long> getPostIds() {
		return postIds;
	}

	public void setPostIds(List<Long> postIds) {
		this.postIds = postIds;
	}
}

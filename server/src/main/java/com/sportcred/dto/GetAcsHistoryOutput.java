package com.sportcred.dto;

import java.util.ArrayList;
import java.util.List;

import com.sportcred.dto.wrapper.AcsHistoryOutput;

public class GetAcsHistoryOutput {
	private List<AcsHistoryOutput> acsHistory = new ArrayList<>();

	public List<AcsHistoryOutput> getAcsHistory() {
		return acsHistory;
	}

	public void setAcsHistory(List<AcsHistoryOutput> acsHistory) {
		this.acsHistory = acsHistory;
	}
}

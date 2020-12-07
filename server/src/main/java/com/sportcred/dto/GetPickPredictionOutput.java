package com.sportcred.dto;

import java.util.List;

import com.sportcred.dto.wrapper.PickPredictionOutput;

public class GetPickPredictionOutput {
    private List<PickPredictionOutput> pickPredictions;

	public List<PickPredictionOutput> getPickPredictions() {
		return pickPredictions;
	}

	public void setPickPredictions(List<PickPredictionOutput> pickPredictions) {
		this.pickPredictions = pickPredictions;
	}

}

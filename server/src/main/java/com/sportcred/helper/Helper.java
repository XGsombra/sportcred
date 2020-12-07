package com.sportcred.helper;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class Helper {
	public static String getExtension(String fileName) {
		String extension = "";

		int i = fileName.lastIndexOf('.');
		if (i > 0) {
		    extension = fileName.substring(i);
		}
		return extension;
	}
	
	public static <T> T randomElement(List<T> list) {
		Random rand = new Random();
		return list.get(rand.nextInt(list.size())); 
	}
	
	public static <T> List<T> randomElements(List<T> list, int num){
		List<Integer> indices = new ArrayList<>();
		for(int i=0; i<num; i++) {
			indices.add(i);
		}
		Collections.shuffle(indices);
		indices = indices.subList(0, num);
		List<T> result = new ArrayList<>();
		for(int index:indices) {
			result.add(list.get(index));
		}
		return result;
	}
	
	public static List<Long> randomIndexPermutation(int total, int used) {
		List<Long> list = new ArrayList<>();
		for(long i=0; i<total; i++) {
			list.add(i);
		}
		Collections.shuffle(list);
		return list.subList(0, used);
	}
}

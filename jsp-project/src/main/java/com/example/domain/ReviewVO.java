package com.example.domain;

import lombok.Data;

@Data
public class ReviewVO {
	
	private int reviewNum;
	private String movieNum;
	private String id;
	private String star;
	private String reviewContent;
}

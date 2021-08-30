package com.example.domain;

import lombok.Data;

@Data
public class CommentVO {

	private int commentNum;
	private int boardNum;
	private String id;
	private String content;
	private int reRef;
	private int reLev;
	private int reSeq;
	
}

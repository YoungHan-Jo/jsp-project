package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentVO {

	private int commentNum;
	private int boardNum;
	private String id;
	private String content;
	private Timestamp regDate;
	private int reRef;
	private int reLev;
	private int reSeq;
	
}

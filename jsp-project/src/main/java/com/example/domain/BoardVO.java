package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class BoardVO {

	private Integer boardNum;
	private String tab;
	private String memberId;
	private String subject;
	private String content;
	private Integer viewCount;
	private Timestamp regDate;
	private Integer reRef;
	private Integer reLev;
	private Integer reSeq;
}

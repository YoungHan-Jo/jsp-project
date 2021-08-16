package com.example.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String passwd;
	private String name;
	private String birthday;
	private String gender;
	private String email;
	private String recvEmail;
	private Timestamp regDate;
}

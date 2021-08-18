package com.example.domain;

import java.sql.Timestamp;

import com.example.repository.BoardDAO;

public class Ex1 {

	public static void main(String[] args) {
		
		BoardDAO boardDAO = BoardDAO.getInstance();
		
		int ranNum;
		
		boardDAO.deleteAll();
		
		for(int i = 1; i <= 100; ++i) {
			BoardVO boardVO = new BoardVO();
			ranNum = (int)(Math.random()*100) + 1;
			
			boardVO.setBoardNum(i);
			if(i%2 == 0) {
				boardVO.setTab("R");				
			}else {
				boardVO.setTab("I");
			}
			boardVO.setMemberId("홍길동" + i);
			boardVO.setSubject("글 제목" + i);
			boardVO.setContent("글 내용" + i);
			boardVO.setViewCount(ranNum);
			boardVO.setRegDate(new Timestamp(System.currentTimeMillis()));
			boardVO.setReRef(i);
			boardVO.setReLev(0);
			boardVO.setReSeq(0);
			
			boardDAO.addBoard(boardVO);
			
		} // for
		
		
		System.out.println("완료");
	} // main

}

<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String)session.getAttribute("sessionLoginId");

// 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
BoardVO boardVO = new BoardVO();

// boardNum
int nextNum = boardDAO.getNextNum();
boardVO.setBoardNum(nextNum);

// tab
String tab = request.getParameter("tab");
boardVO.setTab(tab);

// member id
boardVO.setMemberId(id);

// subject
String subject = request.getParameter("subject");
boardVO.setSubject(subject);

// content
String content = request.getParameter("content");
boardVO.setContent(content);

//view count
boardVO.setViewCount(0);

// regDate
boardVO.setRegDate(new Timestamp(System.currentTimeMillis()));

// re
boardVO.setReRef(nextNum);
boardVO.setReLev(0);
boardVO.setReSeq(0);

// DB에 추가
boardDAO.addBoard(boardVO);

// 페이지 상세보기로 넘어가기
String pageNum = request.getParameter("pageNum");
response.sendRedirect("/board/boardContent.jsp?boardNum="+boardVO.getBoardNum()+"&tab=&pageNum="+pageNum);

%>
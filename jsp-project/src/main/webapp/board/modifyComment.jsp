<%@page import="com.example.domain.CommentVO"%>
<%@page import="com.example.repository.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int commentNum = Integer.parseInt(request.getParameter("commentNum"));
int boardNum = Integer.parseInt(request.getParameter("boardNum"));
String content = request.getParameter("content");
String tab = "";
if(request.getParameter("tab")!=null){
	tab = request.getParameter("tab");
}
String type = "";
if(request.getParameter("type")!=null){
	type = request.getParameter("type");
}
String keyword = "";
if(request.getParameter("keyword")!=null){
	keyword = request.getParameter("keyword");
}
String pageNum = request.getParameter("pageNum");


CommentDAO commentDAO = CommentDAO.getInstance();

CommentVO commentVO = commentDAO.getCommentByCommentNum(commentNum);
commentVO.setContent(content);

commentDAO.updateComment(commentVO);



response.sendRedirect("/board/boardContent.jsp?boardNum=" + boardNum 
					+ "&tab="+tab+"&type="+type+"&keyword="+keyword
					+ "&pageNum=" + pageNum);

%>

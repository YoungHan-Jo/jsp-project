<%@page import="com.example.domain.CommentVO"%>
<%@page import="com.example.repository.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String)session.getAttribute("sessionLoginId");

// 답글을 달 댓글의 commentNum
int commentNum = Integer.parseInt(request.getParameter("commentNum"));

String content = request.getParameter("content");

int boardNum = Integer.parseInt(request.getParameter("boardNum"));
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

// DAO준비
CommentDAO commentDAO = CommentDAO.getInstance();

// 답글이 달릴 본래의 comment
CommentVO dbComment = commentDAO.getCommentByCommentNum(commentNum);

// 답글 객체
CommentVO newComment = new CommentVO();
newComment.setCommentNum(commentDAO.getNextNum());
newComment.setBoardNum(dbComment.getBoardNum());
newComment.setId(id);
newComment.setContent(content);
newComment.setReRef(dbComment.getReRef());
newComment.setReLev(dbComment.getReLev());
newComment.setReSeq(dbComment.getReSeq());

commentDAO.updateReSeqAndAddReply(newComment);


response.sendRedirect("/board/boardContent.jsp?boardNum=" + boardNum 
					+ "&tab="+tab+"&type="+type+"&keyword="+keyword
					+ "&pageNum=" + pageNum);

%>
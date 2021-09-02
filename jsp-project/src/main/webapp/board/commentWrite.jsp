<%@page import="com.example.domain.CommentVO"%>
<%@page import="com.example.repository.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("sessionLoginId");

if(id == null){
	%>
	<script>
	alert('로그인이 필요한 서비스입니다.');
	history.back();
	</script>
	<%
	return;
}

//파라미터값 가져오기
int boardNum = Integer.parseInt(request.getParameter("boardNum"));
String tab = request.getParameter("tab");
String type = request.getParameter("type");
String keyword = request.getParameter("keyword");
String pageNum = request.getParameter("pageNum");

String content = request.getParameter("content");

CommentDAO commentDAO = CommentDAO.getInstance();

int nextNum = commentDAO.getNextNum();

CommentVO commentVO = new CommentVO();
commentVO.setCommentNum(nextNum);
commentVO.setBoardNum(boardNum);
commentVO.setId(id);
commentVO.setContent(content);
commentVO.setReRef(nextNum);
commentVO.setReLev(0);
commentVO.setReSeq(0);

commentDAO.addComment(commentVO);

%>
<script>
location.href = '/board/boardContent.jsp?boardNum=<%=boardNum %>&tab=<%=tab%>&type=<%=type %>&keyword=<%=keyword %>&pageNum=<%=pageNum%>';
</script>
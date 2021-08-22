<%@page import="com.example.domain.ReviewVO"%>
<%@page import="com.example.repository.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");
if (id == null){
	%>
	<script>
		alert('로그인이 필요합니다.');
		location.href='/member/login.jsp';		
	</script>
	<%
	return;
}

String movieNum = request.getParameter("movieNum");
String star = request.getParameter("star");
if (star == null) {
%>
<script>
	alert('평점을 선택해주세요.');
	history.back();
</script>
<%
return;
}
String content = request.getParameter("content");
if (content.length() < 5) {
	%>
	<script>
		alert('내용을 5글자 이상 입력해주세요.');
		history.back();
	</script>
	<%
	return;
}

//DAO 객체 준비
ReviewDAO reviewDAO = ReviewDAO.getInstance();

int nextNum = reviewDAO.getNextNum();

ReviewVO reviewVO = new ReviewVO();

reviewVO.setReviewNum(nextNum);
reviewVO.setMovieNum(movieNum);
reviewVO.setId(id);
reviewVO.setStar(star);
reviewVO.setReviewContent(content);

System.out.println(reviewVO.toString());

reviewDAO.addReview(reviewVO);

response.sendRedirect("/movie/movieInfo.jsp?movieNum=" + movieNum);
%>
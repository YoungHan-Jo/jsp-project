<%@page import="com.example.repository.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
String movieNum = request.getParameter("movieNum");

ReviewDAO reviewDAO = ReviewDAO.getInstance();

reviewDAO.deleteReviewByReviewNum(reviewNum);

%>
<script>
alert('삭제 완료');
location.href='/movie/movieInfo.jsp?movieNum=' +<%=movieNum%>;
</script>
<%@page import="com.example.domain.ReviewVO"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.ReviewDAO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");

//DAO객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
ReviewDAO reviewDAO = ReviewDAO.getInstance();

List<BoardVO> boardList = boardDAO.getBoardsByMemberId(id);
List<ReviewVO> reviewList = reviewDAO.getReviewsByMemberId(id);
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
</head>
<body class="brown lighten-4">
	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->

	<div class="row container">
		<!-- sideMenu area -->
		<jsp:include page="/include/sideMenu.jsp" />
		<!-- end of sideMenu -->
		<div class="col s12 l9 container">
			<div class="section">
				<h4>내가 쓴 글</h4>
				<hr />
			</div>
			<div class="row">
				<div class="col s6 m4 l3">
					<select id="tabs">
						<option value="" disabled>탭 선택</option>
						<option value="B">게시글</option>
						<option value="C">댓글</option>
						<option value="R">한줄리뷰</option>
					</select>
				</div>
			</div>
			
			<table>
				
			</table>
			
			
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->

</body>
</html>

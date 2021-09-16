<%@page import="com.example.repository.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.repository.RecommendDAO"%>
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
RecommendDAO recDAO = RecommendDAO.getInstance();

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
			<table class="highlight">
				<thead>
					<tr>
						<th class="center">No</th>
						<th class="center">탭</th>
						<th>글 제목</th>
						<th class="center">작성자</th>
						<th class="center">작성일</th>
						<th class="center">추천수</th>
						<th class="center">조회수</th>
					</tr>
				</thead>

				<tbody>
					<%
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
					String date;
					
					CommentDAO commentDAO = CommentDAO.getInstance();

					for (BoardVO boardVO : boardList) {
						date = sdf.format(boardVO.getRegDate());
						int commentNum = commentDAO.getCountByBoard(boardVO.getBoardNum());
						
					%>
					<tr id="boardList"
						onclick="location.href='/board/boardContent.jsp?boardNum=<%=boardVO.getBoardNum()%>&tab=&type=&keyword=&pageNum=1'">
						<td class="center"><%=boardVO.getBoardNum()%></td>
						<td style="width: 10%" class="center">
							<%
							switch (boardVO.getTab()) {
								case "R" :
									%>리뷰<%
									break;
								case "I" :
									%>정보<%
									break;
								case "C" :
									%>잡담<%
									break;
								default :
									%>기타<%
								}
								%>
						</td>
						<td style="width: 40%">
						<%
						if(boardVO.getReLev() > 0){ // 답글이면
							%>
							<span class="reply-level" style="width: <%=boardVO.getReLev()*15 %>px"></span>
							<i class="material-icons">subdirectory_arrow_right</i>	
							<%
						}
						%>
						
						<%=boardVO.getSubject()%> (<%=commentNum %>)</td>
						<td class="center"><%=boardVO.getMemberId()%></td>
						<td class="center"><%=date%></td>
						<td class="center"><%=recDAO.getCountByBoard(boardVO.getBoardNum()) %></td>
						<td class="center"><%=boardVO.getViewCount()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
			
			
			
		</div>
	</div>
	

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->

</body>
</html>

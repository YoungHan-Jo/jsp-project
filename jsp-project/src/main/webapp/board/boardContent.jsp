<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");

int boardNum = Integer.parseInt(request.getParameter("boardNum"));
String tab = request.getParameter("tab");
String pageNum = request.getParameter("pageNum");

//DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();

//조회수 1 추가
boardDAO.updateViewCount(boardNum);

// 글 번호에 맞는 객체 가져오기
BoardVO boardVO = boardDAO.getBoardByBoardNum(boardNum);

// 작성일 형 변환
Date date = boardVO.getRegDate();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
String regDate = sdf.format(date);
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

	<div class="container">
		<div class="section">
			<h4>게시판 상세</h4>
			<hr />
		</div>
		<div class="row">
			<div class="title"></div>
			<table class="" id="boardList">
				<tr>
					<th>탭</th>
					<td>
						<%
						switch (boardVO.getTab()) {
						case "R":
						%>리뷰<%
						break;
						case "I":
						%>정보<%
						break;
						case "C":
						%>잡담<%
						break;
						default:
						%>기타<%
						}
						%>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<th style="width: 60%"><%=boardVO.getSubject()%></th>
					<th>작성일</th>
					<td><%=regDate%></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td style="width: 50%"><%=boardVO.getMemberId()%></td>
					<th>조회수</th>
					<td><%=boardVO.getViewCount()%></td>
					<th>추천수</th>
					<td>0</td>
				</tr>
				<tr id="content">
					<td><pre><%=boardVO.getContent()%></pre></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="section">
			<div class="row">
				<div class="col s12 right-align">
					<%
					if (boardVO.getMemberId().equals(id)) {
					%>
					<a class="btn waves-effect waves-light"
						href="/board/boardModify.jsp?num=&pageNum="> <i
						class="material-icons left">edit</i>글수정
					</a> <a class="btn waves-effect waves-light" onclick="remove(event)">
						<i class="material-icons left">delete</i>글삭제
					</a>
					<%
					}
					%>

					<a class="btn waves-effect waves-light"
						href="/board/replyWrite.jsp?reRef=&reLev=&reSeq=&pageNum="> <i
						class="material-icons left">reply</i>답글
					</a> <a class="btn waves-effect waves-light"
						href="/board/boardList.jsp?tab=<%=tab%>&pageNum=<%=pageNum%>">
						<i class="material-icons left">list</i>글목록
					</a>
				</div>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
</body>
</html>
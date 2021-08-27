<%@page import="com.example.domain.RecommendVO"%>
<%@page import="com.example.repository.RecommendDAO"%>
<%@page import="com.example.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.AttachDAO"%>
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

// 첨부파일 가져오기
AttachDAO attachDAO = AttachDAO.getInstance();
List<AttachVO> attachList = attachDAO.getAttachesByBoardNum(boardNum);

//======== 추천기능 =========
RecommendDAO recDAO = RecommendDAO.getInstance();
int recCount = recDAO.getCountByBoard(boardNum);

RecommendVO recVO = new RecommendVO();
recVO.setBoardNum(boardNum);
recVO.setId(id);

boolean isRec = recDAO.isRecommendedByRecVO(recVO);

List<String> list = recDAO.getAccountsByBoardNum(boardNum);


%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style>

</style>
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
					<td class="likey-count"><%=recCount %></td>
				</tr>
				<tr id="content">
					<td><pre><%=boardVO.getContent()%></pre></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<%
						if (attachList.size() > 0) { // 첨부파일이 있으면
						%>
						<ul>
							<%
							for (AttachVO attach : attachList) {
								if (attach.getFileType().equals("I")) { // 이미지 파일
									// 썸네일 이미지 경로
	                   				String fileCallPath = attach.getUploadPath() + "/s_" + attach.getFileName();
	                   				// 원본 이미지 경로
	                   				String fileCallPathOrigin = attach.getUploadPath() + "/" + attach.getFileName();
	                   				%>
	                   				<li>
	                   					<a href="/board/download.jsp?fileName=<%=fileCallPathOrigin %>">
	                   						<img src="/board/display.jsp?fileName=<%=fileCallPath%>">
	                   						<%=attach.getFileName() %>
	                   					</a>
	                   					<hr>
	                   				</li>
	                   				<%
									
								} else {// 일반파일
									String fileCallPath = attach.getUploadPath() + "/" + attach.getFileName();
									%>
									<li><a
										href="/board/download.jsp?fileName=<%=fileCallPath%>"> <i
										class="material-icons">file_present</i> <%=attach.getFileName()%>
									</a>
									<hr>
									</li>
										
									<%
								}
		
							}
								%>
						</ul> 
						<%
						 }else {
							 %>
							 첨부파일 없음
							 <%
						 }
						 %>
					</td>
				</tr>
			</table>
		</div>
		<div class="section">
			<div class="row center"	>
				<form action="" id="likey-form">
				<input type="hidden" name="boardNum" value="<%=boardNum %>">
				<input type="hidden" name="id" value="<%=id %>">
				<a class="waves-effect waves-light btn pink lighten-2" id="btn-likey">
				<%
				if(isRec == true){
				%><i class="material-icons left">favorite</i><%	
				}else{
				%><i class="material-icons left">favorite_border</i><%
				}
				%>
				<span class="likey-count"><%=recCount %></span></a>
				</form>
			</div>
		</div>
		<div class="section">
			<div class="row">
				<div class="col s12 right-align">
					<%
					if (boardVO.getMemberId().equals(id)) {
					%>
					<a class="btn waves-effect waves-light"
						href="/board/modifyBoard.jsp?boardNum=<%=boardVO.getBoardNum() %>&tab=<%=tab %>&pageNum=<%=pageNum%>"> <i
						class="material-icons left">edit</i>글수정
					</a> <a class="btn waves-effect waves-light" onclick="remove(event)">
						<i class="material-icons left">delete</i>글삭제
					</a>
					<%
					}
					%>

					<a class="btn waves-effect waves-light"
						href="/board/replyWrite.jsp?tab=<%=boardVO.getTab() %>&reRef=<%=boardVO.getReRef() %>&reLev=<%=boardVO.getReLev() %>&reSeq=<%=boardVO.getReSeq() %>&pageNum=<%=pageNum %>"> <i
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
	<script>
	function remove(event){
		event.preventDefault();
		
		const isRemove = confirm('게시글을 삭제하시겠습니까?');
		if(isRemove == true){
			location.href = '/board/deleteBoard.jsp?boardNum=<%=boardVO.getBoardNum() %>';
		}
		
	}
	
	$('#btn-likey').on('click',function(){
		var obj = {
				boardNum: $('input[name="boardNum"]').val(),
				id: $('input[name="id"]').val()
		}; 
		
		console.log(obj);
		console.log(typeof obj);
		
		console.log(obj.id);
		
		if(obj.id == 'null'){
			alert('로그인이 필요한 서비스 입니다.');
		}else{
			var strJson = JSON.stringify(obj);
			console.log(strJson);
			console.log(typeof strJson);
			
			// ajax 함수 호출
			$.ajax({
				url: '/api/recommend',
				method: 'POST',
				data: strJson,
				contentType: 'application/json; charset=UTF-8',
				success: function (data) {
					
					$.ajax({
						url : '/api/recommend/'+ <%=boardNum %>,
						method : 'GET',
						success : function(data){
							console.log(data);
							console.log(typeof data);
							console.log(data.count);
							$('.likey-count').text(data.count);
							
						}
						
					});
				}
			});
		}
		
		
		
	});
	
	
	
	
	
	
	</script>
</body>
</html>
<%@page import="com.example.domain.CommentVO"%>
<%@page import="com.example.repository.CommentDAO"%>
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
String type = request.getParameter("type");
String keyword = request.getParameter("keyword");
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

//======== 댓글 ========
CommentDAO commentDAO = CommentDAO.getInstance();

List<CommentVO> commentList = commentDAO.getCommentsByBoardNum(boardNum);


%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style>
.comment-id {
	font-size: 23px;
	font-weight: 700;
}
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
					<td class="likey-count"><%=recCount%></td>
				</tr>
				<tr id="content">
					<td colspan="6"><pre><%=boardVO.getContent()%></pre></td>
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
							<li><a
								href="/board/download.jsp?fileName=<%=fileCallPathOrigin%>">
									<img src="/board/display.jsp?fileName=<%=fileCallPath%>">
									<%=attach.getFileName()%>
							</a>
								<hr></li>
							<%
							} else {// 일반파일
							String fileCallPath = attach.getUploadPath() + "/" + attach.getFileName();
							%>
							<li><a href="/board/download.jsp?fileName=<%=fileCallPath%>">
									<i class="material-icons">file_present</i> <%=attach.getFileName()%>
							</a>
								<hr></li>

							<%
							}

							}
							%>
						</ul> <%
							 } else {
							 %> 첨부파일 없음 <%
							 }
							 %>
					</td>
				</tr>
			</table>
		</div>
		<div class="section">
			<div class="row center">
				<form action="" id="likey-form">
					<input type="hidden" name="boardNum" value="<%=boardNum%>">
					<input type="hidden" name="id" value="<%=id%>"> <a
						class="waves-effect waves-light btn pink lighten-2" id="btn-likey">
						<%
						if (isRec == true) {
						%><i class="material-icons left likey-icon">favorite</i> <%
						 } else {
						 %><i class="material-icons left likey-icon">favorite_border</i> <%
						 }
						 %> <span class="likey-count"><%=recCount%></span>
					</a>
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
						href="/board/modifyBoard.jsp?boardNum=<%=boardVO.getBoardNum()%>&tab=<%=tab%>&pageNum=<%=pageNum%>">
						<i class="material-icons left">edit</i>글수정
					</a> <a class="btn waves-effect waves-light" onclick="remove(event)">
						<i class="material-icons left">delete</i>글삭제
					</a>
					<%
					}
					%>

					<%
					if (id != null) {
					%>
					<a class="btn waves-effect waves-light"
						href="/board/replyWrite.jsp?tab=<%=tab%>&reRef=<%=boardVO.getReRef()%>&reLev=<%=boardVO.getReLev()%>&reSeq=<%=boardVO.getReSeq()%>&type=<%=type%>&keyword=<%=keyword%>&pageNum=<%=pageNum%>">
						<i class="material-icons left">reply</i>답글
					</a>
					<%
					}
					%>


					<a class="btn waves-effect waves-light"
						href="/board/boardList.jsp?tab=<%=tab%>&type=<%=type%>&keyword=<%=keyword%>&pageNum=<%=pageNum%>">
						<i class="material-icons left">list</i>글목록
					</a>
				</div>
			</div>
		</div>
		<div class="section">
			<h5>댓글</h5>
			<hr>
			<div class="row">
				<table class="comment">
					<%
					for(CommentVO comment : commentList){
						%>
						<tr id="<%=comment.getCommentNum() %>">
							<td style="width: 70%"><span class="comment-id"><%=comment.getId() %></span><br><%=comment.getContent() %></td>
							<%if(id != null && id.equals(comment.getId())){
								%>
							<td style="width: 20%"><a class="waves-effect waves-light btn">수정</a> <a class="waves-effect waves-light btn" id="comment-delete">삭제</a></td>
								<%								
							}else{
								%><td style="width: 20%"> </td><%
							}%>
							<td style="width: 10%"><a class="waves-effect waves-light btn">답장</a></td>
						</tr>
						<%
					}
					 %>
				</table>
			</div>
			<div class="row">
				<form
					action="/board/commentWrite.jsp?boardNum=<%=boardVO.getBoardNum()%>&tab=<%=tab%>&type=<%=type%>&keyword=<%=keyword%>&pageNum=<%=pageNum%>"
					method="POST">
					<div class="input-field col s12">
						<textarea id="textarea1" class="materialize-textarea" name="content"></textarea>
						<label for="textarea1">댓글 쓰기</label>
					</div>
					<button type="submit" class="waves-effect waves-light btn" >
						쓰기</button>
				</form>
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
			location.href = '/board/deleteBoard.jsp?boardNum=<%=boardVO.getBoardNum()%>';
			}

		}

		function showLikey() {
			$.ajax({ // 변경된 DB 내용 가져와서 화면으로 나타내기
				url : '/api/recommend/' + <%=boardNum%>,
				method : 'GET',
				success : function(data) {
					console.log('---추가 후 리스트--');
					console.log(data.list);
					console.log('--------');
					console.log(data.count);

					// 좋아요 수 화면에 나타내기
					$('.likey-count').text(data.count);

					// 빈하트, 꽉찬하트 아이콘 전환 나타내기
					var id = $('input[name="id"]').val();
					if (data.list.indexOf(id) == -1) { // 리스트에 존재하지 않음.
						$('i.likey-icon').text('favorite_border');
					} else { // 리스트에 존재함
						$('i.likey-icon').text('favorite');
					}

				} // success GET

			});

		}

		$('#btn-likey').on('click',function() {
							var obj = {
								boardNum : $('input[name="boardNum"]').val(),
								id : $('input[name="id"]').val()
							};

							console.log(obj);
							console.log(typeof obj);

							console.log(obj.id);

							if (obj.id == 'null') {
								alert('로그인이 필요한 서비스 입니다.');
							} else {
								var strJson = JSON.stringify(obj);
								console.log(strJson);
								console.log(typeof strJson);

								// 현재 게시글을 추천한 id 리스트 들고와서 현재 id와 중복 체크
								$.ajax({
									url : '/api/recommend/'+<%=boardNum%>,
									method : 'GET',
									success : function(data) {
										var list = data.list;
										console.log('--리스트 목록--');
										console.log(list);
										console.log('---------------');
										console.log(list.indexOf(obj.id));

										if (list.indexOf(obj.id) == -1) { // 리스트에 존재하지 않음.(좋아요 추가하기)

											// 좋아요 등록하기
											$.ajax({ // DB에 추가
												url : '/api/recommend',
												method : 'POST',
												data : strJson,
												contentType : 'application/json; charset=UTF-8',
												success : function(data) {
													showLikey();

												} // success POST
											});

										} else { // 리스트에 존재함.(좋아요 취소하기)

											// 좋아요 취소하기
											$.ajax({ // DB에서 삭제
												url : '/api/recommend',
												method : 'DELETE',
												data : strJson,
												contentType : 'application/json; charset=UTF-8',
												success : function(data) {
													showLikey();
												} // seccess DELETE
											})
										}
									}
								});
							}
						});
		
		$('table.comment').on('click','#comment-delete',function(){
			console.log($(this).closest('tr'));
			console.log($(this).closest('tr')[0].id);
			var commentNum = $(this).closest('tr')[0].id;
			
			$(this).closest('tr').remove();
			
			location.href = '/board/deleteComment.jsp?commentNum='+commentNum
					+'&boardNum=<%=boardNum %>'+'&tab=<%=tab %>' +'&type=<%=type %>' +'&keyword=<%=keyword %>'+'&pageNum=<%=pageNum%>';
		})
		
		
	</script>
</body>
</html>
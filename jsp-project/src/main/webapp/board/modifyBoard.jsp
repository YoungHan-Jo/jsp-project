<%@page import="com.example.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");

int boardNum = Integer.parseInt(request.getParameter("boardNum"));

//DAO 객체준비
BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();

BoardVO boardVO = boardDAO.getBoardByBoardNum(boardNum);
List<AttachVO> attachList = attachDAO.getAttachesByBoardNum(boardNum);

String pageNum = "1";
if (request.getParameter("pageNum") != null) {
	pageNum = request.getParameter("pageNum");
}
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
			<h4>게시글 수정</h4>
			<hr />
		</div>
		<form action="/board/modifyBoardPro.jsp" method="POST"
			enctype="multipart/form-data">
			<input type="hidden" name="pageNum" value="<%=pageNum%>" />
			<input type="hidden" name="boardNum" value="<%=boardVO.getBoardNum() %>" />

			<div class="row"></div>
			<div class="row">
				<div class="input-field col s12 m2 l2">
					<select name="tab">
						<option value="E" disabled>탭 선택</option>
						<option value="R"
							<%=boardVO.getTab().equals("R") ? "selected" : ""%>>리뷰</option>
						<option value="I"
							<%=boardVO.getTab().equals("I") ? "selected" : ""%>>정보</option>
						<option value="C"
							<%=boardVO.getTab().equals("C") ? "selected" : ""%>>잡담</option>
						<option value="E"
							<%=boardVO.getTab().equals("E") || boardVO.getTab().equals("") ? "selected" : ""%>>기타</option>
					</select> <label>게시글 종류 탭</label>
				</div>
				<div class="input-field  col s12 m10 l10">
					<i class="material-icons prefix">subtitles</i> <input type="text"
						id="title" class="validate" name="subject"
						value="<%=boardVO.getSubject()%>" /> <label for="title">제목</label>
				</div>
			</div>
			<div class="row">
				<div class="input-field">
					<i class="material-icons prefix">subject</i>
					<textarea id="textarea1" class="materialize-textarea"
						name="content"><%=boardVO.getContent()%></textarea>
					<label for="textarea1">내용</label>
				</div>
			</div>

			<div class="row">
				<div class="col s12">
					<button type="button" class="btn-small waves-effect waves-light"
						id="btnAddFile">파일 추가</button>
				</div>
			</div>

			<!-- 기존 첨부 파일 목록 -->
			<div class="row" id="oldFileBox">
				<%
				for (AttachVO attach : attachList) {
				%>
				<!-- .delete-oldfile 버튼 클릭 시 hidden input의 name속성값이 oldfile->delfile로 변환 -->
				<input type="hidden" name="oldfile" value="<%=attach.getUuid()%>">
				<div class="col s12">
					<span class="filename"><%=attach.getFileName()%></span>
					<button class="waves-effect waves-light btn-small delete-oldfile">
						<i class="material-icons">clear</i>
					</button>
				</div>
				<%
				} // for
				%>
			</div>

			<!-- 신규 첨부 파일 목록 -->
			<div class="row" id="newFileBox"></div>



			<br />
			<div class="row center">
				<button class="btn waves-effect waves-light" type="submit">
					수정하기 <i class="material-icons right">create</i>
				</button>
				&nbsp;&nbsp;
				<button class="btn waves-effect waves-light" type="reset">
					초기화 <i class="material-icons right">clear</i>
				</button>
				&nbsp;&nbsp;
				<button class="btn waves-effect waves-light" type="button"
					onclick="location.href = '/board/boardList.jsp?tab=<%=boardVO.getTab()%>&pageNum=<%=pageNum%>'">
					글목록 <i class="material-icons right">list</i>
				</button>
			</div>
		</form>
	</div>
	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script>
	
var fileIndex = 1;
	
	var currentFileCount = <%=attachList.size()%>; 
	const MAX_FILE_COUNT = 5;
		
	$('#btnAddFile').on('click',function(){
		if(currentFileCount >= MAX_FILE_COUNT){
			alert(`첨부파일은 최대 \${MAX_FILE_COUNT}개까지 가능합니다.`);
			return;
		}
		
		var str = `<div class="col s12">
						<input type="file" name="file\${fileIndex}"> 
						<button class="waves-effect waves-light btn-small delete-addfile">
						<i class="material-icons">clear</i></button>
					</div>`;
					
		$('#newFileBox').append(str);
		
		fileIndex++;
		currentFileCount++;
	
	})
	
	
	$('#newFileBox').on('click','button.delete-addfile',function(){
		$(this).closest('div').remove();
		currentFileCount--;
	})
	
	// 기존 첨부파일의 삭제버튼 눌렀을때
	$('button.delete-oldfile').on('click',function(){
	
		// name속성의 값을 oldfile -> delfile(서버에서 찾을 파라미터값, 파일삭제용도)
		$(this).parent().prev().prop('name','delfile'); 
		
		//현재 클릭한 요소의 직계부모(parent)요소를 삭제하기
		$(this).parent().remove();
		
		currentFileCount--;
	})
	</script>
</body>
</html>

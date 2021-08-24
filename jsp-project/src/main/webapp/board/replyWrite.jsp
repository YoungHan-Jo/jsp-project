<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");


String tab = "";
if(request.getParameter("tab") != null){
	tab = request.getParameter("tab");
}
String pageNum = "1";
if(request.getParameter("pageNum") != null){
	pageNum = request.getParameter("pageNum");
}

int reRef = Integer.parseInt(request.getParameter("reRef"));
int reLev = Integer.parseInt(request.getParameter("reLev"));
int reSeq = Integer.parseInt(request.getParameter("reSeq"));


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
			<h4>게시판 답글 쓰기</h4>
			<hr />
		</div>
		<form action="/board/replyWritePro.jsp" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="pageNum" value="<%=pageNum%>" />
			<input type="hidden" name="reRef" value="<%=reRef%>" />
			<input type="hidden" name="reLev" value="<%=reLev%>" />
			<input type="hidden" name="reSeq" value="<%=reSeq%>" />

			<div class="row"></div>
			<div class="row">
				<div class="input-field col s12 m2 l2">
					<select name="tab">
						<option value="E" disabled>탭
							선택</option>
						<option value="R" <%=tab.equals("R") ? "selected" : ""%>>리뷰</option>
						<option value="I" <%=tab.equals("I") ? "selected" : ""%>>정보</option>
						<option value="C" <%=tab.equals("C") ? "selected" : ""%>>잡담</option>
						<option value="E" <%=tab.equals("E") || tab.equals("") ? "selected" : ""%>>기타</option>
					</select> <label>게시글 종류 탭</label>
				</div>
				<div class="input-field  col s12 m10 l10">
					<i class="material-icons prefix">subtitles</i> <input type="text"
						id="title" class="validate" name="subject" /> <label for="title">제목</label>
				</div>
			</div>
			<div class="row">
				<div class="input-field">
					<i class="material-icons prefix">subject</i>
					<textarea id="textarea1" class="materialize-textarea"
						name="content"></textarea>
					<label for="textarea1">내용</label>
				</div>
			</div>

			<div class="row">
				<div class="col s12">
					<button type="button" class="btn-small waves-effect waves-light"
						id="btnAddFile">파일 추가</button>
				</div>
			</div>

			<div class="row" id="fileBox">
				<div class="col s12">
					<input type="file" name="file0" />
					<button class="waves-effect waves-light btn-small file-delete">
						<i class="material-icons">clear</i>
					</button>
				</div>
			</div>

			<br />
			<div class="row center">
				<button class="btn waves-effect waves-light" type="submit">
					답글등록 <i class="material-icons right">create</i>
				</button>
				&nbsp;&nbsp;
				<button class="btn waves-effect waves-light" type="reset">
					초기화 <i class="material-icons right">clear</i>
				</button>
				&nbsp;&nbsp;
				<button class="btn waves-effect waves-light" type="button"
					onclick="location.href = '/board/boardList.jsp?tab=<%=tab%>&pageNum=<%=pageNum%>'">
					글목록 <i class="material-icons right">list</i>
				</button>
			</div>
		</form>
	</div>
	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script>
	
	let fileIndex = 1;
	let fileCount = 1;
	
	$('#btnAddFile').on('click',function(){
		if(fileCount >=5){
			alert('첨부파일은 최대 5개까지 가능합니다.');
			return;
		}
		
		const str = `
			<div class="col s12">
				<input type="file" name="file\${fileIndex}" />
				<button class="waves-effect waves-light btn-small file-delete">
				<i class="material-icons">clear</i>
				</button>
			</div>`;
		
		$('#fileBox').append(str);
		
		fileIndex++;
		fileCount++;
	})
	
	$('#fileBox').on('click','button.file-delete',function(){
		$(this).closest('div').remove();
		fileCount--;
	})
	</script>
</body>
</html>

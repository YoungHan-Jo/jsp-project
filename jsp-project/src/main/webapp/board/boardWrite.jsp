<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("sessionLoginId");

String tab = request.getParameter("tab");
String pageNum = request.getParameter("pageNum");
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
			<h4>게시판 새글 쓰기</h4>
			<hr />
		</div>
		<form action="/board/boardWritePro.jsp" method="POST">
			<input type="hidden" name="pageNum" value="<%=pageNum %>" />

			<div class="row"></div>
			<div class="row">
				<div class="input-field col s12 m2 l2">
					<select name="tab">
						<option value="" disabled <%=tab.equals("") ? "selected": "" %> >탭 선택</option>
						<option value="R" <%=tab.equals("R") ? "selected": "" %>>리뷰</option>
						<option value="I" <%=tab.equals("I") ? "selected": "" %>>정보</option>
						<option value="C" <%=tab.equals("C") ? "selected": "" %>>잡담</option>
						<option value="E" <%=tab.equals("E") ? "selected": "" %>>기타</option>
					</select> <label>탭</label>
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
					새글등록 <i class="material-icons right">create</i>
				</button>
				&nbsp;&nbsp;
				<button class="btn waves-effect waves-light" type="reset">
					초기화 <i class="material-icons right">clear</i>
				</button>
				&nbsp;&nbsp;
				<button class="btn waves-effect waves-light" type="button"
					onclick="location.href = '/board/boardList.jsp?tab=<%=tab %>&pageNum=<%=pageNum %>'">
					글목록 <i class="material-icons right">list</i>
				</button>
			</div>
		</form>
	</div>
	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script></script>
</body>
</html>

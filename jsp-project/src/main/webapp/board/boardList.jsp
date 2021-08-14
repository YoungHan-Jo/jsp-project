<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<h4>게시판</h4>
			<hr />
		</div>
		<div class="row">
			<div class="col s6 m4 l3">
				<select>
					<option value="" disabled selected>Choose Movie</option>
					<option value="1">Option 1</option>
					<option value="2">Option 2</option>
					<option value="3">Option 3</option>
				</select> <label>Materialize Select</label>
			</div>
			<div class="col s6 m8 l9">
				<a href="#1" class="btn waves-effect waves-light right"> <i
					class="material-icons left">create</i>새글쓰기
				</a>
			</div>
		</div>
		<div class="row">
			<table class="highlight">
				<thead>
					<tr>
						<th>No</th>
						<th>영화</th>
						<th>글 제목</th>
						<th>글쓴이</th>
						<th>작성자</th>
						<th>추천수</th>
						<th>조회수</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td>3</td>
						<td>싱크홀</td>
						<td>dㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
						<td>Alvin</td>
						<td>2021.08.04</td>
						<td>6</td>
						<td>5</td>
					</tr>
					<tr>
						<td>2</td>
						<td>Jellybean</td>
						<td>$3.76</td>
						<td>Alvin</td>
						<td>2021.08.04</td>
						<td>2</td>
						<td>20</td>
					</tr>
					<tr>
						<td>1</td>
						<td>Lollipop</td>
						<td>$7.00</td>
						<td>Alvin</td>
						<td>2021.08.04</td>
						<td>3</td>
						<td>30</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row center">
			<ul class="pagination">
				<li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a>
				</li>
				<li class="active"><a href="#!">1</a></li>
				<li class="waves-effect"><a href="#!">2</a></li>
				<li class="waves-effect"><a href="#!">3</a></li>
				<li class="waves-effect"><a href="#!">4</a></li>
				<li class="waves-effect"><a href="#!">5</a></li>
				<li class="waves-effect"><a href="#!"><i
						class="material-icons">chevron_right</i></a></li>
			</ul>
		</div>
	</div>
	<div class="row container">
		<div class="container">
			<form action="/board/boardList.jsp" method="GET" id="frm">
				<div class="row">
					<div class="col s12 m3 l3">
						<div class="input-field">
							<i class="material-icons prefix">find_in_page</i> <select
								name="type">
								<option value="" disabled selected>--</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
								<option value="mid">작성자</option>
							</select> <label>검색 조건</label>
						</div>
					</div>

					<div class="col s12 m6 l6">
						<!-- AutoComplete -->
						<div class="input-field">
							<i class="material-icons prefix">search</i> <input type="text"
								id="autocomplete-input" class="autocomplete" name="keyword" />
							<label for="autocomplete-input">검색어</label>
						</div>
						<!-- end of AutoComplete -->
					</div>

					<div class="col s12 m3 l3">
						<button type="button" id="btnSearch"
							class="waves-effect waves-light btn-large">
							<i class="material-icons left">search</i>검색
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script></script>
</body>
</html>

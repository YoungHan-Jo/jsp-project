<%@page import="com.example.repository.MovieDAO"%>
<%@page import="com.example.domain.MovieVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String movieNum = request.getParameter("movieNum");

MovieDAO movieDAO = MovieDAO.getinstance();

MovieVO movieVO = movieDAO.getMovieByMovieNum(movieNum);

String releaseYear = movieVO.getReleaseDate().substring(0, 4);

%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style type="text/css">
img.movie-info {
	width: 100%;
}

.movie-story-title, .movie-story {
	padding-left: 30px;
}
.box-image {
  margin-top: 30px;
}

</style>
</head>
<body class="brown lighten-4">
	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->
	<div class="container">
		<div class="section">
			<h4>영화 상세</h4>
			<hr />
		</div>
		<div class="section">
			<div class="row">
				<div class="movie-info-img col l3 m4 s12">
					<div class="box-image center">
						<img class="movie-info" src="<%=movieVO.getThumbnail() %>" alt="" />
					</div>
				</div>
				<div class="movie-story-area col l9 m8 s12">
					<div class="section movie-story-title">
						<h4 class="title"><%=movieVO.getMovieTitle() %></h4>
						&nbsp;&nbsp;<span><%=releaseYear %></span>
					</div>
					<div class="divider grey lighten-1"></div>
					<div class="section">
						<div class="movie-story">
							<%=movieVO.getMovieSynopsis() %>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr />
		<div class="section astimation-area">
			<h5>한 줄 평</h5>
			<div class="row">
				<form class="col s12">
					<div class="input-field col s12 m3 l2">
						<select>
							<option value="" disabled selected>평점</option>
							<option value="5">★★★★★</option>
							<option value="4">★★★★☆</option>
							<option value="3">★★★☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="1">★☆☆☆☆</option>
						</select>
					</div>

					<div class="input-field col s12 m9 l10">
						<textarea id="textarea1" class="materialize-textarea"></textarea>
						<label for="textarea1">한 줄 평 쓰기</label>
					</div>
					<button type="submit" class="waves-effect waves-light btn">
						쓰기</button>
				</form>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th>작성자</th>
							<th>평점</th>
							<th>한 줄 평</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>Alvin</td>
							<td>★★★★☆</td>
							<td>dddddddddddddddddddddddddddddddddddd</td>
						</tr>
						<tr>
							<td>Alan</td>
							<td>★★★★★</td>
							<td>ssssssssssssss</td>
						</tr>
						<tr>
							<td>Jonathan</td>
							<td>★★★☆☆</td>
							<td>xxxxxxxxxxxxx</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script></script>
</body>
</html>

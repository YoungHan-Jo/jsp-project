<%@page import="com.example.domain.ScheduledMovieVO"%>
<%@page import="com.example.repository.ScheduledMovieDAO"%>
<%@page import="java.util.Date"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.MovieVO"%>
<%@page import="com.example.repository.MovieDAO"%>
<%@page import="com.example.repository.TodaysRankDAO"%>
<%@page import="com.example.domain.TodaysRankVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//DAO객체 준비
TodaysRankDAO rankDAO = TodaysRankDAO.getInstance();
MovieDAO movieDAO = MovieDAO.getInstance();
ScheduledMovieDAO scheduledMovieDAO = ScheduledMovieDAO.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style>
div.rank {
	margin: 0 25px 0 25px;
}

.dday, div.rank, div.coming-soon {
	border-radius: 10px;
}

img.movie-chart {
	width: 80%;
	border-radius: 10px;
}

.box-contents {
	padding-left: 30px;
}

.carousel-slider,
.carousel-box {
	height: 500px;
}

.dday, .coming-soon {
	margin-bottom: 5px;
	height: 45px;
}
</style>
</head>
<body class="brown lighten-4">

	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->

	<div class="container">
		<div class="section">
			<h4>상영 중인 영화</h4>
			<hr />
		</div>
		<div class="section">
			<div class="row">
				<%
				for (int i = 1; i <= 3; ++i) {

					TodaysRankVO rankVO = rankDAO.getMovieByRank(i);
					String movieNum = rankVO.getMovieNum();

					MovieVO movieVO = movieDAO.getMovieByMovieNum(movieNum);

					String str = movieVO.getReleaseDate();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					SimpleDateFormat toString = new SimpleDateFormat("yyyy.MM.dd");

					Date date = sdf.parse(str);

					String releaseDate = toString.format(date);
				%>
				<div class="movie-chart-list col l3 m6 s12">
					<div class="center rank red darken-2">
						<h4 class="white-text ">
							No.<%=i%></h4>
					</div>
					<div class="box-image center">
						<a href="/movie/movieInfo.jsp?movieNum=<%=movieNum%>"><img
							class="movie-chart" src="<%=movieVO.getThumbnail()%>" alt="" /></a>
					</div>
					<div class="box-contents">
						<h5 class="title"><%=movieVO.getMovieTitle()%></h5>
						<div class="box-reservationRate">
							<span>예매율</span> <span class="reservationRate"><%=rankVO.getReservationRate()%></span>
						</div>
						<div>
							<span><%=releaseDate%></span> <span>개봉</span>
						</div>
					</div>
				</div>
				<%
				}
				%>
				<div class="movie-chart-list col l3 m6 s12 hide-on-med-and-down">
					<div class="carousel-box">
						<div class="center coming-soon black">
							<h4 class="white-text ">Coming Soon!</h4>
						</div>
						<div class="carousel carousel-slider" id="demo-carousel-auto"
							data-indicators="true">
							<%
							for (int i = 1; i <= 3; ++i) {
								ScheduledMovieVO scheduledMovieVO = scheduledMovieDAO.getMovieByRank(i);
								String movieNum = scheduledMovieVO.getMovieNum();

								MovieVO movieVO = movieDAO.getMovieByMovieNum(movieNum);

								String str = movieVO.getReleaseDate();
								SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
								SimpleDateFormat toString = new SimpleDateFormat("yyyy.MM.dd");

								Date date = sdf.parse(str);

								String releaseDate = toString.format(date);
							%>
							<div class="carousel-item" href="#one!">
								<div class="box-image center">
									<a href="/movie/movieInfo.jsp?movieNum=<%=movieNum%>"><img
										class="movie-chart" src="<%=movieVO.getThumbnail()%>" alt="" /></a>
								</div>
								<div class="center black dday">
									<h4 class="white-text"><%=scheduledMovieVO.getDDay()%></h4>
								</div>

							</div>
							<%
							}
							%>


						</div>

					</div>
				</div>
			</div>
		</div>
		<div class="divider"></div>
		<div class="section">
			<div class="row">
				<%
				for (int i = 4; i <= 7; ++i) {

					TodaysRankVO rankVO = rankDAO.getMovieByRank(i);
					String movieNum = rankVO.getMovieNum();

					MovieVO movieVO = movieDAO.getMovieByMovieNum(movieNum);

					String str = movieVO.getReleaseDate();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					SimpleDateFormat toString = new SimpleDateFormat("yyyy.MM.dd");

					Date date = sdf.parse(str);

					String releaseDate = toString.format(date);
				%>
				<div class="movie-chart-list col l3 m6 s12">
					<div class="center rank brown lighten-1">
						<h4 class="white-text">
							No.<%=i%></h4>
					</div>
					<div class="box-image center">
						<a href="/movie/movieInfo.jsp?movieNum=<%=movieNum%>"><img
							class="movie-chart" src="<%=movieVO.getThumbnail()%>" alt="" /></a>
					</div>
					<div class="box-contents">
						<h5 class="title"><%=movieVO.getMovieTitle()%></h5>
						<div class="box-reservationRate">
							<span>예매율</span> <span class="reservationRate"><%=rankVO.getReservationRate()%></span>
						</div>
						<div>
							<span><%=releaseDate%></span> <span>개봉</span>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->


	<script>
		$(document).ready(function() {

			$('#demo-carousel-auto').carousel();

			setInterval(function() {
				$('#demo-carousel-auto').carousel('next');
			}, 3000);

			$(window).resize(function(){
				location.reload();
			});
			
		});
	</script>
</body>
</html>

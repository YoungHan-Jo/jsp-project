<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style>
div.rank {
  margin: 0 25px 0 25px;
}
img.movie-chart {
	width: 80%;
}
.box-contents {
  padding-left: 30px;
}
</style>
</head>
<body class="brown lighten-4">

	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->

	<div class="container">
		<div class="section">
			<h4>무비 차트</h4>
			<hr />
		</div>
		<div class="section">
			<div class="row">
				<div class="movie-chart-list col l3 m6 s12">
					<div class="center rank">
						<h4 class="white-text brown lighten-1">No.1</h4>
					</div>
					<div class="box-image center">
						<a href="info.html"><img class="movie-chart"
							src="/resources/image/poster.jpg" alt="" /></a>
					</div>
					<div class="box-contents">
						<h5 class="title">싱크홀</h5>
						<div class="box-reservationRate">
							<span>예매율</span> <span class="reservationRate">37.4%</span>
						</div>
						<div>
							<span>2021.08.11</span> <span>개봉</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="divider"></div>
		<div class="section">
			<div class="row">
				<div class="movie-chart-list col l3 m6 s12">
					<div class="center rank">
						<h4 class="white-text brown lighten-1">No.1</h4>
					</div>
					<div class="box-image center">
						<a href="info.html"><img class="movie-chart"
							src="/resources/image/poster.jpg" alt="" /></a>
					</div>
					<div class="box-contents">
						<h5 class="title">싱크홀</h5>
						<div class="box-reservationRate">
							<span>예매율</span> <span class="reservationRate">37.4%</span>
						</div>
						<div>
							<span>2021.08.11</span> <span>개봉</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->


	<script></script>
</body>
</html>

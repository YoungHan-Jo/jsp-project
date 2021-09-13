<%@page import="java.util.List"%>
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
String year = "2021";
if (request.getParameter("year") != null) {
	year = request.getParameter("year");
} ;

String month = "00";
if (request.getParameter("month") != null) {
	month = request.getParameter("month");
} ;

String releasedMonth = year + month;
if (month.equals("00")) {
	releasedMonth = year;
}

MovieDAO movieDAO = MovieDAO.getInstance();
List<MovieVO> movieList = movieDAO.getMoviesByReleasedMonth(releasedMonth);
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

.carousel-slider, .carousel-box {
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
			<h4>영화 목록</h4>
			<hr />
		</div>
		<form action="/movie/movieListPro.jsp" method="GET" id="frm">
			<div class="row">
				<div class="input-field col s6 m6 l2">
					<select name="year">
						<option value="" disabled>개봉 년도</option>
						<option value="2021"
							<%=year == null || year.equals("2021") ? "selected" : ""%>>2021년</option>
						<option value="2020" <%=year.equals("2020") ? "selected" : ""%>>2020년</option>
						<option value="2019" <%=year.equals("2019") ? "selected" : ""%>>2019년</option>
						<option value="2018" <%=year.equals("2018") ? "selected" : ""%>>2018년</option>
						<option value="2017" <%=year.equals("2017") ? "selected" : ""%>>2017년</option>
					</select> <label>개봉 년도</label>
				</div>
				<div class="input-field col s6 m6 l2">
					<select name="month">
						<option value="" disabled>개봉 월</option>
						<option value="00"
							<%=month == null || month.equals("00") ? "selected" : ""%>>전체</option>
						<option value="01" <%=month.equals("01") ? "selected" : ""%>>1월</option>
						<option value="02" <%=month.equals("02") ? "selected" : ""%>>2월</option>
						<option value="03" <%=month.equals("03") ? "selected" : ""%>>3월</option>
						<option value="04" <%=month.equals("04") ? "selected" : ""%>>4월</option>
						<option value="05" <%=month.equals("05") ? "selected" : ""%>>5월</option>
						<option value="06" <%=month.equals("06") ? "selected" : ""%>>6월</option>
						<option value="07" <%=month.equals("07") ? "selected" : ""%>>7월</option>
						<option value="08" <%=month.equals("08") ? "selected" : ""%>>8월</option>
						<option value="09" <%=month.equals("09") ? "selected" : ""%>>9월</option>
						<option value="10" <%=month.equals("10") ? "selected" : ""%>>10월</option>
						<option value="11" <%=month.equals("11") ? "selected" : ""%>>11월</option>
						<option value="12" <%=month.equals("12") ? "selected" : ""%>>12월</option>
					</select> <label>개봉 월</label>
				</div>
				<button type="button" id="btnSearch"
					class="waves-effect waves-light btn-large">
					<i class="material-icons left">search</i>검색
				</button>
			</div>
		</form>

		<div class="divider"></div>

		<div class="section">
			<div class="row">
				<%
				for (MovieVO movieVO : movieList) {

					String str = movieVO.getReleaseDate();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					SimpleDateFormat toString = new SimpleDateFormat("yyyy.MM.dd");

					Date date = sdf.parse(str);

					String releaseDate = toString.format(date);
				%>
				<div class="movie-chart-list col l3 m6 s12">

					<div class="box-image center">
						<a href="/movie/movieInfo.jsp?movieNum=<%=movieVO.getMovieNum()%>"><img
							class="movie-chart" src="<%=movieVO.getThumbnail()%>" alt="" /></a>
					</div>
					<div class="box-contents">
						<h5 class="title"><%=movieVO.getMovieTitle()%></h5>
						<span><%=releaseDate%></span> <span>개봉</span>

					</div>
					<%
					int len = movieVO.getMovieTitle().length();
					
					
					if (len <25 ) {
					%>
					<div class="section"></div>
					<div class="section"></div>
					
					<%
					}
					%>
					<%
					if (len < 100) {
					%>
					<div class="section"></div>
					<div class="section"></div>
					
					<%
					}
					%>

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
		$('#btnSearch').on('click', function() {

			var query = $('#frm').serialize();

			location.href = '/movie/movieList.jsp' + '?' + query;

		});
	</script>
</body>
</html>

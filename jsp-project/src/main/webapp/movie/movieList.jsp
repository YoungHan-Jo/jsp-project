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
		<div class="row">
			<div class="input-field col s6 m6 l2">
				<select>
					<option value="" disabled selected>개봉 년도</option>
					<option value="2021">2021년</option>
					<option value="2020">2020년</option>
					<option value="2019">2019년</option>
					<option value="2018">2018년</option>
					<option value="2017">2017년</option>
				</select> <label>개봉 년도</label>
			</div>
			<div class="input-field col s6 m6 l2">
				<select>
					<option value="" disabled selected>개봉 월</option>
					<option value="0">전체</option>
					<option value="1">1월</option>
					<option value="2">2월</option>
					<option value="3">3월</option>
					<option value="4">4월</option>
					<option value="5">5월</option>
					<option value="6">6월</option>
					<option value="7">7월</option>
					<option value="8">8월</option>
					<option value="9">9월</option>
					<option value="10">10월</option>
					<option value="11">11월</option>
					<option value="12">12월</option>
				</select> <label>개봉 월</label>
			</div>
		</div>

		<div class="divider"></div>
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

			$(window).resize(function() {
				location.reload();
			});

		});
	</script>
</body>
</html>

<%@page import="com.example.domain.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.ReviewDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.repository.MovieDAO"%>
<%@page import="com.example.domain.MovieVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
String id = (String)session.getAttribute("sessionLoginId");

%>
<%
// 파라미터값 가져오기
String movieNum = request.getParameter("movieNum");

// ====영화정보 가져오기====
MovieDAO movieDAO = MovieDAO.getInstance();
MovieVO movieVO = movieDAO.getMovieByMovieNum(movieNum);
String releaseYear = movieVO.getReleaseDate().substring(0, 4);

// ==== 평균 평점 ====
ReviewDAO reviewDAO = ReviewDAO.getInstance();
Double avgStar = reviewDAO.getAvgStarByMovieNum(movieNum);
avgStar = (double) Math.round(avgStar*100.0) / 100.0;

int reviewCount = reviewDAO.getCountByMovieNum(movieNum);

System.out.println("평점 : " + avgStar);
System.out.println("리뷰 수 : " + reviewCount);

// ==== 한줄 평 리스트 가져오기 ====
List<ReviewVO> reviewList = reviewDAO.getReviewsByMovieNum(movieNum);


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

.delete,
#releaseYear {
	opacity: 0.7;
}

.avgStar{
	font-size: 25px;
	font-weight: 100;
}

.review-count{
	opacity: 0.7;
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
						&nbsp;&nbsp;<span id="releaseYear"><%=releaseYear %></span>
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
			<h5>한 줄 리뷰</h5>
			
			<div class="row">
				<form action="/movie/movieInfoPro.jsp?movieNum=<%=movieVO.getMovieNum() %>" method="POST">
					<div class="input-field col s12 m3 l2">
						<select name="star">
							<option value="" disabled selected>평점</option>
							<option value="5">★★★★★</option>
							<option value="4">★★★★☆</option>
							<option value="3">★★★☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="1">★☆☆☆☆</option>
						</select>
					</div>

					<div class="input-field col s12 m9 l10">
						<textarea id="content" name="content" class="materialize-textarea"></textarea>
						<label for="textarea1">한 줄 리뷰 쓰기</label>
					</div>
					<button type="submit" class="waves-effect waves-light btn">
						쓰기</button>
				</form>
			</div>
			<div class="section star">
						<span class="avgStar">평점 : <%if(avgStar >= 5){
														%>
														★★★★★
														<%
														}else if(avgStar >= 4){
														%>★★★★☆<%	
														}else if(avgStar >= 3){
														%>★★★☆☆<%	
														}else if(avgStar >= 2){
														%>★★☆☆☆<%	
														}else if(avgStar >= 1){
														%>★☆☆☆☆<%	
														}else if(avgStar >= 0){
														%>☆☆☆☆☆<%	
														}%><%=avgStar %> / </span>
					<span>5.0</span><span class="review-count"> (<%=reviewCount %>개)</span>								
			</div>
			<div>
				<table class="review">
					<thead>
						<tr>
							<th>작성자</th>
							<th>평점</th>
							<th>한 줄 리뷰</th>
						</tr>
					</thead>
					<tbody>
						<%
						System.out.println(reviewList.size());
						
						if(reviewList.size()>0){ // 리뷰가 있을 때
							for(ReviewVO reviewVO :reviewList){
								%>
								<tr id="<%=reviewVO.getReviewNum() %>">
									<td style="width: 10%"><%=reviewVO.getId() %></td>
									<td style="width: 15%">
										<%
										switch(reviewVO.getStar()){
											case "1" :
												%>★☆☆☆☆<%
												break;
											case "2" :
												%>★★☆☆☆<%
												break;
											case "3" :
												%>★★★☆☆<%
												break;
											case "4" :
												%>★★★★☆<%
												break;
											case "5" :
												%>★★★★★<%
												break;
										}
										%>
									</td>
									<td style="width: 50%"><%=reviewVO.getReviewContent() %></td>
									<%
									if(reviewVO.getId().equals(id) == true){
										%><td class="right delete"><a id="btn-delete" class="waves-effect waves-light btn">삭제</a></td><%	
									}
									%>
								</tr>
								<%
							}//for
						}else{ // 리뷰가 없을 때
							%>
							<tr>
								<td colspan="4" class="center">리뷰가 존재하지 않습니다.</td>
							</tr>
							<%	
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script>
	$('table.review').on('click','#btn-delete',function(){
		var reviewNum = $(this).closest('tr')[0].id;
		
		location.href=`/movie/deleteReview.jsp?reviewNum=\${reviewNum}&movieNum=<%=movieNum %>`;
	});
	</script>
</body>
</html>

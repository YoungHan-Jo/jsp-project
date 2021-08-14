<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<img class="movie-info" src="/resources/image/poster.jpg" alt="" />
					</div>
				</div>
				<div class="movie-story-area col l9 m8 s12">
					<div class="section movie-story-title">
						<h4 class="title">싱크홀</h4>
						&nbsp;&nbsp;<span>2021</span>
					</div>
					<div class="divider grey lighten-1"></div>
					<div class="section">
						<div class="movie-story">
							<strong>사.상.초.유! 도심 속 초대형 재난 발생!</strong><br /> <br /> 서울 입성과
							함께 내 집 마련의 꿈을 이룬 가장 ‘동원(김성균)’&nbsp;<br /> 이사 첫날부터 프로 참견러
							‘만수’(차승원)와 사사건건 부딪힌다.<br /> <br /> ‘동원’은 자가취득을 기념하며 직장 동료들을
							집들이에 초대하지만<br /> 행복한 단꿈도 잠시, 순식간에 빌라 전체가 땅 속으로 떨어지고 만다.<br /> <br />
							마주치기만 하면 투닥거리는 빌라 주민 ‘만수’와 ‘동원’<br /> ‘동원’의 집들이에 왔던 ‘김대리’(이광수)와
							인턴사원 ‘은주’(김혜준)까지!<br /> 지하 500m 싱크홀 속으로 떨어진 이들은 과연 무사히 빠져나갈 수
							있을까?<br /> <br /> <strong>“한 500m 정도는 떨어진 것 같아”<br />
								“우리… 나갈 수 있을까요?”&nbsp;
							</strong>
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

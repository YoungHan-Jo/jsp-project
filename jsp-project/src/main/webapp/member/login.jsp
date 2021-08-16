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
			<h4>로그인</h4>
			<hr />
		</div>
		<div class="row container">
			<form class="col s12" action="/member/loginPro.jsp" method="POST">
				<div class="row">
					<div class="input-field col s12">
						<i class="material-icons prefix">account_circle</i> <input id="id"
							type="text" name="id" class="validate" /> <label for="id">아이디</label>
					</div>
				</div>

				<div class="row">
					<div class="input-field col s12">
						<i class="material-icons prefix">password</i> <input id="passwd"
							type="password" name="passwd" class="validate" />
						<label for="passwd">비밀번호</label>
					</div>
				</div>

				<p class="row center">
					<label> <input class="filled-in" type="checkbox"
						name="rememberMe" /> <span class="black-text">로그인 상태 유지</span>
					</label>
				</p>

				<br />
				<div class="row center">
					<button class="btn-large waves-effect waves-light" type="submit">
						로그인 <i class="material-icons right">login</i>
					</button>
				</div>

			</form>
			<div class="row center">
				<a href="/member/join.jsp" class="black-text">회원가입</a>
			</div>

			<br />
			<div class="row center">
				&nbsp;&nbsp;아이디 찾기 &nbsp;<span class="grey-text text-lighten-1">|</span>&nbsp;비밀번호
				찾기
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script></script>
</body>
</html>

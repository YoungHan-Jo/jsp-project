<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");
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

	<div class="row container">
		<!-- sideMenu area -->
		<jsp:include page="/include/sideMenu.jsp" />
		<!-- end of sideMenu -->
		<div class="col s12 m9 l9 container">
			<div class="section">
				<h4>회원탈퇴</h4>
				<hr />
			</div>
			<div class="container">
				<div class="row container">
					<form class="col s12" action="/member/removeMemberPro.jsp"
						method="post">
						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">account_box</i><input id="id"
									name="id" type="text" value="<%=id%>"
									class="validate" disabled /> <label for="id">아이디</label>
							</div>
						</div>
						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">lock</i><input id="passwd"
									name="passwd" type="password" class="validate" /> <label
									for="passwd">비밀번호</label>
							</div>
						</div>
						<br />
						<div class="row center">
							<button class="btn waves-effect waves-light" type="submit">
								회원탈퇴 <i class="material-icons right">create</i>
							</button>
						</div>
					</form>
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

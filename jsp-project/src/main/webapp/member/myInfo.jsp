<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");

MemberDAO memberDAO = MemberDAO.getinstance();
MemberVO memberVO = memberDAO.getMemberById(id);

// birthday 가져오기
String str = memberVO.getBirthday();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Date date = sdf.parse(str);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String birthday = sdf2.format(date);

// regDate 가져오기
Timestamp timestamp = memberVO.getRegDate();
String regDate = sdf2.format(timestamp);

//gender 가져오기
String gender = memberVO.getGender();
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

	<div class="row container">
		<!-- sideMenu area -->
		<jsp:include page="/include/sideMenu.jsp" />
		<!-- end of sideMenu -->
		<div class="col s12 l9 container">
			<div class="section">
				<h4>내 정보 보기</h4>
				<hr />
			</div>
			<div class="container">
				<div class="row container">

					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">account_box</i><input id="id"
								name="id" type="text" value="<%=memberVO.getId()%>"
								class="validate" disabled /> <label for="id">아이디</label>
						</div>
					</div>


					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">person</i><input id="name"
								type="text" name="name" value="<%=memberVO.getName()%>"
								class="validate" disabled /> <label for="name">이름</label>
						</div>
					</div>

					<div class="row">
						<div class="input-field">
							<i class="material-icons prefix">event</i><input type="date"
								id="birthday" value="<%=birthday%>" name="birthday" disabled />
							<label for="birthday">생년월일</label>
						</div>
					</div>

					<div class="row">
						<div class="input-field">
							<i class="material-icons prefix">wc</i><select name="gender"
								disabled>
								<option value="" disabled>성별을 선택하세요.</option>
								<option value="M" <%=gender.equals("M") ? "selected" : ""%>>남자</option>
								<option value="F" <%=gender.equals("F") ? "selected" : ""%>>여자</option>
								<option value="N" <%=gender.equals("N") ? "selected" : ""%>>선택
									안함</option>
							</select> <label>성별</label>
						</div>
					</div>

					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">mail</i><input id="email"
								type="email" name="email" value="<%=memberVO.getEmail()%>"
								class="validate" disabled /> <label for="email"> 이메일</label>
						</div>
					</div>
					<p class="row center">
						알림 이메일 수신 :
						<%
					if (memberVO.getRecvEmail().equals("Y")) {
					%>
						&nbsp;&nbsp; <label> <input name="recvEmail" value="Y"
							type="radio" checked /> <span>예</span>
						</label>

						<%
						} else {
						%>
						&nbsp;&nbsp; <label> <input name="recvEmail" value="N"
							type="radio" checked /> <span>아니오</span>
						</label>
						<%
						}
						%>
					</p>
					<div class="section"></div>
					<div class="row">
						<div class="input-field">
							<i class="material-icons prefix">event</i><input type="date"
								id="birthday" value="<%=regDate%>" name="birthday" disabled />
							<label for="birthday">가입일</label>
						</div>
					</div>



				</div>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->

</body>
</html>

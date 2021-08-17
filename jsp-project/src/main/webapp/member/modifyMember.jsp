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

//birthday 가져오기
String str = memberVO.getBirthday();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Date date = sdf.parse(str);
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
String birthday = sdf2.format(date);

//gender 가져오기
String gender = memberVO.getGender();
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
		<div class="col s12 l9 container">
			<div class="section">
				<h4>회원정보 수정</h4>
				<hr />
			</div>
			<div class="container">
				<div class="row container">
					<form class="col s12" action="/member/modifyMemberPro.jsp" method="post">
						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">account_box</i><input id="id"
									name="id" type="text" value="<%=memberVO.getId()%>"
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

						<div class="row">
							<div class="input-field col s12">
								<i class="material-icons prefix">person</i><input id="name"
									type="text" name="name" value="<%=memberVO.getName() %>" class="validate" /> <label for="name">이름</label>
							</div>
						</div>

						<div class="row">
							<div class="input-field">
								<i class="material-icons prefix">event</i><input type="date"
									id="birthday" value="<%=birthday %>" name="birthday" /> <label for="birthday">생년월일</label>
							</div>
						</div>

						<div class="row">
							<div class="input-field">
								<i class="material-icons prefix">wc</i><select name="gender">
									<option value="" disabled selected>성별을 선택하세요.</option>
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
									type="email" name="email" value="<%=memberVO.getEmail() %>" class="validate" /> <label
									for="email"> 이메일</label>
							</div>
						</div>
						<p class="row center">
							알림 이메일 수신 : &nbsp;&nbsp; <label> <input name="recvEmail"
								value="Y" type="radio" <%=memberVO.getRecvEmail().equals("Y")? "checked" : "" %>  /> <span>예</span>
							</label> &nbsp;&nbsp; <label> <input name="recvEmail" value="N"
								type="radio" <%=memberVO.getRecvEmail().equals("N")? "checked" : "" %>/> <span>아니오</span>
							</label>
						</p>

						<br />
						<div class="row center">
							<button class="btn waves-effect waves-light" type="submit">
								회원정보 수정 <i class="material-icons right">create</i>
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

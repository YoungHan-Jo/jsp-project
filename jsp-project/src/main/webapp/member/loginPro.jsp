<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

// 파라미터 받아오기
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String rememberMe = request.getParameter("rememberMe");

//DAO객체 준비
MemberDAO memberDAO = MemberDAO.getinstance();

MemberVO memberVO = memberDAO.getMemberById(id);

if(BCrypt.checkpw(passwd, memberVO.getPasswd())){ // 비밀번호 일치
	
	//세션 등록
	session.setAttribute("sessionLoginId", id);

	if(rememberMe != null){ // 로그인 유지 체크
		//쿠키 생성	
		Cookie cookie = new Cookie("cookieLoginId",id);
		//쿠키 수명
		cookie.setMaxAge(60*60*24);
		//쿠키 적용 경로
		cookie.setPath("/");
		//쿠기 태우기
		response.addCookie(cookie);
	}
	
	response.sendRedirect("/index.jsp");
	
	
}else{ // 비밀번호 불일치
	%>
	<script>
	alert('비밀번호가 일치하지 않습니다.');
	history.back();
	</script>
	<%
}

%>
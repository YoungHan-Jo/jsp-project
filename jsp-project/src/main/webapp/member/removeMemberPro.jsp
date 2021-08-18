<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");
String passwd = request.getParameter("passwd");

MemberDAO memberDAO = MemberDAO.getInstance();

MemberVO memberVO = memberDAO.getMemberById(id);

if (BCrypt.checkpw(passwd, memberVO.getPasswd()) == true) { // 비밀번호 일치
	
	//세션 삭제
	session.invalidate();
	
	//쿠키 삭제
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("cookieLoginId")){
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}//for
	}//if
	
	//DB에서 데이터 삭제
	memberDAO.deleteById(memberVO.getId());
				
	%>
	<script>
	alert('회원탈퇴 완료');
	location.href='/index.jsp';
	</script>
	<%
	
	
} else { // 비밀번호 불일치
%>
<script>
	alert('비밀번호가 일치하지 않습니다.');
	history.back();
</script>
<%
}
%>
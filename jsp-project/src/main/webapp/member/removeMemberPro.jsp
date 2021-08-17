<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("sessionLoginId");
String passwd = request.getParameter("passwd");

MemberDAO memberDAO = MemberDAO.getinstance();

MemberVO memberVO = memberDAO.getMemberById(id);

if (BCrypt.checkpw(passwd, memberVO.getPasswd()) == true) { // 비밀번호 일치
%>
<script>
	var isDel = confirm('정말 탈퇴하겠습니까?');
	if (isDel == true) {
		
	} else {
		history.back();
	}
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
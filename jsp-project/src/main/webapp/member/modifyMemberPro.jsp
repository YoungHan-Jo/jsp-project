<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="memberVO" class="com.example.domain.MemberVO" />

<jsp:setProperty property="*" name="memberVO" />

<%
String id = (String) session.getAttribute("sessionLoginId");

MemberDAO memberDAO = MemberDAO.getinstance();

MemberVO dbMemberVO = memberDAO.getMemberById(id);

if (BCrypt.checkpw(memberVO.getPasswd(), dbMemberVO.getPasswd()) == true) { // 비밀번호 일치

	memberVO.setId(id);
	
	// birthday - 없애기
	String birthday = memberVO.getBirthday().replace("-", "");
	memberVO.setBirthday(birthday);

	memberDAO.modifyMember(memberVO);
%>
<script>
	alert('회원정보 수정 완료');
	location.href = '/member/myInfo.jsp';
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
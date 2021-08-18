<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="memberVO" class="com.example.domain.MemberVO" />
<jsp:setProperty property="*" name="memberVO" />

<%
MemberDAO memberDAO = MemberDAO.getInstance();
%>

<%
if (memberDAO.getCountById(memberVO.getId()) == 0) { // id가 db에 존재하지 않을 때
	// 계정 생성일시 현재로 설정
	memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));

	// 비밀번호 암호화 설정
	String passwd = memberVO.getPasswd();
	String hashpw = BCrypt.hashpw(passwd, BCrypt.gensalt());
	memberVO.setPasswd(hashpw);

	// birthday - 없애기
	String birthday = memberVO.getBirthday().replace("-", "");
	memberVO.setBirthday(birthday);

	// DB에 입력
	memberDAO.insert(memberVO);
%>
<script>
	alert('회원가입 완료!');
	location.href = '/member/login.jsp';
</script>
<%
} else { // id가 db에 존재하면
%>
<script>
	alert('이미 존재하는 id 입니다.');
	history.back();
</script>
<%
}
%>
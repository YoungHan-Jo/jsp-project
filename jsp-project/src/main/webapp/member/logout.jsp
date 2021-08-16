<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 세션 전부 삭제
session.invalidate();

// 쿠키 삭제(수명0으로 만들기);
// 쿠키 가져오기
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("cookieLoginId")) {
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		} //if
	} //for
} // if
%>
<script>
	alert('로그아웃 완료');
	location.href = '/index.jsp';
</script>
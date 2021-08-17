<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 파라미터값 가져오기
String passwd = request.getParameter("passwd");
String newPasswd = request.getParameter("newPasswd");
String newPasswd2 = request.getParameter("newPasswd2");

String id = (String) session.getAttribute("sessionLoginId");

MemberDAO memberDAO = MemberDAO.getinstance();

MemberVO memberVO = memberDAO.getMemberById(id);

if (BCrypt.checkpw(passwd, memberVO.getPasswd()) == true) { //현재 비밀번호 일치
	
	if(newPasswd.equals("") == false && newPasswd2.equals("") == false){ // 새 비밀번호가 둘다 공란이 아닐 때
		if (newPasswd.equals(newPasswd2) == true) { // 새 비밀번호 확인 일치
			//비밀번호 암호화
			String hashpw = BCrypt.hashpw(newPasswd, BCrypt.gensalt());
			// memberVO객체에 입력
			memberVO.setPasswd(hashpw);
			// DB 데이터 수정
			memberDAO.changePasswd(memberVO);
			
			// ====로그아웃처리====
			session.invalidate();
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
				alert('비밀번호 수정 완료. 새로운 비밀번호로 다시 로그인 하세요.');
				location.href = '/member/login.jsp';
			</script>
			<%
			} else { // 새 비밀번호 확인 불일치
			%>
			<script>
				alert('새 비밀번호의 입력란이 서로 일치하지 않습니다.');
				history.back();
			</script>
			<%
			}
	}else{ // 새 비밀번호 입력란이 하나라도 공란 일때
		%>
		<script>
			alert('새로운 비밀번호를 입력해 주세요');
			history.back();
		</script>
		<%
	}

} else { // 현재 비밀번호 불일치
%>
<script>
	alert('현재 비밀번호가 일치하지 않습니다.');
	history.back();		
</script>
<%
}
%>
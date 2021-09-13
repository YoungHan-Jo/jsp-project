<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.side-bar {
	text-decoration: none;
	color: black;
}
</style>

<%
String id = (String) session.getAttribute("sessionLoginId");
%>

<nav class="nav-extended brown darken-4">
	<div class="nav-wrapper container">
		<a href="/index.jsp" class="brand-logo">Logo</a> <a href="#"
			data-target="mobile-demo" class="sidenav-trigger"><i
			class="material-icons">menu</i></a>
		<ul id="nav-mobile" class="right hide-on-med-and-down">
			<li><a href="/movie/movieList.jsp">영화</a></li>
			<li><a href="/board/boardList.jsp?tab=&pageNum=1">게시판</a></li>

			<%
			if (id == null) { // 로그인 되어있지 않음
			%>
			<li><a href="/member/login.jsp"><button
						class="waves-effect waves-light btn">로그인</button></a></li>
			<%
			} else { // 로그인 되어있음
				if(id.equals("admin")){
					%>
					<li><a href="/admin/manageMembers.jsp">관리자</a></li>
					<%
				}
			%>
			<li><a href="/member/myInfo.jsp">내 정보</a></li>
			<li><a href="/member/logout.jsp"><button
						class="waves-effect waves-light btn">로그아웃</button></a></li>
			<%
			}
			%>
		</ul>
	</div>
	
</nav>

<!-- mobile navbar-->

<ul class="collapsible sidenav" id="mobile-demo">
	<li>
		<div class="collapsible-header">
			<i class="material-icons">filter_drama</i>영화
		</div>
		<div class="collapsible-body">
			<span>Lorem ipsum dolor sit amet.</span>
		</div>
	</li>
	<li>
		<div class="collapsible-header">
			<i class="material-icons">place</i>게시판
		</div>
		<div class="collapsible-body">
			<span>Lorem ipsum dolor sit amet.</span>
		</div>
	</li>
	
	<%
	if (id == null) { // 로그인 되어있지 않음
	%>
	<li class="center"><a href="/member/login.jsp"><button
				class="waves-effect waves-light btn">로그인</button></a></li>
	<%
	} else { // 로그인 되어있음
	%>
	<li>
		<div class="collapsible-header">
			<i class="material-icons">account_circle</i><span>내 정보</span>
		</div>
		<div class="collapsible-body center">
			<a class="side-bar" href="/member/myInfo.jsp"><span>내 정보 보기</span></a><br>
			<a class="side-bar" href="/member/myInfo.jsp"><span>내가 쓴 글</span></a><br>
			<a class="side-bar" href="/member/modifyMember.jsp"><span>회원정보 수정</span></a><br>
			<a class="side-bar" href="/member/changePasswd.jsp"><span>비밀번호 변경</span></a><br>
			<a class="side-bar" href="/member/removeMember.jsp"><span>회원탈퇴</span></a>
		</div>
	</li>
	<li class="center"><a href="/member/logout.jsp"><button
				class="waves-effect waves-light btn">로그아웃</button></a></li>
	<%
	}
	%>
</ul>


















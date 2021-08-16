<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("sessionLoginId");
%>

<nav class="nav-extended brown darken-4">
	<div class="nav-wrapper container">
		<a href="/index.jsp" class="brand-logo">Logo</a> <a href="#"
			data-target="mobile-demo" class="sidenav-trigger"><i
			class="material-icons">menu</i></a>
		<ul id="nav-mobile" class="right hide-on-med-and-down">
			<li><a href="sass.html">영화</a></li>
			<li><a href="badges.html">게시판</a></li>

			<%
			if (id == null) { // 로그인 되어있지 않음
			%>
			<li><a href="/member/login.jsp"><button
						class="waves-effect waves-light btn">로그인</button></a></li>
			<%
			} else { // 로그인 되어있음
			%>
			<li><a href="/member/modifyMember.jsp">회원 정보</a></li>
			<li><a href="/member/logout.jsp"><button
						class="waves-effect waves-light btn">로그아웃</button></a></li>
			<%
			}
			%>
		</ul>
	</div>
	<div class="nav-content container">
		<ul class="tabs tabs-transparent">
			<li class="tab right"><a href="#test1">Test 1</a></li>
			<li class="tab right"><a class="active" href="#test2">Test 2</a></li>
			<li class="tab right disabled"><a href="#test3">Disabled</a></li>
			<li class="tab right"><a href="#test4">Test 4</a></li>
		</ul>
	</div>
</nav>

<!-- mobile navbar-->

<ul class="collapsible sidenav" id="mobile-demo">
	<li>
		<div class="collapsible-header">
			<i class="material-icons">filter_drama</i>First
		</div>
		<div class="collapsible-body">
			<span>Lorem ipsum dolor sit amet.</span>
		</div>
	</li>
	<li>
		<div class="collapsible-header">
			<i class="material-icons">place</i>Second
		</div>
		<div class="collapsible-body">
			<span>Lorem ipsum dolor sit amet.</span>
		</div>
	</li>
	<li>
		<div class="collapsible-header">
			<i class="material-icons">whatshot</i>Third
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
	<li class="center"><a href="/member/logout.jsp"><button
				class="waves-effect waves-light btn">로그아웃</button></a></li>
	<%
	}
	%>
</ul>


















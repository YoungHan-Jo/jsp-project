<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.side-menu {
	margin-top: 50px;
}
a {
	text-decoration: none;
	color: black;
}
</style>

<div class="col s12 m3 l3 side-menu">
	<ul class="collection with-header ">
		<li class="collection-header brown lighten-2 white-text"><h4>내
				정보</h4></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/myInfo.jsp">내 정보 보기</a></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/myInfo.jsp">내가 쓴 글</a></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/modifyMember.jsp">회원정보 수정</a></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/modifyMember.jsp">비밀번호 변경</a></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/removeMember.jsp">회원탈퇴</a></li>
	</ul>
</div>

<script>
	$(document).ready(function() {
		$('.hover').on('mouseover', function() {
			$(this).addClass('brown');
		})
		$('.hover').on('mouseleave', function() {
			$(this).removeClass('brown');
		})
	})
</script>
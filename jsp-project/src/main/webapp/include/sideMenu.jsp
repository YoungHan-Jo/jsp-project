<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="col s12 m3 l3 side-menu">
	<ul class="collection with-header ">
		<li class="collection-header brown lighten-2 white-text"><h4>내
				정보</h4></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/myInfo.jsp">내 정보 보기</a></li>
		<li class="collection-item hover lighten-3"><a
			href="/member/myInfo.jsp">내 정보 보기</a></li>
		<li class="collection-item hover lighten-3">회원정보 수정</li>
		<li class="collection-item hover lighten-3">비밀번호 변경</li>
		<li class="collection-item hover lighten-3">회원탈퇴</li>
	</ul>
	<div class="collection">
        <a href="#!" class="collection-item">Alvin</a>
        <a href="#!" class="collection-item active">Alvin</a>
        <a href="#!" class="collection-item">Alvin</a>
        <a href="#!" class="collection-item">Alvin</a>
      </div>
</div>


<script>
	$(document).ready(function() {
		$('.hover').on('mouseover', function() {
			$(this).addClass('brown');
		})
		$('.hover').on('mouseleave', function() {
			$(this).removeClass('brown');
		})
		
		$('.hover').on('click', function() {
			$(this).addClass('clicked').removeClass('brown');
		})
		
	})
</script>
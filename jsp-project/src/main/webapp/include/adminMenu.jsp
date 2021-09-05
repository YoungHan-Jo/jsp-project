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

<div class="col s12 l3 side-menu hide-on-med-and-down">
	<ul class="collection with-header ">
		<li class="collection-header brown lighten-2 white-text"><h4>관리자</h4></li>
		<li class="collection-item hover lighten-3"><a
			href="/admin/manageMembers.jsp">회원 관리</a></li>
		<li class="collection-item hover lighten-3"><a
			href="/admin/manageBoards.jsp">게시글 관리</a></li>

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
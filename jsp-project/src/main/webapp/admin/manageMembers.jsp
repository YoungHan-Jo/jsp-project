<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
</head>
<body class="brown lighten-4">
	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->

	<div class="row container">
		<!-- sideMenu area -->
		<jsp:include page="/include/adminMenu.jsp" />
		<!-- end of sideMenu -->
		<div class="col s12 l9 container">
			<div class="section">
				<h4>관리자 - 회원 관리</h4>
				<hr />
			</div>
			<div class="section">

				<div class="col s6 m6 l3">
					<div class="input-field">
						<input type="text" id="autocomplete-input" class="autocomplete"
							name="memberId" /> <label for="autocomplete-input">회원 아이디</label>
					</div>
				</div>

				<div class="col s6 m2 l2">
					<button type="button" id="btnSearch"
						class="waves-effect waves-light btn-large">
						<i class="material-icons left">search</i>조회
					</button>
				</div>
				<div class="col s12 m2 l2">
					<button type="button" id="btnTotal"
						class="waves-effect waves-light btn-large">전체 조회</button>
				</div>
			</div>
			<div class="section">
				<table id="table-member">
					
				</table>
			</div>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script>
	
	function showData(array){
		var str = `
				<tr>
					<th>아이디</th><th>이름</th><th>성별</th><th>생년월일</th>
				<tr>
				`;
		
		
		if(array != null && array.length > 0) {
			
			for(var member of array) {
				
				str += `
					<tr>/* jsp문서라서 \$로 해야함 */
						<td>\${member.id}</td>
						<td>\${member.name}</td>
						<td>\${member.gender}</td>
						<td>\${member.birthday}</td>
					</tr>
				`;
			} // for
			
		}else{ // array != null || array.length == 0
			str = `
				<tr><td>해당하는 데이터가 없습니다.</td></tr>
			`;
		}
		$('table').html(str);
		
	}// showData


	$('button#btnTotal').on('click', function() {

		//ajax 함수 호출 - 비동기(쓰레드랑 비슷) 자바스크립트
		$.ajax({
			url : '/api/members',
			method : 'GET',
			success : function(data){
				console.log(data);
				console.log(typeof data);
				
				showData(data);
			}
			
		});

	})
	</script>
</body>
</html>
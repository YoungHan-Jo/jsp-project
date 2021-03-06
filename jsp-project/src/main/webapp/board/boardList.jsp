<%@page import="com.example.repository.CommentDAO"%>
<%@page import="com.example.repository.RecommendDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.PageDTO"%>
<%@page import="com.example.domain.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("sessionLoginId");
%>
<%
// 글목록 가져오기 조건 객체 준비
Criteria cri = new Criteria(); // 기본 생성자 1페이지 10줄

//pageNum cri에 저장
String strPageNum = request.getParameter("pageNum");
if (strPageNum != null) {
	cri.setPageNum(Integer.parseInt(strPageNum));
}

//tab 파라미터 가져오기
String tab = request.getParameter("tab");
if (tab != null) {
	cri.setTab(tab);
}

//type 파라미터 가져오기
String type = "";
if(request.getParameter("type") != null){
	type = request.getParameter("type");
	cri.setType(type);
}

//keyword 파라미터 가져오기
String keyword = ""; 
if(request.getParameter("keyword") != null){
	keyword = request.getParameter("keyword");
	cri.setKeyword(keyword);
}

System.out.println("type : " + type);
System.out.println("keyword : " + keyword);

//DAO 객체준비
BoardDAO boardDAO = BoardDAO.getInstance();
RecommendDAO recDAO = RecommendDAO.getInstance();

//board 테이블에서 글 가져오기
List<BoardVO> boardList;

//전체 글(조건에 맞는 글) 개수 가져오기
int totalCount;

if(cri.getType().length()>0 && cri.getKeyword().length() > 0){ // 검색 시
	boardList = boardDAO.getBoardsByKeyword(cri);
	totalCount = boardDAO.getCountByKeyword(cri);
}else{ // 검색 아닐 때
	boardList = boardDAO.getBoards(cri);
	totalCount = boardDAO.getCountByCriteria(cri);
}





//페이지 블록정보
PageDTO pageDTO = new PageDTO(cri, totalCount);
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style>
tr#boardList {
	cursor: pointer;
}
a{
	text-decoration: none;
	color: black;
}
.reply-level{
	display: inline-block;
}
</style>
</head>
<body class="brown lighten-4">
	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->

	<div class="container">
		<div class="section">
			<h4><a href="/board/boardList.jsp?tab=&pageNum=1">게시판</a></h4>
			<hr />
		</div>
		<div class="row">
			<div class="col s6 m4 l3">
				<select id="tabs">
					<option value="" disabled
						<%=cri.getTab().equals("") || cri.getTab() == null ? "selected" : ""%>>탭
						선택</option>
					<option value="" <%=cri.getTab().equals("") ? "selected" : ""%>>전체</option>
					<option value="R" <%=cri.getTab().equals("R") ? "selected" : ""%>>리뷰</option>
					<option value="I" <%=cri.getTab().equals("I") ? "selected" : ""%>>정보</option>
					<option value="C" <%=cri.getTab().equals("C") ? "selected" : ""%>>잡담</option>
					<option value="E" <%=cri.getTab().equals("E") ? "selected" : ""%>>기타</option>
				</select> <label>Materialize Select</label>
			</div>
			<%
			if (id != null) {
			%>
			<div class="col s6 m8 l9">
				<a href="/board/boardWrite.jsp?tab=<%=cri.getTab()%>&pageNum=<%=cri.getPageNum()%>"
					class="btn waves-effect waves-light right"> <i
					class="material-icons left">create</i>새글쓰기
				</a>
			</div>
			<%
			}
			%>
		</div>
		<div class="row">
			<table class="highlight">
				<thead>
					<tr>
						<th class="center">No</th>
						<th class="center">탭</th>
						<th>글 제목</th>
						<th class="center">작성자</th>
						<th class="center">작성일</th>
						<th class="center">추천수</th>
						<th class="center">조회수</th>
					</tr>
				</thead>

				<tbody>

					<%
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
					String date;
					
					CommentDAO commentDAO = CommentDAO.getInstance();

					for (BoardVO boardVO : boardList) {
						date = sdf.format(boardVO.getRegDate());
						int commentNum = commentDAO.getCountByBoard(boardVO.getBoardNum());
						
					%>
					<tr id="boardList"
						onclick="location.href='/board/boardContent.jsp?boardNum=<%=boardVO.getBoardNum()%>&tab=<%=cri.getTab()%>&type=<%=cri.getType() %>&keyword=<%=cri.getKeyword() %>&pageNum=<%=cri.getPageNum()%>'">
						<td class="center"><%=boardVO.getBoardNum()%></td>
						<td style="width: 10%" class="center">
							<%
							switch (boardVO.getTab()) {
								case "R" :
									%>리뷰<%
									break;
								case "I" :
									%>정보<%
									break;
								case "C" :
									%>잡담<%
									break;
								default :
									%>기타<%
								}
								%>
						</td>
						<td style="width: 40%">
						<%
						if(boardVO.getReLev() > 0){ // 답글이면
							%>
							<span class="reply-level" style="width: <%=boardVO.getReLev()*15 %>px"></span>
							<i class="material-icons">subdirectory_arrow_right</i>	
							<%
						}
						%>
						
						<%=boardVO.getSubject()%> (<%=commentNum %>)</td>
						<td class="center"><%=boardVO.getMemberId()%></td>
						<td class="center"><%=date%></td>
						<td class="center"><%=recDAO.getCountByBoard(boardVO.getBoardNum()) %></td>
						<td class="center"><%=boardVO.getViewCount()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<div class="row center">
			<ul class="pagination">
				<%
				// 이전 버튼
				if (pageDTO.isPrev()) {
				%>
				<li class="waves-effect"><a
					href="/board/boardList.jsp?tab=<%=cri.getTab() %>&type=<%=cri.getType() %>&keyword=<%=cri.getKeyword() %>&pageNum=<%=pageDTO.getStartPage() - 1%>">
						<i class="material-icons">chevron_left</i>
				</a></li>
				<%
				}
				%>
				<%
				// 페이지 블록 내 최대 5개씩 출력
				for (int i = pageDTO.getStartPage(); i <= pageDTO.getEndPage(); ++i) {
				%>
				<li class="waves-effect <%=cri.getPageNum() == i ? "active" : ""%>">
					<a href="/board/boardList.jsp?tab=<%=cri.getTab()%>&type=<%=cri.getType() %>&keyword=<%=cri.getKeyword() %>&pageNum=<%=i%>"><%=i%></a>
				</li>
				<%
				}
				%>

				<%
				// 다음 버튼
				if (pageDTO.isNext()) {
				%>
				<li class="waves-effect"><a
					href="/board/boardList.jsp?tab=<%=cri.getTab() %>&type=<%=cri.getType() %>&keyword=<%=cri.getKeyword() %>&pageNum=<%=pageDTO.getEndPage() + 1%>">
						<i class="material-icons">chevron_right</i>
				</a></li>
				<%
				}
				%>

			</ul>
		</div>
	</div>
	<div class="row container">
		<div class="container">
			<form action="/board/boardList.jsp" method="GET" id="frm">
				<div class="row">
					<div class="col s12 m3 l3">
						<div class="input-field">
							<i class="material-icons prefix">find_in_page</i> 
							<select	name="type">
								<option value="" disabled selected>--</option>
								<option value="subject" <%=cri.getType().equals("subject")? "selected" : "" %>>제목</option>
								<option value="content" <%=cri.getType().equals("content")? "selected" : "" %>>내용</option>
								<option value="member_id" <%=cri.getType().equals("member_id")? "selected" : "" %>>작성자</option>
							</select><label>검색 조건</label>
						</div>
					</div>

					<div class="col s12 m6 l6">
						<!-- AutoComplete -->
						<div class="input-field">
							<i class="material-icons prefix">search</i> <input type="text"
								id="autocomplete-input" class="autocomplete" name="keyword" value="<%=cri.getKeyword() %>"/>
							<label for="autocomplete-input">검색어</label>
						</div>
						<!-- end of AutoComplete -->
					</div>

					<div class="col s12 m3 l3">
						<button type="button" id="btnSearch"
							class="waves-effect waves-light btn-large">
							<i class="material-icons left">search</i>검색
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
	<script>
		$('select#tabs').on('change', function(event) {
			var tab = event.target.value;

			location.href = `/board/boardList.jsp?tab=\${tab}&type=<%=type %>&keyword=<%=keyword %>&pageNum=1`;
		})
		
		$('#btnSearch').on('click',function(){
			
			//폼 태그의 쿼리들을 문자열로 한번에 가져옴. // type=subject&keyword=답글
			var query = $('#frm').serialize();
			
			location.href = '/board/boardList.jsp?tab=<%=cri.getTab()%>' + '&' + query;
		});
	</script>
</body>
</html>

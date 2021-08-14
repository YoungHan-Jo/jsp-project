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

    <div class="container">
      <div class="section">
        <h4>게시판 상세</h4>
        <hr />
      </div>
      <div class="row">
        <div class="title"></div>
        <table class="" id="boardList">
          <tr>
            <th>영화</th>
            <td colspan="11">싱크홀</td>
          </tr>
          <tr>
            <th>제목</th>
            <td colspan="5">ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</td>
            <td></td>
            <td></td>
            <td></td>

            <th>작성일</th>
            <td colspan="2">2021.08.11</td>
          </tr>
          <tr>
            <th>작성자</th>
            <td colspan="6">aaaa</td>
            <th>조회수</th>
            <td>11</td>
            <th>추천수</th>
            <td>22</td>
            <th>댓글수</th>
            <td>2</td>
          </tr>
          <tr>
            <td colspan="12">
              <pre></pre>
            </td>
          </tr>
          <tr>
            <th>첨부파일</th>
            <td colspan="11"></td>
          </tr>
        </table>
      </div>
      <div class="section">
        <div class="row">
          <div class="col s12 right-align">
            <a
              class="btn waves-effect waves-light"
              href="/board/boardModify.jsp?num=&pageNum="
            >
              <i class="material-icons left">edit</i>글수정
            </a>
            <a class="btn waves-effect waves-light" onclick="remove(event)">
              <i class="material-icons left">delete</i>글삭제
            </a>

            <a
              class="btn waves-effect waves-light"
              href="/board/replyWrite.jsp?reRef=&reLev=&reSeq=&pageNum="
            >
              <i class="material-icons left">reply</i>답글
            </a>

            <a
              class="btn waves-effect waves-light"
              href="/board/boardList.jsp?pageNum="
            >
              <i class="material-icons left">list</i>글목록
            </a>
          </div>
        </div>
      </div>
    </div>

    <!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
  </body>
</html>
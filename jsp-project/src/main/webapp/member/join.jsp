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
        <h4>회원가입</h4>
        <hr />
      </div>
      <div class="container">
      <div class="row container">
        <form class="col s12" action="/member/joinPro.jsp" method="post" >
          <div class="row">
            <div class="input-field col s12">
              <i class="material-icons prefix">account_box</i
              ><input id="id" name="id" type="text" class="validate" />
              <label for="id">아이디</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s12">
              <i class="material-icons prefix">lock</i
              ><input
                id="passwd"
                name="passwd"
                type="password"
                class="validate"
              />
              <label for="passwd">비밀번호</label>
            </div>
          </div>
          <div class="row">
            <div class="input-field col s12">
              <i class="material-icons prefix">check</i
              ><input id="passwd2" type="password" class="validate" />
              <label for="passwd2">비밀번호 확인</label>
            </div>
          </div>

          <div class="row">
            <div class="input-field col s12">
              <i class="material-icons prefix">person</i
              ><input id="name" type="text" name="name" class="validate" />
              <label for="name">이름</label>
            </div>
          </div>

          <div class="row">
            <div class="input-field">
              <i class="material-icons prefix">event</i
              ><input type="date" id="birthday" name="birthday" />
              <label for="birthday">생년월일</label>
            </div>
          </div>

          <div class="row">
            <div class="input-field">
              <i class="material-icons prefix">wc</i
              ><select name="gender">
                <option value="" disabled selected>성별을 선택하세요.</option>
                <option value="M">남자</option>
                <option value="F">여자</option>
                <option value="N">선택 안함</option>
              </select>
              <label>성별</label>
            </div>
          </div>

          <div class="row">
            <div class="input-field col s12">
              <i class="material-icons prefix">mail</i
              ><input id="email" type="email" name="email" class="validate" />
              <label for="email"> 이메일</label>
            </div>
          </div>
          <p class="row center">
            알림 이메일 수신 : &nbsp;&nbsp;
            <label>
              <input name="recvEmail" value="Y" type="radio" checked />
              <span>예</span>
            </label>
            &nbsp;&nbsp;
            <label>
              <input name="recvEmail" value="N" type="radio" />
              <span>아니오</span>
            </label>
          </p>

          <br />
          <div class="row center">
            <button class="btn waves-effect waves-light" type="submit">
              회원가입 <i class="material-icons right">create</i>
            </button>
            &nbsp;&nbsp;
            <button class="btn waves-effect waves-light" type="reset">
              초기화 <i class="material-icons right">clear</i>
            </button>
          </div>
        </form>
      </div>
      </div>
    </div>

    	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->
    <script></script>
  </body>
</html>

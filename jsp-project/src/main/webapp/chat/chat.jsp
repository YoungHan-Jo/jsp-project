<%@page import="com.example.domain.ScheduledMovieVO"%>
<%@page import="com.example.repository.ScheduledMovieDAO"%>
<%@page import="java.util.Date"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.example.domain.MovieVO"%>
<%@page import="com.example.repository.MovieDAO"%>
<%@page import="com.example.repository.TodaysRankDAO"%>
<%@page import="com.example.domain.TodaysRankVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String id = (String) session.getAttribute("sessionLoginId");
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/include/head.jsp" />
<style>
div#chat {
	display: none;
}

div#chatBox,#first-chatbox {
	width: 500px;
	height: 400px;
	padding: 20px 10px;
	background-color: lightyellow;
	overflow: auto; /* 스크롤바 자동으로 */
}
</style>
</head>
<body class="brown lighten-4">

	<!-- navbar area -->
	<jsp:include page="/include/navbar.jsp" />
	<!-- end of navbar -->

	<div class="container">
		<div class="section">
			<h4>채팅</h4>
			<hr />
		</div>

		<div id="first">
			<div id="first-chatbox"></div>
			<br>
			<button type="button" class="waves-effect waves-light btn" id="btnJoinChat">채팅방 참가</button>
			
		</div>
		<div class="section"></div>

		<div id="chat">
			<div id="chatBox"></div>
			<div class="row">
				<div class="input-field col l6 m6 s16">
					<input id="message" type="text" class="validate" placeholder="채팅글 입력"/>
				</div>
				<div class="input-field col l6 m6 s6">
					<button type="button" class="waves-effect waves-light btn" id="btnSend">전송</button>		
				</div>
			</div>
			
			
			<button type="button" class="waves-effect waves-light btn" id="btnDisconnect">채팅방 연결 끊기</button>
			<div class="section"></div>
		</div>
	</div>



	<!-- footer area -->
	<jsp:include page="/include/footer.jsp" />
	<!-- end of footer -->


	<script>
		var webSocket;
		var nickname;

		//채팅방 참가 버튼 클릭 시
		$('#btnJoinChat').on('click', function() {
			nickname = '<%=id%>';
			console.log(nickname);
			connect(); // 웹소켓 객체생성하여 서버소켓과 접속 후 소켓이벤트 연결하기
			addWinEvt(); // 브라우저에 beforeunload, unload 이벤트 연결
		});

		function connect() {
			var url = 'ws://' + location.host + '/chat';
			console.log('url : ' + url);

			//웹소켓 서버에 연결하기
			webSocket = new WebSocket(url);

			//소켓이벤트 연결하기 (총4가지: open, close, error, message)
			webSocket.onopen = onOpen; // 서버와 연결된 후 호출됨
			webSocket.onclose = onClose; // 서버와 연결이 끊긴 후 호출됨
			webSocket.onmessage = onMessage; // 서버로부터 메세지를 받으면 호출됨
		}

		function onOpen(event) {
			webSocket.send(nickname + '님이 입장하였습니다.'); // 서버의 onMessage로 보냄
			scrollDown();

			$('div#first').css('display', 'none');
			$('div#chat').css('display', 'block');
		} // onOpen

		function onClose(event) {
			$('div#chatBox').append(
					`<div class="chat-message">채팅방과의 연결이 끊어졌습니다.</div>`);
			scrollDown();
		}// onClose
		
		function onMessage(event) {
			console.log(typeof event.data);
			var str = event.data;
			$('div#chatBox').append(`<div class="chat-message">\${str}</div>`);
			scrollDown();
		}//onMessage

		// 채팅방 연결 끊기 버튼 클릭 시
		$('#btnDisconnect').on('click', function(){
			disconnect()
		});

		function disconnect() {
			if (webSocket == null) {
				return;
			}
			webSocket.send(nickname + '님이 퇴장하였습니다.'); // 서버의 onMessage로 보냄
			webSocket.close();
			webSocket = null;

			$(this).prop('disabled', true);
			$('#btnSend').prop('disabled', true); // 버튼 비활성화
		}

		//전송버튼 클릭시, 채팅내용을 서버에전송
		$('#btnSend').on('click', function() {
			send();
		});

		// 채팅입력 글상자에서 엔터키 누를시, 채팅내용을 서버에전송
		$('input#message').on('keyup', function(event) {
			if (event.keyCode == 13) { // 엔터키 누르면
				send();
			}
		});

		function send() {
			var str = $('input#message').val();

			webSocket.send(nickname + ' : ' + str);

			$('input#message').val(''); // 입력란 비우기
			$('input#message').focus(); // 입력란으로 포커스
		} // send

		// 채팅 스크롤바를 하단으로 이동
		function scrollDown() {
			//ta.scrollTop = ta.scrollHeight; <- JAVA 방식

			// 0번째 인덱스로 순수 객체 꺼낼 수 있음
			var scrollHeight = $('div#chatBox')[0].scrollHeight;
			$('div#chatBox').scrollTop(scrollHeight);

		} //scrollDown

		//beforeunload, unload 이벤트 연결
		function addWinEvt() {
			// 브라우저에 현재 화면이 unload 되기 이전 발생되는 이벤트
			window.addEventListener('beforeunload', function(event) {
				var dialogText = 'Dialog text here';
				// 크롬은 이벤트 객체에 returnValue 속성의 텍스트값 설정이 필요함
				event.returnValue = dialogText;
				return dialogText;
			});

			// 브라우저에 기존 화면이 다른화면으로 완전히 unload 되면 발생되는 이벤트
			window.addEventListener('beforeunload', function() {
				disconnect();
			});

		} //addWinEvt
	</script>
</body>
</html>

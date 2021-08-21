<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// 이미지 파일 눌렀을 때

String fileName = request.getParameter("fileName");

File file = new File("C:/jyh/upload", fileName);

if(file.exists() == false){
	return;
}

String contentType = Files.probeContentType(file.toPath());

//응답객체에 컨텐트 타입 설정
response.setContentType(contentType); // 브라우저에 무슨타입인지 전달.

// 읽어들일 이미지 파일을 파일입력스트림 객체로 준비
FileInputStream is = new FileInputStream(file);

// 파일 입력스트림ㅇ르 바이트 배열로
byte[] image = IOUtils.toByteArray(is);

// 요청 클라이언트 쪽으로 보낼 출력(응답) 스트림
ServletOutputStream os = response.getOutputStream();

//사용자 출력스트림으로 내보내기
os.write(image);

//입출력스트림 닫기
is.close();
os.close();


%>
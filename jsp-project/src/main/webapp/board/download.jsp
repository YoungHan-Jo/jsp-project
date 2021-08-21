<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 다운로드 페이지

String fileName = request.getParameter("fileName");

File file = new File("C:/jyh/upload", fileName);

if (file.exists() == false) {
	return;
}

String contentType = Files.probeContentType(file.toPath());
// 잘 안쓰는 타입은 null로 나옴
if (contentType == null) {
	contentType = "application/octet-stream";
}

// 응답객체에 컨텐트타입 설정
response.setContentType(contentType);

//경로를 제외한 파일명 구하기
int beginIndex = fileName.lastIndexOf("/") + 1;
String fname = fileName.substring(beginIndex);

//한글 파일명이면 한글 깨지는거 해결
// 파운로드 파일명의 문자셋을 utf-8에서 iso-8859-1로 변경
fname = new String(fname.getBytes("utf-8"), "iso-8859-1");

//다운로드로 사용할 파일명을 응답헤더에 설정
response.setHeader("Content-disposition", "attachment; filename=" + fname);

//읽어들일(다운로드할) 파일을 파일입력스트림 객체로 준비
BufferedInputStream is = new BufferedInputStream(new FileInputStream(file));

//요청 클라이언트 쪽으로 보낼 출력(응답) 스트림 준비
ServletOutputStream os = response.getOutputStream();

//사용자 출력스트림으로 파일 내보내기.
int data;
while ((data = is.read()) != -1) {
	os.write(data);
}

//입출력 스트림 닫기
is.close();
os.close();
%>
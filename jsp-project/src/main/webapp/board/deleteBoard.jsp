<%@page import="java.io.File"%>
<%@page import="com.example.domain.AttachVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int boardNum = Integer.parseInt(request.getParameter("boardNum"));

//DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();

List<AttachVO> attachList = attachDAO.getAttachesByBoardNum(boardNum);

String uploadFolder = "C:/jyh/upload";

for(AttachVO attach : attachList){
	String path = uploadFolder + "/" + attach.getUploadPath() + "/" + attach.getFileName();
	File deleteFile = new File(path);
	
	if(deleteFile.exists()){
		deleteFile.delete();
	}//if
	
	if(attach.getFileType().equals("I")){
		String thumbnailPath = uploadFolder + "/" + attach.getUploadPath()+"/s_" + attach.getFileName();
		File thumbnailFile = new File(thumbnailPath);
		if(thumbnailFile.exists()){
			thumbnailFile.delete();
		}
	}//if
}//for


//DB에서 삭제
attachDAO.deleteAttachesByBoardNum(boardNum);
boardDAO.deleteByBoardNum(boardNum);

%>
<script>
alert('게시글을 삭제했습니다.');
location.href='/board/boardList.jsp';
</script>

<%@page import="net.coobird.thumbnailator.Thumbnailator"%>
<%@page import="java.io.IOException"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.UUID"%>
<%@page import="com.example.domain.AttachVO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%!String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str;
	}

	// 이미지 파일인지 확인
	boolean checkImageType(File file) {

		boolean isImage = false;

		try {
			String contentType = Files.probeContentType(file.toPath());

			System.out.println("contentType : " + contentType);

			isImage = contentType.startsWith("image");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return isImage;
	}%>

<%
String uploadFolder = "C:/jyh/upload"; // 업로드 기준 경로

File uploadPath = new File(uploadFolder, getFolder());

System.out.println("uploadPath : " + uploadPath.getPath());

if (uploadPath.exists() == false) {
	uploadPath.mkdirs();
}

// == 파일 업로드 ==
MultipartRequest multi = new MultipartRequest(request, uploadPath.getPath(), 1024 * 1024 * 50, "utf-8",
		new DefaultFileRenamePolicy());
// == 파일 업로드 완료 ==

// DAO 객체 준비
AttachDAO attachDAO = AttachDAO.getInstance();
BoardDAO boardDAO = BoardDAO.getInstance();

// insert할 새 게시글 번호 가져오기
int nextNum = boardDAO.getNextNum();

//input type="file" 태그의 name 속성들을 가져오기
Enumeration<String> enu = multi.getFileNames();

while (enu.hasMoreElements()) { // 파일이 있으면

	String fname = enu.nextElement();

	//저장된 파일명 가져오기
	String filename = multi.getFilesystemName(fname);
	System.out.println("getFilesystemName : " + filename);

	if (filename == null) { // 업로드 할 파일 정보가 없으면
		continue; // 다음 반복으로 건너뛰기
	}

	//AttachVO 객체준비
	AttachVO attachVO = new AttachVO();

	UUID uuid = UUID.randomUUID();
	attachVO.setUuid(uuid.toString());

	attachVO.setFileName(filename);
	attachVO.setUploadPath(getFolder());
	attachVO.setBoardNum(nextNum);

	File file = new File(uploadPath, filename); // 경로에 있는 실제 파일 객체

	boolean isImage = checkImageType(file);

	attachVO.setFileType((isImage == true) ? "I" : "O");

	//이미지 파일이면 썸네일 이미지 생성하기
	if (isImage == true) {
		File outFile = new File(uploadPath, "s_" + filename); // 출력할 썸네일 파일정보
		//(읽을 파일, 출력할 썸네일 파일, 넓이, 높이)
		Thumbnailator.createThumbnail(file, outFile, 100, 100); // 썸네일 생성
	}

	attachDAO.addAttach(attachVO);

} // while

// ===============답글 board DB에 추가하기=================

// boardVO 객체 준비
BoardVO boardVO = new BoardVO();

boardVO.setBoardNum(nextNum);

// tab
String tab = "";
if (multi.getParameter("tab") != null) {
	tab = multi.getParameter("tab");
}
boardVO.setTab(tab);

// member id
String id = (String) session.getAttribute("sessionLoginId");
boardVO.setMemberId(id);

// subject
String subject = multi.getParameter("subject");

if (subject.length() > 0 && subject != null) {
	boardVO.setSubject(subject);
} else {
%>
<script>
	alert('제목을 입력하세요');
	history.back();
</script>
<%
return;
}

// content
String content = multi.getParameter("content");
if (content.length() > 0 && content != null) {
boardVO.setContent(content);
} else {
%>
<script>
	alert('내용을 입력하세요');
	history.back();
</script>
<%
return;
}

//view count
boardVO.setViewCount(0);

// regDate
boardVO.setRegDate(new Timestamp(System.currentTimeMillis()));

// re
int reRef = Integer.parseInt(multi.getParameter("reRef"));
int reLev = Integer.parseInt(multi.getParameter("reLev"));
int reSeq = Integer.parseInt(multi.getParameter("reSeq"));

boardVO.setReRef(reRef);
boardVO.setReLev(reLev);
boardVO.setReSeq(reSeq);

// re컬럼 정렬과 동시에 DB에 추가
boardDAO.updateReSeqAndAddReply(boardVO);

// 페이지 상세보기로 넘어가기
String type = multi.getParameter("type");
String keyword = multi.getParameter("keyword");
String pageNum = multi.getParameter("pageNum");
System.out.println("pageNum : " + pageNum);
System.out.println("keyword : " + keyword);
response.sendRedirect("/board/boardContent.jsp?boardNum=" + boardVO.getBoardNum() + "&tab=&type=" + type
		+ "&keyword=" + keyword + "&pageNum=" + pageNum);
%>
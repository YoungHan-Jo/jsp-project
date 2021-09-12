package com.example.restapi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.domain.RecommendVO;
import com.example.repository.RecommendDAO;
import com.example.util.RecommendDeserializer;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet("/api/recommend/*")
public class RecommendRestServlet extends HttpServlet {

	private static final String BASE_URI = "/api/recommend";

	private RecommendDAO recDAO = RecommendDAO.getInstance();

	private Gson gson = new Gson();

	public RecommendRestServlet() {
		GsonBuilder builder = new GsonBuilder();
		builder.registerTypeAdapter(RecommendVO.class, new RecommendDeserializer());
		gson = builder.create();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String requestURI = request.getRequestURI();

		String boardNum = requestURI.substring(BASE_URI.length());

		String strJson = "";

		boardNum = boardNum.substring(1);

		System.out.println("boardNum : " + boardNum);

		int count = recDAO.getCountByBoard(Integer.parseInt(boardNum));
		List<String> list = recDAO.getAccountsByBoardNum(Integer.parseInt(boardNum));

		Map<String, Object> map = new HashMap<>();
		map.put("count", count);
		map.put("list", list);

		strJson = gson.toJson(map);

		sendResponse(response, strJson);

	} // doGet

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// application/json 형식의 데이터를 받을때
		// HTTP 메시지 바디를 직접 읽어와야 함
		BufferedReader reader = request.getReader();

		// HTTP 메시지 바디 영역으로부터 JSON 문자열 읽어오기
		String strJson = readMessageBody(reader);
		System.out.println("JSON 문자열 : " + strJson);

		// JSON 문자열 -> 자바객체로 변환 (역직렬화)
		RecommendVO recVO = gson.fromJson(strJson, RecommendVO.class);
		System.out.println(recVO);

		// DB에 추가하기
		recDAO.addRecommend(recVO);

		// 응답 데이터 준비
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("recVO", recVO);

		// 자바객체 -> JSON 문자열로 변환 (직렬화)
		String strResponse = gson.toJson(map); // {}
		
		System.out.println(strResponse);

		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strResponse);

	} // doPost

	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// application/json 형식의 데이터를 받을때
		// HTTP 메시지 바디를 직접 읽어와야 함
		BufferedReader reader = request.getReader();

		// HTTP 메시지 바디 영역으로부터 JSON 문자열 읽어오기
		String strJson = readMessageBody(reader);
		System.out.println("JSON 문자열 : " + strJson);

		// JSON 문자열 -> 자바객체로 변환 (역직렬화)
		RecommendVO recVO = gson.fromJson(strJson, RecommendVO.class);
		System.out.println(recVO);
		
		Map<String,Object> map = new HashMap<>();
		
		int count = recDAO.getCountByBoard(recVO.getBoardNum());
		
		if(count > 0) {
			// DB에서 삭제
			recDAO.deleteRecommend(recVO);
			map.put("isDeleted", true);
			map.put("recVO", recVO);
		}else {
			map.put("isDeleted", false);
		}
		
		// 자바객체 -> JSON 문자열로 변환 (직렬화)
		String strResponse = gson.toJson(map);
		
		System.out.println(strResponse);
		
		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strResponse);
		
	} // doDelete

	private String readMessageBody(BufferedReader reader) throws IOException {

		StringBuilder sb = new StringBuilder();
		String line = "";
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		} // while

		return sb.toString();
	} // readMessageBody

	private void sendResponse(HttpServletResponse response, String json) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	} // sendResponse

}

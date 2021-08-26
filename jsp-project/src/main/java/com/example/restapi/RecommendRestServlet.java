package com.example.restapi;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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

		Map<String, Object> map = new HashMap<>();
		map.put("count", map);

		strJson = gson.toJson(map);

		sendResponse(response, strJson);

	} // doGet

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	} // doPost

	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	} // doDelete

	private void sendResponse(HttpServletResponse response, String json) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	} // sendResponse

}

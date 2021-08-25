package com.example.restapi;

import java.io.IOException;

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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
	
	
	
	
	
	
}

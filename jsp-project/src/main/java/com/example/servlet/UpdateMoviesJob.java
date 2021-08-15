package com.example.servlet;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.example.domain.MovieVO;
import com.example.domain.ScheduledMovieVO;
import com.example.domain.TodaysRankVO;
import com.example.repository.MovieDAO;
import com.example.repository.TodaysRankDAO;

public class UpdateMoviesJob implements Job {

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {

		// DAO 객체 준비
		TodaysRankDAO rankDAO = TodaysRankDAO.getinstance();
		MovieDAO movieDAO = MovieDAO.getinstance();

		// 웹크롤링으로 정보 가져오기
		String url = "http://www.cgv.co.kr/movies/"; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-movie-chart");
		Elements elements = element.select("li");

		// todays_rank 테이블 초기화
		rankDAO.deleteAll();

		int num = 1;
		// 1~7위까지 하나씩 돌리기
		for (Element li : elements) {
			if (li.text().length() > 0) { // 내용이 있는 li만 가져오기

				int movieRank = num;
				String movieTitle = li.select("strong.title").text().trim();
				String thumbnail = li.select("span.thumb-image img").attr("src");
				String movieNum = thumbnail.substring(thumbnail.lastIndexOf("/") + 1, thumbnail.lastIndexOf("/") + 6);
				String reservationRate = li.select("strong.percent span").text().trim();
				String date = li.select("span.txt-info").text().trim().substring(0, 10);
				String releaseDate = date.replace(".", "");
				String synopsis = crawlingSynopsis(movieNum);

				// ======== todays_rank 추가 ========
				TodaysRankVO rankVO = new TodaysRankVO();
				rankVO.setTodaysRank(movieRank);
				rankVO.setMovieNum(movieNum);
				rankVO.setReservationRate(reservationRate);

				rankDAO.insert(rankVO);
				// ======== todays_rank 추가 완료 ========

				// ======== movie 테이블 추가 ========
				if (movieDAO.getCountByMovieNum(movieNum) == 0) { // movie 테이블에 존재하지 않을 때
					MovieVO movieVO = new MovieVO();
					movieVO.setMovieNum(movieNum);
					movieVO.setMovieTitle(movieTitle);
					movieVO.setReleaseDate(releaseDate);
					movieVO.setThumbnail(thumbnail);
					movieVO.setMovieSynopsis(synopsis);

					movieDAO.insert(movieVO);
				}
				// ======== movie 테이블 추가 완료 ========

				num++;
			} // if
		} // for

		Elements lists = crawlingScheduledMovie();

		num = 1;

		for (Element li : lists) {
			if (li.text().length() > 0) {
				int rank = num;
				String movieTitle = li.select("strong.title").text().trim();
				String thumbnail = li.select("span.thumb-image img").attr("src");
				String movieNum = thumbnail.substring(thumbnail.lastIndexOf("/") + 1, thumbnail.lastIndexOf("/") + 6);
				String date = li.select("span.txt-info").text().trim().substring(0, 10);
				String releaseDate = date.replace(".", "");
				String dDay = li.select("em.dday").text().trim();
				String synopsis = crawlingSynopsis(movieNum);

				// ======== todays_rank 추가 ========
				ScheduledMovieVO scheduledMovieVO = new ScheduledMovieVO();
				scheduledMovieVO.setRank(rank);
				scheduledMovieVO.setMovieNum(movieNum);
				scheduledMovieVO.setDDay(dDay);
				
				
				// ======== movie 테이블 추가 ========
				if (movieDAO.getCountByMovieNum(movieNum) == 0) { // movie 테이블에 존재하지 않을 때
					MovieVO movieVO = new MovieVO();
					movieVO.setMovieNum(movieNum);
					movieVO.setMovieTitle(movieTitle);
					movieVO.setReleaseDate(releaseDate);
					movieVO.setThumbnail(thumbnail);
					movieVO.setMovieSynopsis(synopsis);

					movieDAO.insert(movieVO);
				}
				// ======== movie 테이블 추가 완료 ========
				
				
				num++;

			} // if

		} // for

	} // excute

	private String crawlingSynopsis(String movieNum) {
		String synopsis = "";

		String url = "http://www.cgv.co.kr/movies/detail-view/?midx=" + movieNum; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-story-movie");

		synopsis = element.html();

		return synopsis;
	}// crawlingSynopsis

	private Elements crawlingScheduledMovie() {
		Elements lists = null;

		String url = "http://www.cgv.co.kr/movies/pre-movies.aspx"; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-movie-chart");

		Element ol = element.select("ol").first();
		lists = ol.select("li");

		return lists;
	}// crawlingScheduledMovie

}

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
import com.example.repository.ScheduledMovieDAO;
import com.example.repository.TodaysRankDAO;

public class UpdateMoviesJob implements Job {
	
	private Elements lists;

	private String movieTitle;
	private String thumbnail;
	private String movieNum;
	private String reservationRate;
	private String date;
	private String releaseDate;
	private String synopsis;
	private String dDay;
	
	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {

		// DAO 객체 준비
		TodaysRankDAO rankDAO = TodaysRankDAO.getinstance();
		MovieDAO movieDAO = MovieDAO.getinstance();
		ScheduledMovieDAO scheduledMovieDAO = ScheduledMovieDAO.getinstance();

		// 크롤링으로 TodaysRank 정보 가져오기
		lists = crawlingTodaysRank();
		// todays_rank DB테이블 초기화
		rankDAO.deleteAll();

		int num = 1;
		// 크롤링해 온 1~7위 돌려서 DB 입력
		for (Element li : lists) {
			if (li.text().length() > 0) { // 내용이 있는 li만 가져오기

				int movieRank = num;
				movieTitle = li.select("strong.title").text().trim();
				thumbnail = li.select("span.thumb-image img").attr("src");
				movieNum = thumbnail.substring(thumbnail.lastIndexOf("/") + 1, thumbnail.lastIndexOf("/") + 6);
				reservationRate = li.select("strong.percent span").text().trim();
				date = li.select("span.txt-info").text().trim().substring(0, 10);
				releaseDate = date.replace(".", "");
				synopsis = crawlingSynopsis(movieNum);

				// ======== todays_rank 추가 ========
				TodaysRankVO rankVO = new TodaysRankVO();
				rankVO.setTodaysRank(movieRank);
				rankVO.setMovieNum(movieNum);
				rankVO.setReservationRate(reservationRate);

				rankDAO.insert(rankVO);
				// ======== todays_rank 추가 완료 ========

				// ======== movie 테이블 추가 ========
				if (movieDAO.getCountByMovieNum(movieNum) == 0) { // movie 테이블에 존재하지 않는
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

		// ================= 개봉예정 영화 추가 =================

		// 크롤링으로 ScheduledMovie 정보 가져오기
		lists = crawlingScheduledMovie();
		// shceduled_movie DB테이블 초기화
		scheduledMovieDAO.deleteAll();

		num = 1;
		// 크롤링 해 온 1~3위 돌리기
		for (Element li : lists) {
			if (li.text().length() > 0) {
				int rank = num;
				movieTitle = li.select("strong.title").text().trim();
				thumbnail = li.select("span.thumb-image img").attr("src");
				movieNum = thumbnail.substring(thumbnail.lastIndexOf("/") + 1, thumbnail.lastIndexOf("/") + 6);
				date = li.select("span.txt-info").text().trim().substring(0, 10);
				releaseDate = date.replace(".", "");
				dDay = li.select("em.dday").text().trim();
				synopsis = crawlingSynopsis(movieNum);

				// ======== todays_rank 추가 ========
				ScheduledMovieVO scheduledMovieVO = new ScheduledMovieVO();
				scheduledMovieVO.setScheduledRank(rank);
				scheduledMovieVO.setMovieNum(movieNum);
				scheduledMovieVO.setDDay(dDay);

				scheduledMovieDAO.insert(scheduledMovieVO);
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
	} // excute

	// 시놉시스 정보 크롤링
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

	// 상영 예정 영화 목록 크롤링
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

	// 상영 중인 영화 랭크 목록 크롤링
	private Elements crawlingTodaysRank() {
		Elements lists = null;

		String url = "http://www.cgv.co.kr/movies/"; // 크롤링할 url지정
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// select로 태그 선택
		Elements element = doc.select("div.sect-movie-chart");
		lists = element.select("li");

		return lists;
	}// crawlingTodaysRank

}

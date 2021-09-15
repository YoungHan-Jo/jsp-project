package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.ReviewVO;


public class ReviewDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static ReviewDAO instance;

	public static ReviewDAO getInstance() {
		if (instance == null) {
			instance = new ReviewDAO();
		}
		return instance;
	}

	private ReviewDAO() {
	}

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM review";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll
	
	public void deleteReviewByReviewNum(int reviewNum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "DELETE FROM review ";
			sql += " WHERE review_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reviewNum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteReviewByReviewNum
	
	public int getCountAll() {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM review ";

			pstmt = con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return count;
	} // getCountAll
	
	public int getCountByMovieNum(String movieNum) {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM review ";
			sql += " WHERE movie_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return count;
	} // getCountByMovieNum
	
	public double getAvgStarByMovieNum(String movieNum) {

		double avg = 0.0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT AVG(star) AS avg ";
			sql += " FROM review ";
			sql += " WHERE movie_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				avg = rs.getDouble("avg");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return avg;
	} // getAvgStarByMovieNum
	
	
	
	
	// 영화별 리뷰 가져오기
	public List<ReviewVO> getReviewsByMovieNum(String movieNum) {

		List<ReviewVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM review ";
			sql += " WHERE movie_num = ? ";
			sql += " ORDER BY review_num ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieNum);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO reviewVO = new ReviewVO();
				reviewVO.setReviewNum(rs.getInt("review_num"));
				reviewVO.setMovieNum(rs.getString("movie_num"));
				reviewVO.setId(rs.getString("id"));
				reviewVO.setStar(rs.getString("star"));
				reviewVO.setReviewContent(rs.getString("review_content"));
				
				list.add(reviewVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return list;
	} // getReviewsByMovieNum
	
	//id별 리뷰 가져오기
	public List<ReviewVO> getReviewsByMemberId(String id) {

		List<ReviewVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM review ";
			sql += " WHERE id = ? ";
			sql += " ORDER BY review_num DESC ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewVO reviewVO = new ReviewVO();
				reviewVO.setReviewNum(rs.getInt("review_num"));
				reviewVO.setMovieNum(rs.getString("movie_num"));
				reviewVO.setId(rs.getString("id"));
				reviewVO.setStar(rs.getString("star"));
				reviewVO.setReviewContent(rs.getString("review_content"));
				
				list.add(reviewVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return list;
	} // getReviewsByMemberId
	
	// 새 한줄평에 설정할 글 번호
	public int getNextNum() {
		int num = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT IFNULL(MAX(review_num),0) + 1 AS nextnum ";
			sql += " FROM review ";	

			pstmt = con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("nextnum");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return num;
	} //getNextNum
	

	public void addReview(ReviewVO reviewVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO review(review_num, movie_num, id, star, review_content) ";
			sql += " VALUES (?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reviewVO.getReviewNum());
			pstmt.setString(2, reviewVO.getMovieNum());
			pstmt.setString(3, reviewVO.getId());
			pstmt.setString(4, reviewVO.getStar());
			pstmt.setString(5, reviewVO.getReviewContent());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // addReview
	
}

package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.MovieVO;


public class MovieDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static MovieDAO instance;

	public static MovieDAO getInstance() {
		if (instance == null) {
			instance = new MovieDAO();
		}
		return instance;
	}

	private MovieDAO() {
	}

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM movie";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll

	public void insert(MovieVO movieVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO movie(movie_num, movie_title, release_date, thumbnail, movie_synopsis) ";
			sql += " VALUES (?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieVO.getMovieNum());
			pstmt.setString(2, movieVO.getMovieTitle());
			pstmt.setString(3, movieVO.getReleaseDate());
			pstmt.setString(4, movieVO.getThumbnail());
			pstmt.setString(5, movieVO.getMovieSynopsis());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // insert
	
	public List<MovieVO> getMoviesByReleasedMonth(String releasedMonth) {

		List<MovieVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM movie ";
			sql += " WHERE release_date LIKE ? ";
			sql += " ORDER BY release_date ASC " ;

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, releasedMonth + "%" );
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MovieVO movieVO = new MovieVO();
				movieVO.setMovieNum(rs.getString("movie_num"));
				movieVO.setMovieTitle(rs.getString("movie_title"));
				movieVO.setReleaseDate(rs.getString("release_date"));
				movieVO.setThumbnail(rs.getString("thumbnail"));
				movieVO.setMovieSynopsis(rs.getString("movie_synopsis"));
				
				list.add(movieVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return list;
	} // getMoviesByReleasedMonth

	public MovieVO getMovieByMovieNum(String movieNum) {

		MovieVO movieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM movie ";
			sql += " WHERE movie_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, movieNum);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				movieVO = new MovieVO();
				movieVO.setMovieNum(rs.getString("movie_num"));
				movieVO.setMovieTitle(rs.getString("movie_title"));
				movieVO.setReleaseDate(rs.getString("release_date"));
				movieVO.setThumbnail(rs.getString("thumbnail"));
				movieVO.setMovieSynopsis(rs.getString("movie_synopsis"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return movieVO;
	} // getMovieByMovieNum
	
	public int getCountByMovieNum(String movieNum) {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM movie ";
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

}

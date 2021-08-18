package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.domain.ScheduledMovieVO;

public class ScheduledMovieDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static ScheduledMovieDAO instance;

	public static ScheduledMovieDAO getInstance() {
		if (instance == null) {
			instance = new ScheduledMovieDAO();
		}
		return instance;
	}

	private ScheduledMovieDAO() {
	}

	// ========================deleteAll()==================================

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM scheduled_movie";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll

	// ========================insert()=====================================
	public void insert(ScheduledMovieVO scheduledMovieVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO scheduled_movie(scheduled_rank, movie_num, d_day) ";
			sql += " VALUES(?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, scheduledMovieVO.getScheduledRank());
			pstmt.setString(2, scheduledMovieVO.getMovieNum());
			pstmt.setString(3, scheduledMovieVO.getDDay());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // insert

	public ScheduledMovieVO getMovieByRank(int rank) {
		ScheduledMovieVO scheduledMovieVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM scheduled_movie ";
			sql += " WHERE scheduled_rank = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rank);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				scheduledMovieVO = new ScheduledMovieVO();
				scheduledMovieVO.setScheduledRank(rs.getInt("scheduled_rank"));
				scheduledMovieVO.setMovieNum(rs.getString("movie_num"));
				scheduledMovieVO.setDDay(rs.getString("d_day"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}

		return scheduledMovieVO;
	}
}

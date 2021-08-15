package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.domain.TodaysRankVO;

public class TodaysRankDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static TodaysRankDAO instance;

	public static TodaysRankDAO getinstance() {
		if (instance == null) {
			instance = new TodaysRankDAO();
		}
		return instance;
	}

	private TodaysRankDAO() {
	}

	// ========================deleteAll()==================================

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM todays_rank";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll

	// ========================insert()=====================================
	public void insert(TodaysRankVO rankVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO todays_rank(todays_rank, movie_num, reservation_rate) ";
			sql += " VALUES (?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rankVO.getTodaysRank());
			pstmt.setString(2, rankVO.getMovieNum());
			pstmt.setString(3, rankVO.getReservationRate());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // insert

	public TodaysRankVO getMovieByRank(int todaysRank) {
		TodaysRankVO todaysRankVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM todays_rank ";
			sql += " WHERE todays_rank = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, todaysRank);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				todaysRankVO = new TodaysRankVO();
				todaysRankVO.setTodaysRank(rs.getInt("todays_rank"));
				todaysRankVO.setMovieNum(rs.getString("movie_num"));
				todaysRankVO.setReservationRate(rs.getString("reservation_rate"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}

		return todaysRankVO;
	}
}

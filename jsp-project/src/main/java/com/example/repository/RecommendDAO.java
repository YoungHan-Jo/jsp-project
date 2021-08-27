package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.RecommendVO;

public class RecommendDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static RecommendDAO instance;

	public static RecommendDAO getInstance() {
		if (instance == null) {
			instance = new RecommendDAO();
		}
		return instance;
	}

	private RecommendDAO() {
	}

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM board";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll

	public void deleteRecommend(RecommendVO recVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "DELETE FROM recommend ";
			sql += " WHERE board_num = ? ";
			sql += " AND id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, recVO.getBoardNum());
			pstmt.setString(2, recVO.getId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteById

	public int getCountByBoard(int boardNum) {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM recommend ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return count;
	} // getCountByBoard
	
	public List<String> getAccountsByBoardNum(int boardNum){
		List<String> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT id ";
			sql += " FROM recommend ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String id = rs.getString("id");
				
				list.add(id);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		
		return list;
	} //getAccountsByBoardNum
	
	public boolean isRecommendedByRecVO(RecommendVO recVO) {

		boolean isRecommended = false;
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM recommend ";
			sql += " WHERE board_num = ? ";
			sql += " AND id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, recVO.getBoardNum());
			pstmt.setString(2, recVO.getId());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		
		if(count > 0) {
			isRecommended = true;
		}
		
		return isRecommended;
	} // getCountByRecVO

	public void addRecommend(RecommendVO recVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO recommend(board_num, id) ";
			sql += " VALUES (?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, recVO.getBoardNum());
			pstmt.setString(2, recVO.getId());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // addRecommend

}

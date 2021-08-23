package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.AttachVO;

public class AttachDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static AttachDAO instance;

	public static AttachDAO getInstance() {
		if (instance == null) {
			instance = new AttachDAO();
		}
		return instance;
	}

	private AttachDAO() {
	}

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM attach";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll
	
	public void deleteAttachesByBoardNum(int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "DELETE FROM attach ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAttachesByBoardNum

	public int getCountAll() {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM attach ";

			pstmt = con.prepareStatement(sql);

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
	} // getCountAll

	public void addAttach(AttachVO attachVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO attach(uuid, upload_path, file_name, file_type, board_num) ";
			sql += " VALUES (?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, attachVO.getUuid());
			pstmt.setString(2, attachVO.getUploadPath());
			pstmt.setString(3, attachVO.getFileName());
			pstmt.setString(4, attachVO.getFileType());
			pstmt.setInt(5, attachVO.getBoardNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // addAttach
	
	public List<AttachVO> getAttachesByBoardNum(int boardNum){
		List<AttachVO> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM attach ";
			sql += " WHERE board_num = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			rs = pstmt.executeQuery();

			while(rs.next()) {
				AttachVO attachVO = new AttachVO();
				attachVO.setUuid(rs.getString("uuid"));
				attachVO.setUploadPath(rs.getString("upload_path"));
				attachVO.setFileName(rs.getString("file_name"));
				attachVO.setFileType(rs.getString("file_type"));
				attachVO.setBoardNum(rs.getInt("board_num"));
				
				list.add(attachVO);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		
		return list;
	} //getAttachesByBoardNum

}

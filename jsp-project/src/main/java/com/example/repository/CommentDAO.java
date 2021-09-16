package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.CommentVO;
import com.example.domain.Criteria;

public class CommentDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static CommentDAO instance;

	public static CommentDAO getInstance() {
		if (instance == null) {
			instance = new CommentDAO();
		}
		return instance;
	}

	private CommentDAO() {
	}

	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM comment";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteAll

	public void deleteByCommentNum(int commentNum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "DELETE FROM comment ";
			sql += " WHERE comment_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentNum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteByCommentNum

	public int getCountAll() {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM comment ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("cnt");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}

		return count;
	} // getCountAll
	
	public int getCountByBoard(int boardNum) {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM comment ";
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
			JdbcUtils.close(con, pstmt, rs);
		}

		return count;
	} // getCountAll


	public CommentVO getCommentByCommentNum(int commentNum) {

		CommentVO commentVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM comment ";
			sql += " WHERE comment_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				commentVO = new CommentVO();
				commentVO.setCommentNum(rs.getInt("comment_num"));
				commentVO.setBoardNum(rs.getInt("board_num"));
				commentVO.setId(rs.getString("id"));
				commentVO.setContent(rs.getString("content"));
				commentVO.setRegDate(rs.getTimestamp("reg_date"));
				commentVO.setReRef(rs.getInt("re_ref"));
				commentVO.setReLev(rs.getInt("re_lev"));
				commentVO.setReSeq(rs.getInt("re_seq"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}

		return commentVO;
	} // getCommentByCommentNum


	public List<CommentVO> getCommentsByBoardNum(int boardNum) {

		List<CommentVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM comment ";
			sql += " WHERE board_num = ? ";
			sql += " ORDER BY re_ref ASC, re_seq ASC ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CommentVO commentVO = new CommentVO();
				commentVO.setCommentNum(rs.getInt("comment_num"));
				commentVO.setBoardNum(rs.getInt("board_num"));
				commentVO.setId(rs.getString("id"));
				commentVO.setContent(rs.getString("content"));
				commentVO.setRegDate(rs.getTimestamp("reg_date"));
				commentVO.setReRef(rs.getInt("re_ref"));
				commentVO.setReLev(rs.getInt("re_lev"));
				commentVO.setReSeq(rs.getInt("re_seq"));

				list.add(commentVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}

		return list;
	} // getCommentsByBoardNum

	// 새글로 정할 글 번호
	public int getNextNum() {
		int num = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT IFNULL(MAX(comment_num),0) + 1 AS nextnum ";
			sql += " FROM comment ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("nextnum");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return num;
	} // getNextNum

	public void addComment(CommentVO commentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO comment(comment_num, board_num,id,content, reg_date, re_ref,re_lev,re_seq) ";
			sql += " VALUES (?,?,?,?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentVO.getCommentNum());
			pstmt.setInt(2, commentVO.getBoardNum());			
			pstmt.setString(3, commentVO.getId());
			pstmt.setString(4, commentVO.getContent());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			pstmt.setInt(6, commentVO.getReRef());
			pstmt.setInt(7, commentVO.getReLev());
			pstmt.setInt(8, commentVO.getReSeq());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // addComment

	public void updateComment(CommentVO commentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "UPDATE comment ";
			sql += " SET content = ? ";
			sql += " WHERE comment_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, commentVO.getContent());
			pstmt.setInt(2, commentVO.getCommentNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // updateComment


	public void updateReSeqAndAddReply(CommentVO commentVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();
			// 수동커밋으로 변경
			con.setAutoCommit(false);

			// 답글을 다는 대상글과 같은 글 그룹 내에서
			// 답글을 다는 대상들의 그룹내 순번보다 큰 클들의 순번을 1씩 증가
			String sql = "";
			sql += " UPDATE comment ";
			sql += " SET re_seq = re_seq + 1  ";
			sql += " WHERE re_ref = ? ";
			sql += " AND re_seq > ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentVO.getReRef());
			pstmt.setInt(2, commentVO.getReSeq());

			pstmt.executeUpdate();
			pstmt.close();

			sql = "";
			sql += "INSERT INTO comment(comment_num, board_num,id,content,reg_date,re_ref,re_lev,re_seq) ";
			sql += " VALUES (?,?,?,?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentVO.getCommentNum());
			pstmt.setInt(2, commentVO.getBoardNum());			
			pstmt.setString(3, commentVO.getId());
			pstmt.setString(4, commentVO.getContent());
			pstmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			// re컬럼값은 insert될 답글정보로 수정하기
			pstmt.setInt(6, commentVO.getReRef()); // 글 그룹은 동일
			pstmt.setInt(7, commentVO.getReLev() + 1); // 답글의 레벨 = 답글을 달 대상글의 레벨 + 1
			pstmt.setInt(8, commentVO.getReSeq() + 1); // 답글의 순번 = 답글을 달 대상글의 순번 + 1

			pstmt.executeUpdate();
			
			con.commit();// 수동으로 커밋하기
			
			con.setAutoCommit(true);// 오토커밋 원상태로 돌려놓기

		} catch (Exception e) {
			e.printStackTrace();
			
			try {
				//예외 발생 시 롤백
				con.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // updateReSeqAndAddReply
}

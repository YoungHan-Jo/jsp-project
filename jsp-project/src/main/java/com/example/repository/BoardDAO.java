package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.Criteria;

public class BoardDAO {

	// =====================싱글톤 클래스 설계 =========================
	private static BoardDAO instance;

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	private BoardDAO() {
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

	public void deleteByBoardNum(int boardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "DELETE FROM board ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // deleteById

	public int getCountAll() {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM board ";

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

	public int getCountByCriteria(Criteria cri) {

		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT COUNT(*) AS cnt ";
			sql += " FROM board ";
			if (cri.getTab().length() > 0) {
				sql += " WHERE tab = ? ";
			}

			pstmt = con.prepareStatement(sql);
			if (cri.getTab().length() > 0) {
				pstmt.setString(1, cri.getTab());
			}

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
	} // getCountByCriteria

	public BoardVO getBoardByBoardNum(int boardNum) {

		BoardVO boardVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM board ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				boardVO = new BoardVO();
				boardVO.setBoardNum(rs.getInt("board_num"));
				boardVO.setTab(rs.getString("tab"));
				boardVO.setMemberId(rs.getString("member_id"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setViewCount(rs.getInt("view_count"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReRef(rs.getInt("re_ref"));
				boardVO.setReLev(rs.getInt("re_lev"));
				boardVO.setReSeq(rs.getInt("re_seq"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return boardVO;
	} // getBoardByBoardNum

	public List<BoardVO> getBoards() {

		List<BoardVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM board ";
			sql += " ORDER BY re_ref DESC, re_seq ASC ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setBoardNum(rs.getInt("board_num"));
				boardVO.setTab(rs.getString("tab"));
				boardVO.setMemberId(rs.getString("member_id"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setViewCount(rs.getInt("view_count"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReRef(rs.getInt("re_ref"));
				boardVO.setReLev(rs.getInt("re_lev"));
				boardVO.setReSeq(rs.getInt("re_seq"));

				list.add(boardVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return list;
	} // getBoards

	public List<BoardVO> getBoards(Criteria cri) {

		List<BoardVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int startRow = (cri.getPageNum() - 1) * cri.getAmount();

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM board ";
			if (cri.getTab().equals("") == false && cri.getTab() != null) { // tab 이 공백이 아니고 널값이 아닐 때
				sql += " WHERE tab = ? ";
			}
			sql += " ORDER BY re_ref DESC, re_seq ASC ";
			sql += " LIMIT ?,? ";

			pstmt = con.prepareStatement(sql);
			if (cri.getTab().equals("") == false && cri.getTab() != null) { // tab 이 공백이 아니고 널값이 아닐 때
				pstmt.setString(1, cri.getTab());
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, cri.getAmount());
			} else {
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, cri.getAmount());
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setBoardNum(rs.getInt("board_num"));
				boardVO.setTab(rs.getString("tab"));
				boardVO.setMemberId(rs.getString("member_id"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setViewCount(rs.getInt("view_count"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReRef(rs.getInt("re_ref"));
				boardVO.setReLev(rs.getInt("re_lev"));
				boardVO.setReSeq(rs.getInt("re_seq"));

				list.add(boardVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return list;
	} // getBoards

	public List<BoardVO> getBoardsByMemberId(String id) {

		List<BoardVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT * ";
			sql += " FROM board ";
			sql += " WHERE member_id = ? ";
			sql += " ORDER BY reg_date DESC ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setBoardNum(rs.getInt("board_num"));
				boardVO.setTab(rs.getString("tab"));
				boardVO.setMemberId(rs.getString("member_id"));
				boardVO.setSubject(rs.getString("subject"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setViewCount(rs.getInt("view_count"));
				boardVO.setRegDate(rs.getTimestamp("reg_date"));
				boardVO.setReRef(rs.getInt("re_ref"));
				boardVO.setReLev(rs.getInt("re_lev"));
				boardVO.setReSeq(rs.getInt("re_seq"));

				list.add(boardVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

		return list;
	} // getBoardsByMemberId

	// 새글로 정할 글 번호
	public int getNextNum() {
		int num = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "SELECT IFNULL(MAX(board_num),0) + 1 AS nextnum ";
			sql += " FROM board ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("nextnum");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return num;
	} // getNextNum

	public void addBoard(BoardVO boardVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "INSERT INTO board(board_num,tab,member_id,subject,content,view_count,reg_date,re_ref,re_lev,re_seq) ";
			sql += " VALUES (?,?,?,?,?,?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardVO.getBoardNum());
			pstmt.setString(2, boardVO.getTab());
			pstmt.setString(3, boardVO.getMemberId());
			pstmt.setString(4, boardVO.getSubject());
			pstmt.setString(5, boardVO.getContent());
			pstmt.setInt(6, boardVO.getViewCount());
			pstmt.setTimestamp(7, boardVO.getRegDate());
			pstmt.setInt(8, boardVO.getReRef());
			pstmt.setInt(9, boardVO.getReLev());
			pstmt.setInt(10, boardVO.getReSeq());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // addBoard

	public void updateBoard(BoardVO boardVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "UPDATE board ";
			sql += " SET tab = ? ,subject = ?, content = ? ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardVO.getTab());
			pstmt.setString(2, boardVO.getSubject());
			pstmt.setString(3, boardVO.getContent());
			pstmt.setInt(4, boardVO.getBoardNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // addBoard

	public void updateViewCount(int boardNum) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql += "UPDATE board ";
			sql += " SET view_count = view_count + 1 ";
			sql += " WHERE board_num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}

	} // updateViewCount

	public void updateReSeqAndAddReply(BoardVO boardVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();
			// 수동커밋으로 변경
			con.setAutoCommit(false);

			// 답글을 다는 대상글과 같은 글 그룹 내에서
			// 답글을 다는 대상들의 그룹내 순번보다 큰 클들의 순번을 1씩 증가
			String sql = "";
			sql += " UPDATE board ";
			sql += " SET re_seq = re_seq + 1  ";
			sql += " WHERE re_ref = ? ";
			sql += " AND re_seq > ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardVO.getReRef());
			pstmt.setInt(2, boardVO.getReSeq());

			pstmt.executeUpdate();
			pstmt.close();

			sql = "";
			sql += "INSERT INTO board(board_num,tab,member_id,subject,content,view_count,reg_date,re_ref,re_lev,re_seq) ";
			sql += " VALUES (?,?,?,?,?,?,?,?,?,?) ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardVO.getBoardNum());
			pstmt.setString(2, boardVO.getTab());
			pstmt.setString(3, boardVO.getMemberId());
			pstmt.setString(4, boardVO.getSubject());
			pstmt.setString(5, boardVO.getContent());
			pstmt.setInt(6, boardVO.getViewCount());
			pstmt.setTimestamp(7, boardVO.getRegDate());
			// re컬럼값은 insert될 답글정보로 수정하기
			pstmt.setInt(8, boardVO.getReRef()); // 글 그룹은 동일
			pstmt.setInt(9, boardVO.getReLev() + 1); // 답글의 레벨 = 답글을 달 대상글의 레벨 + 1
			pstmt.setInt(10, boardVO.getReSeq() + 1); // 답글의 순번 = 답글을 달 대상글의 순번 + 1

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

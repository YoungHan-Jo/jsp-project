package com.example.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class JdbcUtils {

	public static final String URL = "jdbc:mysql://localhost:3306/jspproject?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
	public static final String USER = "jspproject";
	public static final String PASSWD = "1234";

	public static Connection getConnection() throws Exception {

		Connection con = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
//
		con = DriverManager.getConnection(URL, USER, PASSWD);
		
//		====== 커넥션 풀링으로 준비된 커넥션 객체들 중에서 한개를 빌려오기 ======
//		Context context = new InitialContext();
//		DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/jspproject");
//		con = ds.getConnection(); // 커넥션풀에서 커넥션객체 한개 빌려오기

		return con;
	}

	public static void close(Connection con, PreparedStatement pstmt) {
		close(con, pstmt, null);
	}

	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try { // catch 는
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	} // close()
}

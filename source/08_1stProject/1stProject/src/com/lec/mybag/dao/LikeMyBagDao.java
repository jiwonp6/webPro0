package com.lec.mybag.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.mybag.dto.LikemyBagDto;
import com.lec.mybag.dto.MyBagBoardDto;
import com.lec.mybag.dto.QnaBoardDto;

public class LikeMyBagDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static LikeMyBagDao instance = new LikeMyBagDao();

	public static LikeMyBagDao getInstance() {
		return instance;
	}

	private LikeMyBagDao() {
	}

	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}

	//(1) 좋아요 누르기
	private void LikeUp(String mId, int bId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO myBAGBOARD " + " (lID, mID, bId, lRDATE)" 
				+ "		VALUES (LIKE_SEQ.NEXTVAL, ?, ?, SYSDATE)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setInt(2, bId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}
	//(2) 좋아요 취소하기
	private void DisLike(String mId, int bId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM LIKEmyBAG WHERE mID=? AND bID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mId);
			pstmt.setInt(1, bId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}
	//(3) 회원이 좋아요 누른 글만 가져오기
	public ArrayList<MyBagBoardDto> likeListBoard(int startRow, int endRow) {
		ArrayList<MyBagBoardDto> lDtos = new ArrayList<MyBagBoardDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM " + " (SELECT ROWNUM RN, A.* FROM " + " (SELECT B.* FROM myBAGBOARD B, LIKEmyBAG L"
				+ " WHERE B.MID=L.MID AND B.BID=L.BID ORDER BY lRDATE DESC) A)" + " WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int bId = rs.getInt("bId");
				String mId = rs.getString("mId");
				String bName = rs.getString("bName");
				String bContent = rs.getString("bContent");
				String bFilename = rs.getString("qFilename");
				int bHit = rs.getInt("bHit");
				Timestamp bRdate = rs.getTimestamp("bRDate");
				String bIp = rs.getString("bIp");
				lDtos.add(new MyBagBoardDto(bId, mId, bName, bContent, bFilename, bHit, bRdate, bIp));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return lDtos;
	}
}

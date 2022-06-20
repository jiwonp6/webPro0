package com.lec.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.dto.Mvc_MemberDto;

public class Mvc_MemberDao {
	public final static int SUCCESS = 1;
	public final static int FAIL = 0;
	public final static int NONEXISTENT = 1;
	public final static int EXISTENT = 0;
	private DataSource ds;	//null값으로 초기화 돼있음
	// 싱글톤
	private static Mvc_MemberDao instance = new Mvc_MemberDao();
	public static Mvc_MemberDao getInstance() {
		return instance;
	}
	private Mvc_MemberDao() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	//(1)로그인
	public int login(String mid, String mpw) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM MVC_MEMBER WHERE MID = ? AND MPW = ?";
		try {
			conn= ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = SUCCESS;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
			
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return result;
	}
	//(2)MID로 DTO 가져오기(로그인 성공시 SESSION에 넣기 위함)
	public Mvc_MemberDto modifyView_replyView(String mid) {
		Mvc_MemberDto dto = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM MVC_MEMBER WHERE MID = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String mpw = rs.getString("mpw");
				String mname = rs.getString("mname");
				String memail = rs.getString("memail");
				String mphoto = rs.getString("mphoto");
				Date mbirth = rs.getDate("mbirth");
				String maddress = rs.getString("maddress");
				Date mrdate = rs.getDate("mrdate");
				dto = new Mvc_MemberDto(mid, mpw, mname, memail, mphoto, mbirth, maddress, mrdate);
			}
			System.out.println("id로 가져온 dto : "+dto);
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return dto;
	}
	//(3)회원 ID 중복체크
	public int IdChk(String mid) {
		int result = EXISTENT;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT mID FROM MVC_MEMBER WHERE MID=?";
		try {
			conn= ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				result = NONEXISTENT;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return result;
	}
	//(4)회원가입
	public int insertMember(String mid, String mpw, String mname, String memail, String mphoto, Date mbirth, String maddress) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO MVC_MEMBER (mID, mPW, mNAME, mEMAIL, mPHOTO, mBIRTH, mADDRESS)" + 
				"    VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			pstmt.setString(3, mname);
			pstmt.setString(4, memail);
			pstmt.setString(5, mphoto);
			pstmt.setDate(6, mbirth);
			pstmt.setString(7, maddress);
			result = pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return result;
	}
	//(5)회원정보 수정
	public int updateMember(String mid, String mpw, String mname, String memail, String mphoto, Date mbirth, String maddress) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MVC_MEMBER" + 
				"    SET mPW = ?," + 
				"        mNAME = ?," + 
				"        mEMAIL = ?," + 
				"        mPHOTO = ?," + 
				"        mBIRTH = ?," + 
				"        mADDRESS = ?" + 
				"    WHERE mID = ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mpw);
			pstmt.setString(2, mname);
			pstmt.setString(3, memail);
			pstmt.setString(4, mphoto);
			pstmt.setDate(5, mbirth);
			pstmt.setString(6, maddress);
			pstmt.setString(7, mid);
			result = pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return result;
	}
	//(6)회원리스트(TOP-N구문)
	public ArrayList<Mvc_MemberDto> listMember(int startRow, int endRow){
		ArrayList<Mvc_MemberDto> dtos = new ArrayList<Mvc_MemberDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM MVC_MEMBER ORDER BY mRDATE DESC) A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String mid = rs.getString("mid");
				String mpw = rs.getString("mpw");
				String mname = rs.getString("mname");
				String memail = rs.getString("memail");
				String mphoto = rs.getString("mphoto");
				Date mbirth = rs.getDate("mbirth");
				String maddress = rs.getString("maddress");
				Date mrdate = rs.getDate("mrdate");
				dtos.add(new Mvc_MemberDto(mid, mpw, mname, memail, mphoto, mbirth, maddress, mrdate));
			}
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return dtos;
	}
	//(7)회원수
	public int getMemberTotalCnt() {
		int totalCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM MVC_MEMBER";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totalCnt = rs.getInt("CNT");
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs   !=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return totalCnt;
	}
	//회원탈퇴
	public int delete(String mid) {
		int result = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM MVC_MEMBER WHERE mid=?";
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null)  conn.close();
			}catch (SQLException e) {}
		}
		return result;
	}
}

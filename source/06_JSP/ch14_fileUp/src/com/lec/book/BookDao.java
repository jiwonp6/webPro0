package com.lec.book;

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

import org.apache.catalina.filters.AddDefaultCharsetFilter;

public class BookDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	//싱글톤
	private static BookDao instance = new BookDao();
	public static BookDao getInstance() {
		return instance;
	}
	private BookDao() { }
	//Connection 객체 얻어오는 함수
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	//1. 책 등록
	public int insertBook(BookDto book) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO BOOK (bID, bTITLE, bPRICE, bIMAGE1, bIMAGE2, bCONTENT, bDISCOUNT)" + 
				"    VALUES (BOOK_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, book.getBtitle());
			pstmt.setInt(2, book.getBprice());
			pstmt.setString(3, book.getBimage1());
			pstmt.setString(4, book.getBimage2());
			pstmt.setString(5, book.getBcontent());
			pstmt.setInt(6, book.getBdiscount());
			result = pstmt.executeUpdate();
			System.out.println("책등록성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage()+book);
		} finally {
			try {
				if(pstmt!=null)	pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) { }
		}
		return result;
	}
	//2. 책 목록(전체 LIST) -- 신간도서 순으로 출력
	public ArrayList<BookDto> listBook() {
		ArrayList<BookDto> books = new ArrayList<BookDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOOK ORDER BY bRDATE DESC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				/*  ※ 이 방법도 있음
				 * BookDto book = new BookDto(); book.setBid(rs.getInt("bid"));
				 * book.setBtitle(rs.getString("btitle"));
				 * . . .
				 * books.add(book);
				 */
				int bid = rs.getInt("bid");
				String btitle = rs.getString("btitle");
				int bprice = rs.getInt("bprice");
				String bimage1 = rs.getString("bimage1");
				String bimage2 = rs.getString("bimage2");
				String bcontent = rs.getString("bcontent");
				int bdiscount = rs.getInt("bdiscount");
				Timestamp brdate = rs.getTimestamp("brdate");
				books.add(new BookDto(bid, btitle, bprice, bimage1, bimage2, bcontent, bdiscount, brdate));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) { }
		}
		return books;
	}
	//3. 책 목록(startRow ~ endRow)
	public ArrayList<BookDto> listBook(int startRow, int endRow) {
		ArrayList<BookDto> books = new ArrayList<BookDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * " + 
				"    FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM BOOK ORDER BY bRDATE DESC) A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int bid = rs.getInt("bid");
				String btitle = rs.getString("btitle");
				int bprice = rs.getInt("bprice");
				String bimage1 = rs.getString("bimage1");
				String bimage2 = rs.getString("bimage2");
				String bcontent = rs.getString("bcontent");
				int bdiscount = rs.getInt("bdiscount");
				Timestamp brdate = rs.getTimestamp("brdate");
				books.add(new BookDto(bid, btitle, bprice, bimage1, bimage2, bcontent, bdiscount, brdate));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) { }
		}
		return books;
	}
	//4. 등록된 책 개수
	public int getBookTotCnt() {
		int bookTotalCnt = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) CNT FROM BOOK";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			bookTotalCnt = rs.getInt("cnt");
			// = bookTotalCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) { }
		}
		return bookTotalCnt;
	}
	//5. 책 상세보기(bID로 dto가져오기)
	public BookDto getBook(int bid) {
		BookDto book = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOOK" + 
				"    WHERE bID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String btitle = rs.getString("btitle");
				int bprice = rs.getInt("bprice");
				String bimage1 = rs.getString("bimage1");
				String bimage2 = rs.getString("bimage2");
				String bcontent = rs.getString("bcontent");
				int bdiscount = rs.getInt("bdiscount");
				Timestamp brdate = rs.getTimestamp("brdate");
				book = new BookDto(bid, btitle, bprice, bimage1, bimage2, bcontent, bdiscount, brdate);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) { }
		}
		return book;
	}
}

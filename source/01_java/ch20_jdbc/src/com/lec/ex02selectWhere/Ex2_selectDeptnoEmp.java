package com.lec.ex02selectWhere;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

/* 1. 사용자에게 부서번호 입력받아
 * 	1-1. 해당부서번호가 존재할 경우 : 해당부서정보와 해당부서 사원을 출력
 * 	1-2. 해당부서번호가 존재하지 않을 경우 : 없다고 출력
 */
public class Ex2_selectDeptnoEmp {
	public static void main(String[] args) {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Scanner sc = new Scanner(System.in);
		System.out.println("원하는 부서번호는 ?");
		int deptno = sc.nextInt();
		String sql1 = "SELECT * FROM DEPT WHERE DEPTNO="+deptno;
		String sql2 = " SELECT W.EMPNO, W.ENAME WORKER, W.SAL, M.ENAME MANAGER" + 
				"	FROM EMP W, EMP M\r\n" + 
				"	WHERE W.MGR = M.EMPNO AND W.DEPTNO = "+deptno;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, "scott", "tiger");
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql1);
			if(rs.next()) {	//해당 부서번호가 있는 경우
				System.out.println("부서번호 : " + deptno);
				System.out.println("부서이름 : " + rs.getString("dname"));
				System.out.println("부서위치 : " + rs.getString("loc"));
				rs.close();	// sql2출력하기위해 사용전 한 번 닫는다. 
				rs = stmt.executeQuery(sql2);	//empno, ename, sal, manager
				if(rs.next()) {
					System.out.println("사번\t이름\t급여\t상사명");
					do {
						int empno = rs.getInt("empno");
						String worker = rs.getString("worker");
						int sal = rs.getInt("sal");
						String manager = rs.getString("manager");
						System.out.println(empno + "\t"+worker + "\t"+sal + "\t"+manager);
						//출력
					}while(rs.next());
				}else {
					System.out.println(deptno + "번 부서 사원은 없습니다.");
				}
			}else {	//해당부서가 없는 경우
				System.out.println(deptno + "번 부서는 유효하지 않습니다.");
			}
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {}
		}
	}
}

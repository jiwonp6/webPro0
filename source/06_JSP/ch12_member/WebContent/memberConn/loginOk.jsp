<%@page import="com.lec.member.MemberDao_connPool"%>
<%@page import="com.lec.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="<%=conPath %>/css/style.css" rel="stylesheet">
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	MemberDao_connPool mDao = new MemberDao_connPool();
	int result = mDao.loginCheck(id,pw);
	if(result==MemberDao_connPool.LOGIN_SUCCESS){	//로그인 성공
		MemberDto member = mDao.getMember(id);
		session.setAttribute("member", member);
		response.sendRedirect("main.jsp");
	}else if(result==MemberDao_connPool.LOGIN_FAIL_PW){	//비밀번호 오류
	%>
		<script>
			alert('비밀번호를 확인하세요');
			history.back();
		</script>
	<%
	}else{	//아이디 오류
	%>
		<script>
			alert('존재하지 않는 아이디입니다');
			history.go(-1);
		</script>
	<%	
	}
	%>
</body>
</html>
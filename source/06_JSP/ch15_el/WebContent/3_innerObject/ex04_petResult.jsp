<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="../css/style.css" rel="stylesheet">
</head>
<body>
	<h3>I D : ${param.id }</h3>
	<h3>
		키우는 동물은 ${paramValues.pets[0] }
				  ${paramValues.pets[1] }
				  ${paramValues.pets[2] }
				  ${paramValues.pets[3] }
		${empty paramValues.pets ? "없습니다" : "입니다" }
	</h3>
	<%-- <%
	String id = request.getParameter("id");
	String[] pets = request.getParameterValues("pets");
	out.println("<h3>ID : " + id + "</h3>");
	out.println("<h3> 키우는 동물은 ");
	if(pets!=null){
		for(String pet : pets){
			out.println(pet+" ");
		}
			out.println("입니다");
	}else{
		out.println("없습니다");
	}
	out.println("</h3>");
	%> --%>
</body>
</html>
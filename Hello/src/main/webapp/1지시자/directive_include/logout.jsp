<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// 세션무효화
		session.invalidate();
		// 세션아이디 새로 발급
		request.getSession(true);
		// 메인페이지 연결
		response.sendRedirect("gogreen.jsp");
	%>
</body>
</html>
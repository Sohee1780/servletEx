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
	// 세션의 기본 유효시간은 30분
	// 세션 무효화
	session.invalidate();
%>
<h2>페이지 이동된 후 session영역의 속성 읽기</h2>
<a href="SessionLocation.jsp">SessionLocation.jsp 바로가기</a><br>
<a href="SessionInvalidate.jsp">SessionInvalidate.jsp 바로가기</a>
</body>
</html>
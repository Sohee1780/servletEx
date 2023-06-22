<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=request.getAttribute("message") %><br>
	${requestScope.message }<br>
	<!-- mapping 방법
		 1. web.xml에 기술
		 2. 어노테이션 이용
	-->
	
	
	<!-- ./ : 현재경로 -->
	<!-- /13서블릿/HelloServlet.do -->
	<a href="./HelloServlet.do">HelloServlet.do바로가기</a><br>
	<a href="${pageContext.request.contextPath }/13서블릿/AnnotationMapping.do">AnnotationMapping.do바로가기</a><br>
</body>
</html>
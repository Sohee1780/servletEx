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
	
		// name속성의 값을 매개값으로 넘겨주면 value속성의 값을 반환합니다.
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		
		if("abc".equals(id) && "123".equals(pw)){
			// out.write(""); <- 내장객체를 이용한 출력
			response.sendRedirect("login.jsp?name="+id);
		}else{
			response.sendRedirect("login.jsp?loginErr=Y");
		}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	/*
	response객체는 응답헤더에 정보를 추가하는 기능을 제공
		add...() : 응답 헤더 추가
		set...() : 응답 헤더 수정
	*/
	String add_date = request.getParameter("add_date");
	String add_int = request.getParameter("add_int");
	String add_str = request.getParameter("add_str");
	
	response.addHeader("str", add_str);
	// getParameter()는 String타입을 반환하므로
	// 숫자나 날짜타입인 경우 형변환이 필요함
	response.addIntHeader("int", Integer.parseInt(add_int));
	/*
		문자열을 날짜 형식으로 변환 SimpleDateFormat사용
		2021-10-25 09:00
		yyyy-MM-dd HH:mm <- 포맷형식 설정
	*/
	SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	response.addDateHeader("date", s.parse(add_date).getTime());

	Collection<String> headerNames = response.getHeaderNames();
	for(String hName : headerNames){
		String hValue = response.getHeader(hName);
%>
	<li><%= hName %> : <%= hValue %></li>
<%
	}
%>
</body>
</html>
<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
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
	String num = request.getParameter("num");
	BoardDao dao = new BoardDao();
	
	int res = dao.delete(num);
	
	if(res>0){
		// 삭제 성공
		JSFunction.alertLocation("삭제 되었습니다.", "Board.jsp", out);
	}else {
		// 삭제 실패
		JSFunction.alerBack("삭제 실패 : 관리자에게 문의해주세요.", out);
	}
	
%>
</body>
</html>
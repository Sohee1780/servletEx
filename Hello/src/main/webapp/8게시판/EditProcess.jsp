<%@page import="common.JSFunction"%>
<%@page import="dao.BoardDao"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../6세션/isLogin.jsp" %>
<%

	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String num = request.getParameter("num");
	out.print(num);
	String id = "t";//session.getAttribute("UserId").toString();
	Board board = new Board(num, title, content, id, "", "");
	BoardDao dao = new BoardDao();
	
	int res = dao.update(board);
	
	System.out.println(num);
	if(res>0){
		JSFunction.alertLocation("수정되었습니다.", "View.jsp?num="+num, out);
	}else {
		//JSFunction.alerBack("수정작업 실패", out);
	}
%>
</body>
</html>
<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.NewBoaderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 세션에 아이디가 널이면 로그인 페이지로 이동 -->
<%@ include file="../6세션/isLogin.jsp" %>
<%@ include file="../6세션/Link.jsp" %>
<%
	/*
		getParameter()메서드의 경우 String타입을 리턴하는반면,
		getAttribute()는 Object 타입을 리턴하기 때문에 주로 빈 객체나 다른 클래스를 받아올때 사용된다.
		또한, getParameter()는 웹브라우저에서 전송받은 request영역의 값을 읽어오고
		getAttribute()의 경우 setAttribute()속성을 통한 설정이 없으면 무조건 null값을 리턴한다.
	*/
	// 한글 깨짐 처리
	request.setCharacterEncoding("utf-8");

	NewBoaderDao newBoardDao = new NewBoaderDao();
	Board board = new Board();
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = (String)session.getAttribute("UserId");
	
	board.setTitle(title);
	board.setContent(content);
	board.setId(id);


	int res = newBoardDao.insert(board);
	
	if(res>0){
		// 등록 성공
		JSFunction.alertLocation("new list에 게시글 등록 성공", "List.jsp", out);
	}else {
		// 등록 실패
		JSFunction.alerBack("게시글 등록 오류 발생 관리자에게 문의해주세요", out);
	}
	
%>
</body>
</html>
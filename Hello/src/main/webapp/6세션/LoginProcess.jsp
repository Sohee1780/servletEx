<%@page import="java.util.Iterator"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
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
	// request.getParameter("user_id") 폼요소의 값을 읽어오고 String을 반환
	String id = request.getParameter("user_id"); 
	String pw = request.getParameter("user_pw");
	
	MemberDao dao = new MemberDao();
	Member member = dao.login(id, pw);

	if(member != null) {
		// 로그인 성공 -> 세션에 member객체를 저장
		session.setAttribute("UserId", member.getId());
		session.setAttribute("member", member);
		
		response.sendRedirect("Board.jsp");
	}else {
		// 로그인 실패 -> loginForm페이지로 이동, 오류메세지 출력
		// request영역에 값을 저장함 어떤타입을 저장해도 object타입으로 저장됨 사용할때 형변환 필요
		request.setAttribute("LoginErrMsg", "아이디, 비밀번호가 일치하지 않습니다.");
		// getRequestDispatcher("LoginForm.jsp").forward(request, response) 사용해서 보내줘야 저장한 어트리뷰트가 넘어감
		request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
		// response.sendRedirect("LoginForm.jsp?LoginErrMsg=아이디, 비밀번호가 일치하지 않습니다.");
	}
%>
</body>
</html>
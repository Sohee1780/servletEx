<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
<%@page import="util.CookieManager"%>
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
		
		// 아이디 저장 체크박스
		String saveYN = request.getParameter("save_check");
		out.print("saveYN : "+saveYN+"<br>");
		
		MemberDao dao = new MemberDao();
		Member member = dao.login(id,pw);
		
		// 아이디 저장하기 체크박스에 체크가 되었다면
		// 쿠키에 아이디를 저장합니다.
		// userId, 사용자 아이디
		if("Y".equals(saveYN)){
			// CookieManager를 이용하여 쿠키를 생성후 응답객체에 담아준다.
			CookieManager.makeCookie(response, "userId", id, 3600);
			
			/*
			// 쿠키 생성하기(userId, 사용자아이디)
			Cookie cookie = new Cookie("userId", id);
			// 유지시간 설정(초단위로 지정)
			cookie.setMaxAge(3600);
			// 응답객체에 담기
			response.addCookie(cookie);
			*/
		}
		
		// DB 조회 결과 id/pw가 일치하는 회원이 있으면 로그인 성공
		if(member != null && !"".equals(member.getName())){
			// out.write(""); <- 내장객체를 이용한 출력
			response.sendRedirect("login.jsp?name="+id);
		}else{
			// response.sendRedirect("login.jsp?loginErr=Y");
		}
	%>
</body>
</html>
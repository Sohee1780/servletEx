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
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		String saveYN = request.getParameter("save_check");
		
		// 체크박스가 체크되었을경우, 아이디를 쿠키에 저장
		if("Y".equals(saveYN)){
			out.print("쿠키생성");
			CookieManager.makeCookie(response, "userId", id, 60*60*24*7);
		} else{
			CookieManager.deleteCookie(response, "userId");
		}
		
		if("abc".equals(id) && "123".equals(pw)){
			// 로그인 성공
			// 세션영역에 Id 저장
			session.setAttribute("id", id);
			response.sendRedirect("gogreen.jsp");
		}else{
			// 로그인 실패
			response.sendRedirect("gogreen.jsp?loginErr=Y");
		}
	%>
</body>
</html>
<%@page import="util.CookieManager"%>
<%@page import="el.MyElClass"%>
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
	// 객체 생성
	MyElClass myEl = new MyElClass();
	// 페이지 영역에 저장
	pageContext.setAttribute("myEl", myEl);
	// EL에는 response가 존재하지 않아서 저장해줘야함
	pageContext.setAttribute("response", response);
	
%>
<h3>영역에 저장 후 메서드 호출하기</h3>
	001129-3000000 => ${myEl.getGender("001129-3000000")}<br>
	001129-2000000 => ${myEl.getGender("001129-2000000")}<br>
	
<h3>정적메서드 호출하기</h3>
	${myEl.showGugudan(7) }
<h3>정적메서드 호출하기 - 쿠키생성</h3>
<!-- 처음 실행시 쿠키값이 나오지 않고 새로고침해야 쿠키값이 나옴
	  - 쿠키는 헤더영역에 저장해서 넘겨주는데 처음 실행했을때는 내가 가진 쿠키만 넘겨줌
	  그래서 요청을 하게되면 쿠키를 생성해서 헤더에 담아 보내주고 리스폰스받음
-->
${CookieManager.makeCookie(response, "ELCookie", "EL좋아요", 10)}
${cookie.ELCookie.value }<br>

<h3>메서드 호출하기</h3>
${"123-123".replace("-", "") }

</body>
</html>
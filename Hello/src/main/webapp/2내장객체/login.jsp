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
		// 로그인 실패
		String err = request.getParameter("loginErr");
		if("Y".equals(err)){
			out.print("아이디/비밀번호를 확인해주세요");
		}
	%>

	<%
		// 로그인 성공 
		String name = request.getParameter("name");
		if(name!=null && !"".equals(name)){
			out.print("<h1>"+name+"님 환영합니다.</h1>");
		}else{
	%>	
	<!-- form : 페이지를 요청하는 태그 -->
	<form action="loginAction.jsp" method="post">

		<div class='loginbox'>
		    <div id='login'>
		        <input type="text" name="userid" id="userid" placeholder='ID를 입력해주세요.' required="required">
		        <input type="password" name="userpw" id="userpw" placeholder='PW를 입력해주세요.' required="required">
		    </div>
		    <div id='button'>
		    <input type="submit" value="로그인">
		    </div>
		</div>
		
		<div id='info'>
		    <a href="">회원가입</a>
		    <a href="">ID찾기</a>
		    <a href="">PW찾기</a>
		</div>
	</form>
	<% 
		}
	%>	

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
	import : 외부파일을 현재 위치에 삽입
	
		url : 외부파일 파일 경로
		scope : 영역
		var : 변수명
				변수명을 사용하면 선언과 삽입을 분리할 수 있습니다.
		
	외부파일에 매개변수 넣기
		- url의 쿼리스트링으로 전달하기
		- c:param 태그를 이용하기
	-->
	<c:import url="/6세션/Link.jsp" var="link">
		<c:param name="param1" value="헤더영역"></c:param>
	</c:import>
	
	<h4>다른 문서 삽입하기</h4>
	${link }
	
	<h4>iframe을 이용한 외부자원 삽입하기</h4>
	<iframe src="../inc/GoldPage.jsp" style="width:100%; height:100px;"></iframe>

	<c:set var="iTag">
		i 태그는 <i>기울임</i>을 표현합니다.
	</c:set>
	
	<h4>EL출력</h4>
	${iTag }
	<h4>out 태그 기본사용</h4>
	<c:out value="${iTag }"></c:out>
	
	<h4>escapeXml</h4>
	<c:out value="${iTag }" escapeXml="false"/>
	
	<h4>default 속성</h4>
	<c:out value="${para.name }" default="이름 없음"/>
	<c:out value="" default="빈 문자열도 값입니다."/>
	
	<h4>redirect</h4>

	<%-- 퍼센트 주석 --%>
	<!-- forward는 하나의 요청에 의해 서버가 다른 페이지를 호출해줌 -->
	<!-- 
		redirect는 하나의 요청으로 서버가 다른 페이지를 호출하라고 알려줌
		그 요청을 받아 다시 다른페이지를 호출함 요청이 두번 일어나서 리퀘스트 영역이 공유되지 않음 
		그래서 밑에 request영역에 requestVar변수를 저장했지만 값이 나오지 않는다
	-->
	<c:set var="requestVar" value="리퀘스트영역!" scope="request"></c:set>
	<c:redirect url="/11JSTL/inc/OtherPage.jsp">
		<c:param name="param1" value="출판사"></c:param>
		<c:param name="param2" value="골든래빗"></c:param>
	</c:redirect>
	
</body>
</html>
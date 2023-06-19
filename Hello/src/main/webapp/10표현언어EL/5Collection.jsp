<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dto.Member"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
	// 리스트 생성(object로 지정 -> 어떤 타입이든지 저장 가능)
	List<Object> aList = new ArrayList<Object>();
	aList.add("청해진");
	aList.add(new Member("test","","하니","2023-06-19"));
	
	// 페이지 영역에 리스트 객체 저장
	pageContext.setAttribute("aList", aList);
%>

<h2>List 컬렉션</h2>
<ul>
	<!-- 영역을 지정하지 않았지만 페이지영역에 저장된 aList가 출력됨 -->
	<li> <p>0번째요소 :$ {aList[0] }</p></li>
	
	<!-- 객체의 주소갑 반환 -->
	<li><p>1번째요소 : ${aList[1] }</p>
	<p>id : ${aList[1].id }</p>
	<p>name : ${aList[1].name }</p></li>
	
	<!-- 2번째요소는 없지만 예외가 발생하지 않고 출력되지 않음 -->
	<li><p>2번째요소 : ${aList[2] }</p></li>
</ul>

<h2>Map 컬렉션</h2>
<%
	Map<String, String> map=new HashMap<String, String>();
	// key, value
	map.put("한글","훈민정음");
	map.put("Eng","English");
	
	pageContext.setAttribute("map", map);
%>
<ul>
	<!-- map은 key값으로 접근 -->
	<li><p>한글 : ${map['한글'] }</p>
		<p>한글 : ${map["한글"] }</p>
		<!-- 한글은 .으로 접근 불가 -->
		<!-- el코드 주석처리 방법 : 앞에 \를 붙여준다 -->
		<p>한글 : \${map.한글 }</p>
		<p><%=map.get("한글") %></p>
	</li>
	<li>
		<p>Eng : ${map.Eng }</p>
		<p>Eng : ${map['Eng'] }</p>
		<p>Eng : ${map["Eng"] }</p>
		<p><%=map.get("Eng") %></p>
	</li>
</ul>
</body>
</html>
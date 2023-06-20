<%@page import="dto.pageDto"%>
<%@page import="dto.Criteria"%>
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
<script>
	function go(page){
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
</script>
 
<%

	if(pageDto.isPrev()){
		// 이전 페이지 블럭
		out.print("<input type='button' value='<<' onclick='go(1)'>");
		out.print("<input type='button' value='<' onclick='go("+(pageDto.getStartNo()-1)+")'>");
	}	
	
	for(int i=pageDto.getStartNo(); i<=pageDto.getEndNo(); i++){
		out.print("<input type='button' class='b' value='"+i+"' onclick='go("+i+")'>");
	}
	
	if(pageDto.isNext()){
		out.print("<input type='button' value='>' onclick='go("+(pageDto.getEndNo()+1)+")'>");
		out.print("<input type='button' value='>>' onclick='go("+pageDto.getRealEnd()+")'>");
	}
%>
</body>
</html>
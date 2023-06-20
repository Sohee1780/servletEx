<%@page import="dto.Criteria"%>
<%@page import="dto.pageDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	PageDto객체를 가지고 페이지 블럭을 생성
	- 페이지블럭의 시작번호
	- 페이지블럭의 끝번호
	- 게시물의 끝 페이지 번호
	- 이전 버튼을 출력할지 여부
	- 다음 버튼을 출력할지 여부
	
-->

<!-- 영역에 저장 -->
<c:set var="pageDto" value="<%=pageDto %>"></c:set>

<!-- 이전 -->
<c:if test="${pageDto.prev }">
	<a href='List.jsp?pageNo=${pageDto.startNo-1 }'>이전</a>
</c:if>

<!-- 페이지 번호 -->
<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" step="1" var="pageNo">
	<a href='List.jsp?pageNo=${pageNo }'>${pageNo }</a>
</c:forEach>

<!-- 이후 -->
<c:if test="${pageDto.next }">
	<a href='List.jsp?pageNo=${pageDto.endNo+1 }'>이후</a>
</c:if>
<!--  
< %
	/*
	// 총 게시물 수, 검색조건(페이지번호, 페이지당게시물수, 검색어, 검색조건)
	int pageNo=request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
	
	// totalCnt, pageNo를 세팅해줘야함
	int totalCnt = 300;
	Criteria criteria = new Criteria(pageNo);
	pageDto pageDto = new pageDto(totalCnt, criteria);
	*/

	if(pageDto.isPrev()){
		//만약 시작페이지 번호가 1보다 큰경우 이전 버튼을 출력
		out.print("<a href='List.jsp?pageNo="+(pageDto.getStartNo()-1)+"'>");
		out.print("<");
		out.print("</a>");
	}
	
	// 페이지 번호구해서 버튼 생성
	for(int i=pageDto.getStartNo(); i<=pageDto.getEndNo();i++){
		out.print("<a href='List.jsp?pageNo="+i+"'>");
		out.print(i);
		out.print("</a>");
	}
	
	if(pageDto.isNext()){
		// 만약 마지막번호가 게시물의 끝페이지 번호와 일치하지 않으면
		out.print("<a href='List.jsp?pageNo="+(pageDto.getEndNo()+1)+"'>");
		out.print(">");
		out.print("</a>");
	}
% >-->
</body>
</html>
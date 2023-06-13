<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
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
	BoardDao board = new BoardDao();
	List<Board> boardList = board.getList();
	int totalCount = board.getTotalCount();
	
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	// 널처리
	// 검색어가 null이 아니면 검색 기능을 추가
	out.print(searchField);
	out.print(searchWord);
%>
<jsp:include page="Link.jsp" />
	<h2>목록보기(list)</h2>

	총 건수 : <%=totalCount %>
	<!-- method 기본값 get 생략가능 -->
	<!-- 검색폼 -->
	<form method="get">
	<table border="1" width="90%">
		<tr>
			<td align="center">
				<select name="searchField">
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchWord" value=<%=searchWord %>>
				<input type="submit" value="검색하기">
			</td>
		</tr>
	</table>
	</form>
	
	<table border='1' width="90%">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
		</tr>
		<%
			if(boardList.isEmpty()){
				// 게시글이 하나도 없을때
		%>
		<tr>
			<td colspan='5' align="center">등록된 게시물이 없습니다.</td>
		</tr>		
		<%
			} else{
				for(Board b : boardList){
		%>
		<tr>
			<td><%=b.getNum() %></td>
			<td><%=b.getTitle() %></td>
			<td><%=b.getId() %></td>
			<td><%=b.getVisitCount() %></td>
			<td><%=b.getPostDate() %></td>
		</tr>
		<%
				}
			}
		%>
	</table>
	<form>
		<table border="1" width="90%">
		<tr>
			<td align="right">
				<input type="button" value="글쓰기">
			</td>
		</tr>
		</table>
	</form>
</body>
</html>
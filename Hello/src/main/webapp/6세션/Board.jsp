<%@page import="dto.pageDto"%>
<%@page import="dto.Criteria"%>
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

	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	String pageNo = request.getParameter("pageNo");
	// 검색어가 null인경우 빈문자열로 치환
	// searchWord = searchWord==null?"" : searchWord;
	
	// 검색조건 객체로 생성
	Criteria criteria = new Criteria(searchField, searchWord, pageNo);
	
	// 리스트 조회
	// List<Board> boardList = board.getList(searchField, searchWord); 페이징X
	List<Board> boardList = board.getListPage(criteria); // 페이징O
	// 총 건수 조회
	int totalCount = board.getTotalCount(criteria);
%>

<jsp:include page="Link.jsp" />
	<h2>목록보기(list)</h2>

	총 건수 : <%=totalCount %>
	<!-- method 기본값 get 생략가능 action이 없으면 자기 페이지 다시 요청-->
	<!-- 검색폼 -->
	<form name='searchForm'>
	<%-- value='<%=criteria.getPageNo()%>' --%>
	<input type='text' name='pageNo'>
 	<table border="1" width="90%">
		<tr>
			<td align="center">
				<select name="searchField">
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchWord" value=<%=criteria.getSearchWord() %>>
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
			<td><a href="View.jsp?num=<%= b.getNum()%>" style="text-decoration-line:none;"><%=b.getTitle()%></a></td>
			<td><%=b.getId() %></td>
			<td><%=b.getVisitCount() %></td>
			<td><%=b.getPostDate() %></td>
		</tr>
		<%
				}
			}
		%>
	</table>
	
	<table border="1" width="90%">
	<tr>
		<td align="right">
		<%
			if(session.getAttribute("UserId")!=null){
		%>
			<input type="button" value="글쓰기" onclick="location.href='Write.jsp'">
		<%
			}else {
		%>
			로그인이 필요합니다.
		</td>
		<%
			}
		%>
	</tr>
	</table>
	
	<%
		pageDto pageDto = new pageDto(totalCount, criteria);
	%>
	
	<!-- 페이지블럭 생성 시작 -->
	<table border="1" width="90%">
		<tr>
			<td align="center">
				<%@include file="PageNavi.jsp" %>
			</td>
		</tr>
	</table>
</body>
</html>
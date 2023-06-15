<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="Link.jsp"></jsp:include>
<%
	BoardDao dao = new BoardDao();
	// 게시글 1건을 조회 후 board객체에 담아서 반환
	dao.updateVisitCount(request.getParameter("num"));
	Board board = dao.selectOne(request.getParameter("num"));
	
	if(board==null){
		JSFunction.alerBack("게시글이 존재하지 않습니다.", out);
		return;
	}
	
%>
<script>
	function deletePost(){
		var res = confirm("삭제 하시겠습니까?"); // true, false
		if(res) {
			// 1. 보드가 먼저 생성되야 참조를 할수있으므로 보드생성을 위로 올리는 방법
			location.href="deleteProcess.jsp?num=<%= board.getNum()%>";
		}
	}
</script>
</head>
<body>

<h2>회원제 게시판 - 상세 보기(View)</h2>
<table border="1" width="90%">
	<tr>
		<td>번호</td>
		<td><%= board.getNum() %></td>
		<td>작성자</td>
		<td><%= board.getId() %></td>
	</tr>
	<tr>
		<td>작성일</td>
		<td><%= board.getPostDate() %></td>
		<td>조회수</td>
		<td><%= board.getVisitCount() %></td>
	</tr>
	<tr style="height:100px;">
		<td>내용</td>
		<td colspan='3' ><%= board.getContent().replace("\r\n", "<br/>") %></td>
	</tr>
		<tr>
			<td colspan='4' align="right">
				<input type="button" value='목록 보기' onclick="location.href='Board.jsp'">
		<%
			// String id = session.getAttribute("UserId")==null?"":session.getAttribute("UserId").toString();
			// if(board.getId().equals(id)){
			if(session.getAttribute("UserId")!=null &&
				board.getId().equals(session.getAttribute("UserId").toString())){
		%>	
				<button type="button" onclick="location.href='Edit.jsp?num=<%= board.getNum()%>'">수정하기</button>
				<button type="button" onclick="deletePost()">삭제하기</button>
		<%
			}
		%>
			</td>
		</tr>
</table>

</body>
</html>
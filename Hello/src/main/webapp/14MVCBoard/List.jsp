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

// 조회수 증가 - 상세보기, 파일다운로드
// 수정하기

<h2>MVC 모델2 게시판</h2>

	<h4>총 게시물수 : ${count }</h4>
	<form name="searchForm" method="get" id="searchForm">
		<table border='1' width="90%">
		
		<!-- 페이지 번호 -->
		<!-- 밑에 텍스트 필드에 밸류값을 주면 검색이 제대로 안됨 
			 => value="${param.pageNo }"로 하면 밸류값이 저장되서 페이지넘버가 1로 초기화가 안됨 -->
		<input type="hidden" name="pageNo">
			<tr>
				<td align="center">
				<select name="searchField"> 
	            <option value="title" ${param.searchField eq "title"? "selected":"" }>제목</option> 
	            <option value="content" ${param.searchField eq "content"? "selected":"" }>내용</option>
            	</select>
								
				<input type="text" name="searchWord" value="${param.searchWord }">
				<input type="submit" value="검색하기">
				</td>
			</tr>
		</table>
	</form>
	
	<table border='1' width="90%">
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
			<th>첨부</th>
		</tr>
		
		<c:choose>
			<c:when test="${empty list }">
			<!-- 조회된 게시물이 없는경우 -->
				<tr align="center">
					<td colspan="6">등록된 게시물이 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="row" varStatus="loop">
				<tr align="center">
					<td>${row.idx }</td>
					<td><a href='../mvcboard/view.do?idx=${row.idx }'>${row.title }</a></td>
					<td>${row.name }</td>
					<td>${row.visitcount }</td>
					<td>${row.postdate }</td>
					<td>
						<!-- 첨부파일이 있으면 첨부파일 다운로드 -->
						<c:if test="${not empty row.ofile }">
							<a href="../mvcboard/download.do?ofile=${row.ofile }&sfile=${row.sfile}&idx=${row.idx}">
							[Down]
							</a>
						</c:if>
						</td>	
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
	
	<!-- 글쓰기 버튼
		글쓰기 버튼 클릭시 글쓰기 페이지로 이동 -> 글쓰기 버튼 클릭 하면 글 등록
	-->
	<table border='1' width="90%">
		<tr align="right">
			<td><input type="button" value="글쓰기" onclick="location.href='../mvcboard/write.do'"></td>
		</tr>
	</table>
	
	<table border='1' width="90%">
		<tr align="center">
			<td>
				<%@include file="PageNavi.jsp" %>
				<%--
					// 페이지영역을 공유되지않음
					<jsp:include page=""></jsp:include>
				--%>
			</td>
		</tr>
	</table>

</body>
</html>
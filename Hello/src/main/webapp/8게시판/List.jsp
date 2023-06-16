<%@page import="dto.pageDto"%>
<%@page import="dto.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.NewBoaderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<%


	// 검색조건
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	String pageNo = request.getParameter("pageNo");
	
	/*
	String reset = request.getParameter("searchWord");
	
	//검색했을때 페이지 1로초기화되지만 옆페이지로 넘어갈수없음
	if(reset!=null && !"".equals(reset)){
		pageNo="1";
		reset="";
	}*/
	
	Criteria criteria = new Criteria(searchField, searchWord, pageNo);
	
	String re = request.getParameter("searchWord");
	
	
	
	// newBoardDao생성해서 리스트 받아오기
	NewBoaderDao newBoardDao = new NewBoaderDao();
	// List<Board> list = newBoardDao.getList(criteria);	
	List<Board> list = newBoardDao.getListPage(criteria);
	
	int totalCount = newBoardDao.getTotalCount(criteria);
%>
<body>
<%@include file="../6세션/Link.jsp" %>
	<h1>new</h1>
    <h2>목록 보기(List)</h2>
    <!-- 검색폼 --> 
    <form name="searchForm" method="get"> 
    <input type='text' name='pageNo' value='<%= criteria.getPageNo()%>'>
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" value="<%= criteria.getSearchWord() %>"/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
        <!-- 목록의 내용 --> 
        
        <%
        	if(list.isEmpty()){
        %>
        <tr>
        	<td colspan="5" align="center">게시물이 없습니다.</td>
        </tr>
        <%
        	} else {
        		// 리스트 목록을 돌면서 board객체를 꺼내옵니다.
        		for(Board b : list){
        %>	
        <tr align="center">	
            <td><%=b.getNum() %></td>  <!--게시물 번호-->
            <td align="left" style="padding-left:7px;"> <!--제목(+ 하이퍼링크)--> 
                <a href="View.jsp?num=<%= b.getNum() %>&pageNo=<%=criteria.getPageNo() %>" style="text-decoration-line: none;"><%= b.getTitle() %></a>
            </td>
            <td align="center"><%= b.getId() %></td> <!--작성자 아이디-->
            <td align="center"><%= b.getVisitCount() %></td> <!--조회수-->
            <td align="center"><%= b.getPostDate() %></td> <!--작성일-->
        </tr>
        <%
        		}
        	}
        %>
 
    </table>
    <!--목록 하단의 [글쓰기] 버튼-->
    <%
    	if(null!=session.getAttribute("UserId")&&
    		!"".equals(session.getAttribute("UserId"))){
    %>
    <table border="1" width="90%">
        <tr align="right">
            <td><button type="button" onclick="location.href='Write.jsp'">글쓰기</button></td>
        </tr>
    </table>
    <%		
    	}
    %>
    
    <!-- 
    	페이지 블럭 생성 시작
    	- 총 건수 조회
    	- 쿼리 수정
    	- form의 이름을 searchForm으로 지정
    	- pageNo 필드를 생성
    -->
	<%
   		pageDto pageDto = new pageDto(totalCount, criteria);
	%>
    <table border="1" width="90%">
    	<tr align="center">
    		<td><%@include file="../6세션/PageNavi.jsp" %></td>
    	</tr>
    </table>
</body>
</html>

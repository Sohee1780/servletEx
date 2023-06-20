<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	a{
		text-decoration-line : none; 
	}
</style>
${param.param1 }

<table border="1" width="90%"> 
    <tr>
        <td align="center">
        
        <c:if test="${not empty sessionScope.UserId }" var="res">
        	<a href="${pageContext.request.contextPath }/6세션/Logout.jsp">로그아웃</a>
        </c:if>
        
        <c:if test="${not res}">
        	<a href="${pageContext.request.contextPath }/6세션/LoginForm.jsp">로그인</a>
        </c:if>
        
        <!--
        	< %
        		if(session.getAttribute("UserId")!=null){
        	%>
        			<a href="${pageScope.request.pageContext }/Hello/6세션/Logout.jsp">로그아웃</a>
        	< %
        		}else{
        	%>
            		<a href="${pageScope.request.pageContext }/Hello/6세션/LoginForm.jsp">로그인</a>
        	< %		
        		}
        	%>
        	  -->
            <!-- 8장과 9장의 회원제 게시판 프로젝트에서 사용할 링크 -->
            &nbsp;&nbsp;&nbsp; 
            <a href="../8게시판/List.jsp">게시판(페이징X)</a>
            &nbsp;&nbsp;&nbsp; 
            <a href="../09PagingBoard/List.jsp">게시판(페이징O)</a>
        </td>
    </tr>
</table>

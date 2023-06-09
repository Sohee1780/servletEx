<%@page import="util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    div#popup {
        position: absolute; top:100px; left:50px; color:yellow;  
        width:270px; height:100px; background-color:gray;
    }
    div#popup>div {
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }
</style>
<script>
	window.onload = function(){	
		if(typeof closeBtn != 'undefined'){
			closeBtn.onclick = function(){
				// 체크박스가 체크되었으면 popFrm폼을 서브밋 처리 -> 요청 PopupCookie.jsp 요청
				if(document.querySelector('#inactiveToday').checked){
					popFrm.submit();
				} else {
					popup.style.display = 'none';
				}
			}
		}
		
	}
</script>
<title>쿠키를 이용한 팝업창 제어 1</title>

</head>
<body>
	<h1>쿠키를 이용한 팝업창 제어</h1>
	<%
		// 쿠키에 popupClose값이 등록되어있지 않으면 팝업창을 보여줌
		String cValue = CookieManager.readCookie(request, "PopupClose");
		if(!"Y".equals(cValue)){
	%>
	<div id="popup">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right">
	        <form name="popFrm" action="PopupCookie.jsp">
	            <input type="checkbox" id="inactiveToday" value="1" /> 
	            하루 동안 열지 않음
	            <input type="button" value="닫기" id="closeBtn" /> 
	        </form>
        </div>
    </div>
    <%
		}
    %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="util.CookieManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키를 활용한 팝업창 제어 3</title>
<style>
    div#popup {
        position: absolute; top:100px; left:50px; color:yellow;  
        width:270px; height:100px; background-color:gray;
    }
    div#popup>div {
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }
    .off{
    	display: none;
    }
</style>
<script>
	window.onload=function(){
		// 버튼이 클릭되면 함수를 실행
		closeBtn.onclick=function(){
			// 버튼이 클릭되면 팝업창 숨기기
			popup.style.display='none';
			
			var chkVal = document.querySelector("input[id=inactiveToday]:checked");
			
			// 체크박스가 체크 된 상태라면
			if(chkVal!=null && chkVal.value == 1){
				// 자바스크립트를 활용한 쿠키 생성
				const date = new Date();
				// 12시간을 나타낸다				
				date.setTime(date.getTime() + 12*60*60*1000);
				console.log(date);
				document.cookie = "PopupClose=off;expires="+date.toGMTString();
			}
		}
	}
</script>
</head>
<body>
<h2>쿠키를 활용한 팝업창 제어 3</h2>
<%
	String off = "".equals(CookieManager.readCookie(request, "PopupClose"))? "":"off";
%>
	<div id="popup" class="<%=off %>">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right">
	        <form name="popFrm">
	            <input type="checkbox" id="inactiveToday" value="1" /> 
	            하루 동안 열지 않음
	            <input type="button" value="닫기" id="closeBtn" /> 
	        </form>
        </div>
    </div>
</body>
</html>
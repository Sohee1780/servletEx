<%@page import="java.io.FileNotFoundException"%>
<%@page import="common.JSFunction"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
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
	// 업로드파일이 저장된 경로
	String saveDirectory = "c:/Upload";
	// 원본 파일 이름
	String originalFileName = request.getParameter("oName");
	// 저장된 파일이름
	String saveFileName = request.getParameter("sName");
	
	out.print("saveFileName : "+saveFileName+"<br>");
	out.print("originalFileName : "+originalFileName+"<br>");
	
	try{
		File file = new File(saveDirectory, saveFileName);
		out.print("file : "+file+"<br>");
		
		// 파일 입력 스트림 생성
		InputStream inStream = new FileInputStream(file);
		
		// 한글 파일명 깨짐 방지
		String client = request.getHeader("User-Agent");
		if(client.indexOf("WOW64") == -1){
			originalFileName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
		} else {
			originalFileName = new String(originalFileName.getBytes("KSC5601"), "ISO-8859-1");
		}
		
		
		// 파일 다운로드용 응답 헤더 설정
		response.reset();
		
		// 파일 다운로드 창을 띄우기 위한 콘텐츠 타입을 지정
		// octet-stream은 8비트 단위의 바이너리 데이터를 의미
		response.setContentType("application/octet-stream");
		
		// 원본 파일의 이름으로 다운로드 받을 수 있게 설정하는 부분
		response.setHeader("Content-Disposition", "attachment; filename=\""+originalFileName+"\"");
		response.setHeader("Content-Length", ""+file.length());
		
		// java.lang.IllegalStateException: getOutputStream() has already been called for this response
		// JSP파일에서 getOutputStream 관련 위의 에러가 발생하는 경우
		// getOutputStream()을 대신해서 getWriter() 호출 해주면 해결된다.
		// jsp는 servlet으로 변환될 때 자동적으로 write객체가 존재하는데 OutputStream 그냥 사용하는 경우 정상적으로
		// 인식 하지 못하는 문제가 있어서 가능하면 getWriter()을 사용하는게 좋음
		// getOutputStream의 경우 servlet에서 사용할 수 있습니다.
		
		// 부득이 하게 메소드를 사용해야 하는 경우 jsp 페이지에서 아래와 같이 처리
		// 출력스트림 초기화
		out.clear(); //out--> jsp자체 객체
		out=pageContext.pushBody(); //out--> jsp자체 객체
		// response 내장 객체로 부터 새로운 출력 스트림을 생성
		OutputStream outStream = response.getOutputStream();
		
		// 출력 스트림에 파일 내용 출력
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while((readBuffer = inStream.read(b))>0){
			outStream.write(b,0,readBuffer);
		}
		// 입/출력 스트림 닫음
		inStream.close();
		outStream.close();
	}catch(FileNotFoundException e){
		JSFunction.alerBack("파일을 찾을 수 없습니다.", out);
	}catch(Exception e){
		JSFunction.alerBack("파일 다운로드 중 오류가 발생했습니다.", out);
	}
	
%>
</body>
</html>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="common.JSFunction"%>
<%@page import="fileUpload.FileDao"%>
<%@page import="fileUpload.FileDto"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	// 저장할 디렉터리의 실제 경로
	String saveDirectory = "C:/Upload";

	// 파일의 최대 크기(1MB)
	int maxPostSize = 1024 * 1000;
	
	// 인코딩 방식
	String encoding = "utf-8";
	
	try{
		// 1. MultipartRequest객체 생성
		//	  생성자의 매개변수로 저장경로, 파일의 최대크기, 인코딩방식을 지정
		//	  객체가 정상적으로 생성되면 파일은 업로드 됩니다.
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);		
		
		// 2. 새로운 파일명 생성
		// 동일한 파일명이 업로드 되는 경우, 기존파일이 소실될 위험이 있으므로 파일명을 변경합니다.
		String fileName = mr.getOriginalFileName("attachedFile");
		
		// 첨부파일의 확장자
		String ext = fileName.substring(fileName.lastIndexOf("."));
		
		// H : 0~23, S : millisecond
		// 현재시간을 파일이름으로 지정
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String oFileName = fileName.substring(0,fileName.lastIndexOf("."));
		
		String newFileName = oFileName+"_"+now+ext;
		
		// System.out.println("원본파일명 : "+fileName);
		// System.out.println("신규파일명 : "+newFileName);
		
		// 3. 파일명 변경
		File oldFile = new File(saveDirectory+File.separator+fileName);
		File newFile = new File(saveDirectory+File.separator+newFileName);
		
		oldFile.renameTo(newFile);
		
		// 폼 요소의 값을 저장
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		
		// 체크박스인 경우, 배열로 반환 받아서 문자열로 연결해서 저장
		String[] categoryArr = mr.getParameterValues("category");
		StringBuffer sb = new StringBuffer();
		
		if(categoryArr==null) {
			sb.append("선택없음");
		}
		
		for(String category : categoryArr){
			sb.append(category+",");
		}

		String ofileName = mr.getFilesystemName("attachedFile"); // 원본 파일 이름
		
		// DTO생성
		FileDto dto = new FileDto("",name, title, sb.substring(0, sb.length()-1), fileName, newFileName, "");
		
		// uploadprocess에서 파일이름이 없으면 파일등록이 안되게 if문으로 처리
		// 유효성 검사 또는 파일업로드에서 처리
		
		// DAO를 통해 데이터 베이스에 등록
		FileDao dao = new FileDao();
		int res = dao.insertFile(dto);
		
		if(res>0){
			out.print("파일이 저장 되었습니다.");
			// 리스트 페이지로 이동
			JSFunction.alertLocation("파일이 저장 되었습니다.", "/Hello/12파일업로드/FileList.jsp", out);
		}else {
			out.print("DB등록에 실패 하였습니다.");
			// 이전 페이지로 이동
			JSFunction.alerBack("DB등록에 실패 하였습니다.", out);
		}
		
	} catch(Exception e){
		e.printStackTrace();
		out.print(e);
		request.setAttribute("errorMessage", "파일 업로드 오류");
		
		// 이전페이지로 이동
	}
	
%>
</body>
</html>
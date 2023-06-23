package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WriteController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 글쓰기 dao 호출
		
		// 공유되는 영역이 없을경우 sendRedirect 사용
		resp.sendRedirect("../14MVCBoard/Write.jsp");
	}
	
	public WriteController() {
		// TODO Auto-generated constructor stub
	}

}

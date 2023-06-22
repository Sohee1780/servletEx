package model2.mvcboard;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListController extends HttpServlet{

	// 서비스가 실행돼서 겟이나 포스트를 실행
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리스트 조회
		MvcFileDao dao = new MvcFileDao();
		List<MvcFileDto> list = dao.getMvcFileList();
		
		// out객체를 사용해서 출력할경우 깨져서 제대로 나오지 않음
//		PrintWriter out = resp.getWriter();
//		out.print(list.size());

		// request영역에 저장
		req.setAttribute("list", list);
		// 화면페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
	
	public ListController() {
		// TODO Auto-generated constructor stub
	}

}

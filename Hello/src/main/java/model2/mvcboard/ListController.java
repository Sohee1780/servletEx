package model2.mvcboard;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Criteria;
import dto.pageDto;

public class ListController extends HttpServlet{

	// 서비스가 실행돼서 겟이나 포스트를 실행
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리스트 조회
		MvcFileDao dao = new MvcFileDao();
		
		// 검색어, 페이지정보 세팅
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String pageNo = req.getParameter("pageNo");
		System.out.println("pageNo : "+pageNo);
		Criteria cri = new Criteria(searchField, searchWord, pageNo);

		System.out.println("=======    페이지 관련 파라메터");
		System.out.println(cri.getPageNo());
		System.out.println(cri.getStartNo());
		System.out.println(cri.getEndNo());
		System.out.println("===========================");
		
		// 검색어, 페이지 정보를 담은 객체를 매개변수로 넣어 줍니다.
		List<MvcFileDto> list = dao.getMvcFileListPage(cri);
		
		int count = dao.totalCount(cri);
		// out객체를 사용해서 출력할경우 깨져서 제대로 나오지 않음
		// PrintWriter out = resp.getWriter();
		// out.print(list.size());
		// 콘솔에 찍으려면 println
		// System.out.println(count);
		
		
		// 페이지 네비게이션 생성을 위해 pageDto 생성
		PageDto pageDto = new PageDto(count, cri);
		
		// request영역에 저장
		req.setAttribute("list", list);
		req.setAttribute("count", count);
		req.setAttribute("pageDto", pageDto);

		// 화면페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
	
	public ListController() {
		// TODO Auto-generated constructor stub
	}

}

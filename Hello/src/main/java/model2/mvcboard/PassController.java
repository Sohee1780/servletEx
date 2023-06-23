package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.JSFunction;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// mode : 수정(edit), 삭제(delete)
		// req.setAttribute("mode", req.getAttribute("mode"));
		// req.setAttribute("idx", req.getAttribute("idx"));
		
		req.getRequestDispatcher("../14MVCBoard/Pass.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		
		MvcFileDao dao = new MvcFileDao();
		// 게시글의 비밀번호가 일치하는지 확인
		boolean confirmed = dao.confirmPassword(idx,pass);

		if(confirmed) {
			// 비밀번호 체크 성공
			System.out.println("비밀번호 검증 성공");
			if("edit".equals(mode)) {
				// 수정
				resp.sendRedirect("../mvcboard/edit.do?idx="+idx);
				
			}else if("delete".equals(mode)) {
				// 삭제
				int res = dao.delete(idx);
				
				if(res>0) {
					// 삭제 성공 리스트로 돌아가기
					JSFunction.alertLocation(resp, "게시물 삭제에 성공했습니다.", "../mvcboard/list.do");
				}else {
					// 삭제 실패 이전화면으로 돌아가기
					JSFunction.alertBack(resp, "게시물 삭제에 실패하였습니다. 관리자에게 문의 해주세요");
				}
			}
			
		} else {
			// 비밀번호 체크 성공
			JSFunction.alertBack(resp, "비밀번호 검증에 실패하였습니다.");
		}
	}
	
	public PassController() {
		// TODO Auto-generated constructor stub
	}

}

package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Criteria;
import fileUpload.FileDao;
import fileUpload.FileDto;

@WebServlet("/12파일업로드/FileListServlet")
public class FileListServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pageNo = req.getParameter("pageNo");
		Criteria criteria = new Criteria(pageNo);
		
		FileDao dao = new FileDao();
		List<FileDto> list = dao.getFileListPage(criteria);
		
		req.setAttribute("list", list);
		req.getRequestDispatcher("./FileList.jsp").forward(req, resp);
	}
	
	public FileListServlet() {
		// TODO Auto-generated constructor stub
	}

}

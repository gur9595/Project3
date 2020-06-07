package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.BbsDAO;
import model1.BbsDTO;
import util.FileUtil;

public class DeleteCtrl2 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String num = req.getParameter("num");
		String nowPage = req.getParameter("nowPage");
		String bname = req.getParameter("bname");
		
		req.setAttribute("nowPage", nowPage);
		
		ServletContext application = this.getServletContext();
	    String drv = application.getInitParameter("MariaJDBCDriver");
	    String url = application.getInitParameter("MariaConnectURL");
	    BbsDAO dao = new BbsDAO(drv, url);
	    
		BbsDTO dto = dao.selectView(num);//기존 게시물 가져오기
		
		int sucOrFail = dao.delete2(num);//게시물 삭제하기
		if(sucOrFail==1) {//삭제 성공인 경우 
			//첨부된 파일명을 얻어와서 서버에 삭제처리한다
			String fileName = dto.getAttachedfile();
			FileUtil.deleteFile(req, "/Upload", fileName);
		}
		//mode가 delete이므로 아래와 같이 처리
		req.setAttribute("WHEREIS", "DELETE");
		req.setAttribute("SUC_FAIL", sucOrFail);
		req.setAttribute("bname", bname);
		req.getRequestDispatcher("/admin/Message.jsp").forward(req, resp);
	}
}

package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model1.BbsDAO;
import model1.BbsDTO;
import util.FileUtil;

public class EditCtrl2 extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//일련번호를 파라미터로 가져옴
		String num = req.getParameter("num");
		
		System.out.println("num : "+num);
		
		//서블릿에서 application내장객체를 얻어오기 위해 메소드 호출
		ServletContext app = this.getServletContext();
		BbsDAO dao = new BbsDAO(app);
		
		//일련번호에 해당하는 게시물 가져오기 
		BbsDTO dto = dao.selectView(num);
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/admin/DataEdit2.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		//첨부파일 업로드
		MultipartRequest mr= FileUtil.upload(req, req.getServletContext().getRealPath("/Upload"));
		
		int sucOrFail;
		
		//MultipartRequest 객체가 정상적으로 생성되면 나머지 폼값을 받아온다.
		if(mr!= null) {
			String num = mr.getParameter("num");
			String nowPage = mr.getParameter("nowPage");
			String originalfile = mr.getParameter("originalfile");
			
			//수정처리후 상세보기로 이동하므로 영역에 속성을 저장한다.
			req.setAttribute("num", num);
			req.setAttribute("nowPage", nowPage);
			
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String bname = mr.getParameter("bname");
			
			/*
			 만약 수정폼에서 첨부한 파일이 있다면 기존파일은 삭제해야하고
			 확인후 만약 없다면 기존파일명으로 유지한다. 
			 */
			String attachedfile = mr.getFilesystemName("attachedfile");
			
			if(attachedfile==null) {
				attachedfile = originalfile;
			}
			
			System.out.println("num : "+num);
			
			//폼값을  DTO객체에 저장한다
			BbsDTO dto = new BbsDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setNum(num);
			dto.setBname(bname);
			
			//DB처리(update) 
			ServletContext application = this.getServletContext();
		    String drv = application.getInitParameter("MariaJDBCDriver");
		    String url = application.getInitParameter("MariaConnectURL");
		    BbsDAO dao = new BbsDAO(drv, url);
			sucOrFail = dao.update(dto);
			
			/*
			 레코드의 update가 성공이고 동시에 새로운 업로드 완료
			 했다면 기존의 파일은 식제         
			 첨부한 파일이 없다면 기존파일은 유지  
			 */
			if(sucOrFail==1 && mr.getFilesystemName("attachedfile")!=null) {
				FileUtil.deleteFile(req, "/Upload", originalfile);
			}
			dao.close();	
		}
		else {
			//MultipartRequest객체가 생성되지 않았다면 파일업로드 실패로처리
			sucOrFail = -1;
		}
		if(sucOrFail==1) {
	      
	         resp.sendRedirect("../admin/board_community?bname="+mr.getParameter("bname"));
	      }
		
	}
}

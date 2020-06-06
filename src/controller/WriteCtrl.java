package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.oreilly.servlet.MultipartRequest;

import model1.BbsDAO;
import model1.BbsDTO;
import util.FileUtil;

public class WriteCtrl extends HttpServlet{
   /*
    글쓰기 페이지의 경우
    doGet() 메소드는 글쓰기 폼으로 이동할때의 요청을 처리하고
    doPost() 메소드는 글쓰기를 완료할 때의 요청을 처리한다.
    */
   
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	   
      //글쓰기 페이지로 진입시에는 JSP와 매핑만 해주면 된다.
      req.getRequestDispatcher("/community/DataWrite.jsp").forward(req, resp);
   }
   
   
   //게시물 내용 작성후 submit했을때의 요청을 처리함
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
	   //글쓰기 관련 폼값에 대한 한글처리
      req.setCharacterEncoding("UTF-8");
      
      //해당 메소드는 MultipartRequest개체를 생성하면서 파일업로드를 처리한다.
      /*
       	매개변수로 request객체, Upload의 서버의 물리적 경로를 전달한다.
       */
      MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("/Upload"));
      
      int sucOrFail;
      
      if(mr != null) {
         /*
          파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다.
          enctype이 "multipart/form-data"로 설정되므로 request객체를 통해
          폼값을 받을 수 없다.
          */
    	 String id = mr.getParameter("id");
         String bname = mr.getParameter("bname");
         String title = mr.getParameter("title");
         String content = mr.getParameter("content");
         //서버에 저장된 실제파일명을 가져온다.
         String attachedfile = mr.getFilesystemName("attachedfile");
         
         
         //DTO객체에 폼값을 저장한다.
         BbsDTO dto = new BbsDTO();
         dto.setId(id);
         dto.setBname(bname);
         dto.setTitle(title);
         dto.setContent(content);
         dto.setAttachedfile(attachedfile);
         
         //DAO객체 생성 및 DB연결 .. insert 처리
         ServletContext application = this.getServletContext();
 	     String drv = application.getInitParameter("MariaJDBCDriver");
 	     String url = application.getInitParameter("MariaConnectURL");
 	     BbsDAO dao = new BbsDAO(drv, url);
         
         sucOrFail = dao.insert(dto); 
         
         dao.close();
      }else {
    	 //mr객체가 생성되지 않았을때(업로드 실패시)
         sucOrFail = -1;
      }
      
      if(sucOrFail==1) {
         //파일 업로드 성공 및 글쓰기처리 성공일때
    	  //?bname="+req.getParameter("bname")
         resp.sendRedirect("../community/sub02.do?bname="+mr.getParameter("bname"));
      }
      else {
    	 //나머지는 실패로 처리한다. 실패시 글쓰기페이지로 돌아간다.
         req.getRequestDispatcher("/community/DataWrite.jsp").forward(req, resp);
      }
      
      
      
   }
   
}
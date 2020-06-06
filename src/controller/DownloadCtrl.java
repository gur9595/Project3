package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model1.BbsDAO;
import util.FileUtil;

public class DownloadCtrl extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String filename= req.getParameter("filename");
		
		/*
		 서버에 저장된 파일을 무조건 원본파일명.jpg로 이름을 변경하여 다운로드한다
		 차후 DB처리해야함
		 */
		//FileUtil.download(req, resp,"/Upload",filename, "원본파일명.jpg");
		FileUtil.download(req, resp,"/Upload",filename, filename);

	
	}
}

<%@page import="model1.BbsDAO"%>
<%@page import="model1.BbsDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");

String saveDirectory =application.getRealPath("/Upload");

int maxPostSize = 1024 * 5000;
	
String encoding= "UTF-8";

FileRenamePolicy policy = new DefaultFileRenamePolicy();

MultipartRequest mr = null;
String name= null; //이름
String title= request.getParameter("title");
String content= request.getParameter("content");
String bname = request.getParameter("bname");
StringBuffer inter= new StringBuffer(); //관심사항을 저장함 
File oldFile =null;
File newFile=null;
String realFileName=null;
try{
	mr= new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);

	String fileName = mr.getFilesystemName("chumFile1");

	String nowTime= new SimpleDateFormat("yyyy_MM_dd_H_m_s_S").format(new Date());

	int idx=-1;
	idx = fileName.lastIndexOf(".");
	realFileName = nowTime + fileName.substring(idx, fileName.length());

	oldFile = new File(saveDirectory+oldFile.separator+fileName);
	newFile = new File(saveDirectory+oldFile.separator+realFileName);
	
	oldFile.renameTo(newFile);
////////////////////////////////////////////////////////////////////////////////////////////////////

	name=mr.getParameter("name");
	title=mr.getParameter("title");
	content=mr.getParameter("content");
	bname=mr.getParameter("bname");

	//////////////////////////////////////////////////////////
	BbsDTO dto = new BbsDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setBname(bname);
	dto.setId(session.getAttribute("USER_ID").toString());
	dto.setOfile(mr.getOriginalFileName("chumFile1"));
	dto.setSfile(realFileName);
	
	BbsDAO dao = new BbsDAO(application);
	
	int affected = dao.myfileInsert(dto);

	if(affected==1){
		
		response.sendRedirect("../../space/sub03.jsp?bname=info");
	}
}catch(Exception e){

	request.setAttribute("errorMessage", "파일업로드오류");
	request.getRequestDispatcher("../../space/sub03_view.jsp").forward(request, response);
}

%>



















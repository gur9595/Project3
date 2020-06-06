<%@page import="model1.BbsDAO"%>
<%@page import="model1.BbsDTO"%>
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

String bname= null; 
String title= null; 
String content = null;
String img =null;
String id=null;
String fileName=null;
String num=null;

try{
	
	mr= new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
	
	bname=mr.getParameter("bname");
	title=mr.getParameter("title");
	content=mr.getParameter("content");
	img=mr.getOriginalFileName("img");
	num=mr.getParameter("num");
	
	BbsDTO dto = new BbsDTO();
	
	id = session.getAttribute("USER_ID").toString();
	
	dto.setId(id);
	dto.setBname(bname);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setImg(img);
	dto.setNum(num);
	
	System.out.println("id : "+id);
	System.out.println("bname : "+bname);
	System.out.println("title : "+title);
	System.out.println("content : "+content);
	System.out.println("img : "+img);
	
	BbsDAO dao = new BbsDAO(application);
	
	int affected = dao.imgEdit(dto);
	System.out.println("aff: " +affected);
	if(affected==1){
		
		response.sendRedirect("../../space/sub03.jsp?bname=photo");
	}
	
}catch(Exception e){
	
	request.setAttribute("errorMessage", "파일업로드오류");
	request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
}
%>




















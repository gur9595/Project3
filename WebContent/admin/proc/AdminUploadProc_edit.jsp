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
String num = request.getParameter("num");
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

	name=mr.getParameter("name");
	title=mr.getParameter("title");
	content=mr.getParameter("content");
	bname=mr.getParameter("bname");
	num=mr.getParameter("num");
	
	System.out.println(title);
	System.out.println(content);
	System.out.println(bname);
	System.out.println(mr.getOriginalFileName("chumFile1"));
	System.out.println(realFileName);
	
	BbsDTO dto = new BbsDTO();
	
	System.out.print("1");
	
	dto.setTitle(title);
	dto.setContent(content);
	dto.setOfile(mr.getOriginalFileName("chumFile1"));
	dto.setSfile(realFileName);
	dto.setBname(bname);
	dto.setNum(num);

	System.out.print("2");

	BbsDAO dao = new BbsDAO(application);
	System.out.print("3");

	int affected = dao.myfileEdit(dto);
	System.out.print("4");

if(affected==1){
		
		response.sendRedirect("../../admin/board_free.jsp?bname=info");
	}
	
}catch(Exception e){
	e.printStackTrace();
}

%>



















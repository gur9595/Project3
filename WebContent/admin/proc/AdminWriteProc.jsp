<%@page import="model1.BbsDAO"%>
<%@page import="model1.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../isFlag.jsp"%>
<%@ include file="../isLogin.jsp"%>
<%
request.setCharacterEncoding("UTF-8");

//폼값전송받기
String title= request.getParameter("title");
String content= request.getParameter("content");

//폼값을 DTO객체에 저장
BbsDTO dto=new BbsDTO();
dto.setTitle(title);
dto.setContent(content);
//세션 영역에 저장된 회원인증정보를 가져와서 저장
dto.setId(session.getAttribute("admin_id").toString());

//게시판 필수파라미터를 DTO에 추가
dto.setBname(bname);

//DAO객체 생성시 application내장 객체를 인자로 전달
BbsDAO dao= new BbsDAO(application);

//사용자의 입력값을 DTO객체에 저장후 파라미터로 전달
int affected = dao.insertWrite(dto);

if(affected==1){
	response.sendRedirect("../board_free.jsp?bname="+bname);
}
else{
	
%>
<script>
alert("글쓰기에 실패했습니다");
history.go(-1);
</script>
<%
}
%>
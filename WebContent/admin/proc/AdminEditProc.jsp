<%@page import="model1.BbsDAO"%>
<%@page import="model1.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../member/common/isLogin.jsp"%>
<%@ include file="../../member/common/isFlag.jsp"%>
<%
request.setCharacterEncoding("UTF-8");

//폼값받기
String num= request.getParameter("num");
String title= request.getParameter("title");
String content= request.getParameter("content");

//폼값을 DTO객체에 저장
BbsDTO dto= new BbsDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

BbsDAO dao=new BbsDAO(application);
//DTO객체를 DAO로 전달하여 게시물 업데이트 (수정)
int affected=dao.updateEdit(dto);
if(affected==1){
	//정상적으로 수정되었다면 수정된 내용의 확인을 위해 상세보기로 이동
	response.sendRedirect("../board_free_view.jsp?bname="+bname+"&num="+dto.getNum());
}else{
	//수정중 문제가 발생하였다면 수정하기 페이지로 돌아감
%>
<script>
	alert("수정하기에 실패하였습니다");
	history.go(-1);
	</script>
<%
}
%>
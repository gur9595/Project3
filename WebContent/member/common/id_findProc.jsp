<%@page import="java.util.Map"%>
<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String email = request.getParameter("email");

String drv= application.getInitParameter("MariaJDBCDriver");
String url= application.getInitParameter("MariaConnectURL");

MemberDAO dao= new MemberDAO(drv,url);

Map<String , String> memberInfo = dao.getIdFindMap(name, email);

if(memberInfo.get("id")!=null){
	out.println("찾은아이디 : "+memberInfo.get("id"));
}else{
	out.println("아이디를 찾을수 없습니다.");
}
%>

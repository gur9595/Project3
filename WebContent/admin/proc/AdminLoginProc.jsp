<%@page import="java.util.Map"%>
<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id =request.getParameter("admin_id");
String pw = request.getParameter("admin_pw");

String drv= application.getInitParameter("MariaJDBCDriver");
String url= application.getInitParameter("MariaConnectURL");

MemberDAO dao= new MemberDAO(drv,url);


Map<String , String> memberInfo = dao.getAdminMap(id, pw);

//Map의 id키값에 저장된 값이 있는지 확인
if(memberInfo.get("id")!=null){
	session.setAttribute("admin_id", memberInfo.get("id"));
	session.setAttribute("admin_pw", memberInfo.get("pass"));
	session.setAttribute("admin_name", memberInfo.get("name"));	
	
	response.sendRedirect("../../admin/adminMain.jsp");
}else{%>
<script>
	alert("관리자가 아닙니다");
	history.go(-1);
</script>
<%
}
%>












<%@page import="java.util.HashMap"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="java.util.Map"%>
<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String from = request.getParameter("from");
String p_id = request.getParameter("p_id");
String p_name = request.getParameter("p_name");
String p_email = request.getParameter("p_email");

String drv= application.getInitParameter("MariaJDBCDriver");
String url= application.getInitParameter("MariaConnectURL");

MemberDAO dao= new MemberDAO(drv,url);

Map<String , String> memberInfo = dao.getPwFindMap(p_id, p_name, p_email);

String id = memberInfo.get("id");
String name = memberInfo.get("name");
String email = memberInfo.get("email");
String pass = memberInfo.get("pass");

SMTPAuth smtp = new SMTPAuth();

Map<String, String> emailContent = new HashMap<String,String>();

emailContent.put("from", from);
emailContent.put("to", p_email);
emailContent.put("subject", "수아밀 홈페이지 비밀번호 전송");
emailContent.put("content", p_id+"님의 비밀번호는 "+pass);

if(memberInfo.get("pass")!=null){
	boolean emailResult = smtp.emailSending(emailContent);
	if(emailResult==true){
		
		out.print("메일을 발송하였습니다.");
	}else{
		out.print("메일발송 실패");
	}
	return;
}else{
	out.print("정보가 일치하지 않습니다.");
}
%>





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

System.out.println("1 아이디 : "+p_id);
System.out.println("1 이름 : "+p_name);
System.out.println("1 이메일 : "+p_email);
System.out.println("1 보내는사람 : "+from);

String drv= application.getInitParameter("MariaJDBCDriver");
String url= application.getInitParameter("MariaConnectURL");


MemberDAO dao= new MemberDAO(drv,url);

Map<String , String> memberInfo = dao.getPwFindMap(p_id, p_name, p_email);

String id = memberInfo.get("id");
String name = memberInfo.get("name");
String email = memberInfo.get("email");
String pass = memberInfo.get("pass");

System.out.println("3 아이디 : "+id);
System.out.println("3 이름 : "+name);
System.out.println("3 이메일 : "+email);
System.out.println("3 비밀번호 : "+pass);

SMTPAuth smtp = new SMTPAuth();

Map<String, String> emailContent = new HashMap<String,String>();


System.out.println("4 아이디 : "+id);
System.out.println("4 이름 : "+name);
System.out.println("4 이메일 : "+email);
System.out.println("4 비밀번호 : "+pass);

emailContent.put("from", from);
emailContent.put("to", p_email);
emailContent.put("subject", "수아밀 홈페이지 비밀번호 전송");
emailContent.put("content", p_id+"님의 비밀번호는 "+pass);

System.out.println("5 아이디 : "+id);
System.out.println("5 이름 : "+name);
System.out.println("5 이메일 : "+email);
System.out.println("5 비밀번호 : "+pass);

if(memberInfo.get("pass")!=null){
	boolean emailResult = smtp.emailSending(emailContent);
	if(emailResult==true){
		
		System.out.println("6 아이디 : "+id);
		System.out.println("6 이름 : "+name);
		System.out.println("6 이메일 : "+email);
		System.out.println("6 비밀번호 : "+pass);
		
		out.print("메일을 발송하였습니다.");
	}else{
		out.print("메일발송 실패");
	}
	return;
}else{
	out.print("정보가 일치하지 않습니다.");
}
%>





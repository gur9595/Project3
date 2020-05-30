<%@page import="model1.MemberDAO"%>
<%@page import="model1.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//폼값전송받기
String id= request.getParameter("id");
String name= request.getParameter("name");
String pass= request.getParameter("pass");
String tel1= request.getParameter("tel1");
String tel2= request.getParameter("tel2");
String tel3= request.getParameter("tel3");
String mobile1= request.getParameter("mobile1");
String mobile2= request.getParameter("mobile2");
String mobile3= request.getParameter("mobile3");
String email1= request.getParameter("email1");
String email2= request.getParameter("email2");
String zip1= request.getParameter("zip1");
String addr1= request.getParameter("addr1");
String addr2= request.getParameter("addr2");

String tel = tel1+"-"+tel2+"-"+tel3;
String mobile = mobile1+"-"+mobile2+"-"+mobile3;
String email = email1+"@"+email2;
String addr = addr1+" "+addr2;

//폼값을 DTO객체에 저장
MemberDTO dto=new MemberDTO();
dto.setId(id);
dto.setName(name);
dto.setPass(pass);
dto.setTel(tel);
dto.setMobile(mobile);
dto.setEmail(email);
dto.setZip(zip1);
dto.setAddr(addr);
//DAO객체 생성시 application내장 객체를 인자로 전달
MemberDAO dao= new MemberDAO(application);

System.out.println("4");
//사용자의 입력값을 DTO객체에 저장후 파라미터로 전달
int affected = dao.insertMember(dto);

System.out.println("affected"+affected);

System.out.println("5");
if(affected==1){
	response.sendRedirect("../../main/main.jsp");
	System.out.println("6");
}
else{
	
%>
<script>
alert("회원가입 실패했습니다");
history.go(-1);
</script>
<%
}
%>
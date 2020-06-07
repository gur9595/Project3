<%@page import="model1.RequestDTO"%>
<%@page import="model1.RequestDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="java.util.Map"%>
<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String from = request.getParameter("from");
String name = request.getParameter("name");
String addr = request.getParameter("addr");
String tel1 = request.getParameter("tel1");
String tel2 = request.getParameter("tel2");
String tel3 = request.getParameter("tel3");
String phone1 = request.getParameter("phone1");
String phone2 = request.getParameter("phone2");
String phone3 = request.getParameter("phone3");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String cleanType = request.getParameter("cleanType");
String cleanArea = request.getParameter("cleanArea");
String hopeDate = request.getParameter("hopeDate");
String regiType = request.getParameter("regiType");
String note = request.getParameter("note");
String id = session.getAttribute("USER_ID").toString();
String disorder = request.getParameter("disorder");
String disorderType = request.getParameter("disorderType");
String bojanggu = request.getParameter("bojanggu");
String bojangguName = request.getParameter("bojangguName");
String adminTel1 = request.getParameter("adminTel1");
String adminTel2 = request.getParameter("adminTel2");
String adminTel3 = request.getParameter("adminTel3");
String cake = request.getParameter("cake");
String cookie = request.getParameter("cookie");
String bname = request.getParameter("bname");

String tel = tel1+"-"+tel2+"-"+tel3;
String phone = phone1+"-"+phone2+"-"+phone3;
String email = email1+"@"+email2;
String adminTel =adminTel1+"-"+adminTel2+"-"+adminTel3;

SMTPAuth smtp = new SMTPAuth();

Map<String, String> emailContent = new HashMap<String,String>();


if(bname.equals("clean")){
	RequestDTO dto = new RequestDTO();

	dto.setName(name);
	dto.setAddr(addr);
	dto.setTel(tel);
	dto.setPhone(phone);
	dto.setEmail(email);
	dto.setCleanType(cleanType);
	dto.setCleanArea(cleanArea);
	dto.setHopeDate(hopeDate);
	dto.setRegiType(regiType);
	dto.setNote(note);
	dto.setId(id);
	dto.setBname(bname);
	RequestDAO dao =new RequestDAO(application);

	int affected = dao.insertRequest(dto);;

	emailContent.put("from", from);
	emailContent.put("to", email);
	emailContent.put("subject", name+"님의 블루클리닝 견적 의뢰");
	emailContent.put("content", "아이디 : "+id+"<br/>"+
								"이름 : "+name+"<br/>"+
								"주소 : "+addr+"<br/>"+
								"핸드폰 : "+phone+"<br/>"+
								"청소종류 : "+cleanType+"<br/>"+
								"분양평수/등기평수 : "+cleanArea+"<br/>"+
								"희망날짜 : "+hopeDate+"<br/>"+
								"연락처 : "+tel+"<br/>"+
								"이메일 : "+email+"<br/>"+
								"접수종류 : "+regiType+"<br/>"+
								"기타특이사항 : "+note+"<br/>"
								
					);
	if(session.getAttribute("USER_ID").toString()!=null){
		
		boolean emailResult = smtp.emailSending(emailContent);
		
		emailContent.put("to", from);
		
		smtp.emailSending(emailContent);
		
		if(emailResult==true){
			
			out.print("메일을 발송하였습니다.");
		}else{
			out.print("메일발송 실패");
		}
		return;
	}else{
		out.print("회원이 아닙니다");
	}
	
}else if(bname.equals("leaning")){
	
	RequestDTO dto = new RequestDTO();
	
	dto.setDisorder(disorder);
	dto.setDisorderType(disorderType);
	dto.setBojanggu(bojanggu);
	dto.setBojangguName(bojangguName);
	dto.setAdminTel(adminTel);
	dto.setCake(cake);
	dto.setCookie(cookie);
	dto.setBname(bname);
	dto.setHopeDate(hopeDate);
	dto.setRegiType(regiType);
	dto.setNote(note);
	dto.setId(id);
	dto.setName(name);
	dto.setTel(tel);
	dto.setEmail(email);

	RequestDAO dao =new RequestDAO(application);

	int affected = dao.insertRequest2(dto);

	emailContent.put("from", from);
	emailContent.put("to", email);
	emailContent.put("subject", name+"님의 체험학습신청");
	emailContent.put("content", "아이디 : "+id+"<br/>"+
								"이름 : "+name+"<br/>"+
								"장애유무 : "+disorder+"<br/>"+
								"주요장애유형 : "+disorderType+"<br/>"+
								"보장구 사용유무 : "+bojanggu+"<br/>"+
								"보장구 명 : "+bojangguName+"<br/>"+
								"담당자 휴대전화 : "+adminTel+"<br/>"+
								"케익체험 : "+cake+"<br/>"+
								"쿠키체험 : "+cookie+"<br/>"+
								"희망날짜 : "+hopeDate+"<br/>"+
								"연락처 : "+tel+"<br/>"+
								"이메일 : "+email+"<br/>"+
								"접수종류 : "+regiType+"<br/>"+
								"기타특이사항 : "+note+"<br/>"
								
					);
	if(session.getAttribute("USER_ID").toString()!=null){
		
		boolean emailResult = smtp.emailSending(emailContent);
		
		emailContent.put("to", from);
		
		smtp.emailSending(emailContent);
		
		if(emailResult==true){
			
			out.print("메일을 발송하였습니다.");
		}else{
			out.print("메일발송 실패");
		}
		return;
	}else{
		out.print("회원이 아닙니다");
	}
	
}

%>





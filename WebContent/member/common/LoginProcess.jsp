<%@page import="java.util.Map"%>
<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id =request.getParameter("user_id");
String pw = request.getParameter("user_pw");

String id_save = request.getParameter("id_save");

String drv= application.getInitParameter("MariaJDBCDriver");
String url= application.getInitParameter("MariaConnectURL");

MemberDAO dao= new MemberDAO(drv,url);


Map<String , String> memberInfo = dao.getMemberMap(id,pw);
//Map의 id키값에 저장된 값이 있는지 확인
if(memberInfo.get("id")!=null){
	session.setAttribute("USER_ID", memberInfo.get("id"));
	session.setAttribute("USER_PW", memberInfo.get("pass"));
	session.setAttribute("USER_NAME", memberInfo.get("name"));
	session.setAttribute("authority", memberInfo.get("authority"));
	
	System.out.println(memberInfo.get("authority"));
	
	
	if(id_save==null){
		//아이디저장하기에 체크하지 않았을때
		//쿠키를 삭제하기 위해 빈 쿠키를 생성한다.
		Cookie ck =new Cookie("USER_ID", "");
		ck.setPath(request.getContextPath());
		ck.setMaxAge(0);//유효시간이 0이므로 사용할수 없는 쿠키가된다.
		response.addCookie(ck);
	}else{
		//체크했을때...
		//사용자가 입력한 아이디로 쿠키를 생성한다
		Cookie ck = new Cookie("USER_ID", id);
		System.out.println(request.getContextPath());
		ck.setPath(request.getContextPath());
		ck.setMaxAge(60*60/24*100);
		response.addCookie(ck);
	System.out.println(ck);
	}
	
	response.sendRedirect("../../main/main.jsp");
}else{%>
<script>
alert("회원이 아닙니다");
history.go(-1);
</script>
<%
}
%>












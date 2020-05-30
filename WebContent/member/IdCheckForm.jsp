<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script>

function idCheckbtn(){
	var cid= document.checkForm.id.value;
	console.log(cid);
	<%
	String id =request.getParameter("id");%>
	<%MemberDAO dao = new MemberDAO(application);
	
	System.out.println(dao.idCheck(id));
	if(dao.idCheck(id)==true){%>
		alert("중복된 아이디! 사용불가능합니다");
		
	<%} else if(dao.idCheck(id)==false){%>
		alert("사용가능");
		
	<%}%>
	
}

function idUse(){
    /*
        자식창에서 opener속성으로 부모창으로 데이터를 전송한다
        부모창의 아이디 입력필드가 readonly로 변경되므로 JS을 통해
        값을 변경해야한다
    */
    opener.document.joinFrm.id.value= document.checkForm.id.value;
    self.close();
}
</script>
</head>
<body>
<div>
	<br />
	<b><font size="4" color="gray">아이디 중복체크</font></b>
	<hr size = "1" width="460">
	<br />
	<div id="chk">
		<form name="checkForm">
			<input type="text"  name="id" id="cid" value="<%=request.getParameter("id") %>" />
			<input type="button" value="중복확인" onclick="idCheckbtn();">
		</form>
		<div id="msg"></div>
		<br />
		<input type="button" value="취소" onclick="window.close()"/><br />
		<input type="button" value="아이디사용하기" onclick="idUse();">
	</div>	
</div>
</body>

</html>
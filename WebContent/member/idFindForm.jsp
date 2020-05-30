<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>타이틀</title>
<script src="../common/jquery/jquery-3.5.1.js"></script>

</head>
<body>
	<br />
	<b><font size="4" color="gray">아이디 찾기</font></b>
	<hr size = "1" width="460">
	<br />
	<div>
		<%if(session.getAttribute("id")!=null) {%>
		<span>찾는 아이디 : <%=session.getAttribute("id") %></span>
		<%}else{ %>
		<span><%=request.getAttribute("ERR_MSG") %></span>
		<%} %>
	</div>	
</body>
</html>
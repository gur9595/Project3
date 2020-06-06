<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<style>
 form
 {
 	display: inline;
 }
</style>
<script>
$(function(){
	$('#id_findBtn').click(function(){
		$.ajax({
			url : "./common/id_findProc.jsp",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset:utf-8;",
			data:{
				name : $("#name").val(),
				email : $("#email").val()
			},
			dataType : "html",
			
			success : function(idfind){
				alert(idfind);
			},
			error : function(e){
				alert("실패CallBack"+e.status+":"+e.statusText);
			}
		});
	});
	
	$('#pw_findBtn').click(function(){
		$.ajax({
			url : "./common/pw_findProc.jsp",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset:utf-8;",
			data : {
				p_id : $("#p_id").val(),
				from : $("#from").val(),
				p_name : $("#p_name").val(),
				p_email : $("#p_email").val()
			},
			dataType : "html",
			
			success : function(pwfind){
				alert(pwfind);
			},
			error : function(e){
				alert("실패CallBack"+e.status+":"+e.statusText);
			}
		});
	});
	
});

</script>

 <body>
 
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<script>
				
				</script>
				
				<div class="idpw_box">
				
					<div class="id_box">
						<ul>
							<li><input type="text" id="name" name="name" class="login_input01" /></li>
							<li><input type="text" id="email" name="email" class="login_input01" /></li>
						</ul>
						<input id="id_findBtn" type="image" src="../images/member/id_btn01.gif" class="id_btn" />
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
					
					<!-- <form action="./common/pw_findProc.jsp" method="post"> -->
					<div class="pw_box">
						<ul>
							<li><input type="hidden" name="from" id="from" value="gur9595@naver.com" /></li>
							<li><input type="text" name="p_id" id="p_id"  class="login_input01" /></li>
							<li><input type="text" name="p_name" id="p_name" class="login_input01" /></li>
							<li><input type="text" name="p_email" id="p_email" class="login_input01" /></li>
						</ul>
						<button id="pw_findBtn" type= "button"><img src="../images/member/id_btn01.gif" class="pw_btn" /></button>
						<!-- <input type="image" src="../images/member/id_btn01.gif" class="id_btn" /> -->
						<!-- <a href=""><img src="../images/member/id_btn01.gif" class="pw_btn" /></a> -->
					</div>
					<!-- </form> -->
					
					
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>

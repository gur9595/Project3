<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
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
			success : function(find){
				alert(find);
			},
			error : function(e){
				alert("실패CallBack"+e.status+":"+e.statusText);
			}
		});
	});
});

function name_email_check(fn){
	
	if(fn.name.value==""){
		alert("이름 입력후 확인을 누르세요");
        fn.name.focus();
        return false;
	}
	else if(fn.email.value==""){
		alert("이메일 입력후 확인을 누르세요");
        fn.email.focus();
        return false;
	}
	
}

</script>
<style>
form{
display: inline;
}

</style>
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
							<li><input type="text" id="name" name="name" value="" class="login_input01" /></li>
							<li><input type="text" id="email" name="email" value="" class="login_input01" /></li>
						</ul>
						<input id="id_findBtn" type="image" src="../images/member/id_btn01.gif" class="id_btn" />
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
					
					<form method="post" action="./common/pw_findProc.jsp">
					<div class="pw_box">
						<ul>
							<li><input type="text" name="p_id" value="" class="login_input01" /></li>
							<li><input type="text" name="p_name" value="" class="login_input01" /></li>
							<li><input type="text" name="p_email" value="" class="login_input01" /></li>
						</ul>
						<a href=""><img src="../images/member/id_btn01.gif" class="pw_btn" /></a>
					</div>
					</form>
					
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>

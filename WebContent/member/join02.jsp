<%@page import="model1.MemberDAO"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<head>
<script src="../jquery/jquery-3.5.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zip1').value = data.zonecode;
            document.getElementById("addr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
            
        }
    }).open();
}

$(function(){
	/* $('#writeBtn').click(function(){
		$.ajax({
			url : "./common/JoinProc.jsp",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset:utf-8;",
			data:{
				name : $("#name").val(),
				id : $("#id").val(),
				pass : $("#pass").val(),
				tel1 : $("#tel1").val(),
				tel2 : $("#tel2").val(),
				tel3 : $("#tel3").val(),
				mobile1 : $("#mobile1").val(),
				mobile2 : $("#mobile2").val(),
				mobile3 : $("#mobile3").val(),
				email1 : $("#email1").val(),
				email2 : $("#email2").val(),
				zip1 : $("#zip1").val(),
				zip2 : $("#zip2").val(),
				addr1 : $("#addr1").val(),
				addr2 : $("#addr2").val()
			},
			dataType : "html",
			success : function(d){
				alert("성공");
				location.href="main.jsp";
			},
			error : function(e){
				alert("실패CallBack"+e.status+":"+e.statusText);
			}
		});
	}); */
	
	$('#pass').keyup(function(){
        $('#pass2').val("");
        $('#msg').html('');
	});
	
	$('#pass2').keyup(function(){
		var compareStr1 = $('#pass').val();
        var compareStr2 = $(this).val();
        if(compareStr1==compareStr2){
            $('#msg').html('<span style="color:red;">암호 일치</span>');
        }else{
            $('#msg').html('<span>암호 다름</span>').css('color','black');
        }
	});
	
	$('#selectEmail').change(function(){
        var text = $('#selectEmail option:selected').text();
        var value = $('#selectEmail option:selected').val();

        if(value==''){
            $('#email2').attr('readonly',true);
            $('#email2').val('');
        }else if(value=='direct'){
            $('#email2').attr('readonly',false);
            $('#email2').val('');
        }else{
            $('#email2').attr('readonly',true);
            $('#email2').val(value);
        }

    });
	
	
});

function id_check_person(fn){
	
	if(fn.id.value==""){
		alert("아이디를 입력후 중복확인을 누르세요");
        fn.id.focus();
	}else{
        fn.id.readOnly= true;
        window.open("./IdCheckForm.jsp?id="+fn.id.value, "idover", "width=500, height=200")
    }
}

function joinValidate(fn){
	
	var regex = /^[a-z0-9_]{4,12}$/;
	
	if(fn.name.value==""){
		alert("이름을 입력하세요");
		fn.name.focus();
		return false;
	}
	
	if(fn.id.value==""){
		alert("아이디를 입력하세요");
		fn.id.focus();
		return false;
	}
	
	if(!regex.test($("input[id='id']").val())){
		alert("4자 이상 12자 이내의 영문/숫자 조합으로 바꿔주세요")
		return false;
	}
	
	if(fn.pass.value==""){
		alert("패스워드를 입력하세요");
		fn.pass.focus();
		return false;
	}
	
	if(!regex.test($("input[id='pass']").val())){
		alert("4자 이상 12자 이내의 영문/숫자 조합으로 바꿔주세요")
		return false;
	}

	if(fn.pass2.value==""){
		alert("패스워드를 확인하세요");
		fn.pass2.focus();
		return false;
	}
	if(fn.tel1.value==""){
		alert("전화번호를 입력하세요");
		fn.tel1.focus();
		return false;
	}
	if(fn.tel2.value==""){
		alert("전화번호를 입력하세요");
		fn.tel2.focus();
		return false;
	}
	if(fn.tel3.value==""){
		alert("전화번호를 입력하세요");
		fn.tel3.focus();
		return false;
	}
	if(fn.mobile1.value==""){
		alert("폰번호를 입력하세요");
		fn.mobile1.focus();
		return false;
	}
	if(fn.mobile2.value==""){
		alert("폰번호를 입력하세요");
		fn.mobile2.focus();
		return false;
	}
	if(fn.mobile3.value==""){
		alert("폰번호를 입력하세요");
		fn.mobile3.focus();
		return false;
	}
	if(fn.email1.value==""){
		alert("이메일을 입력하세요");
		fn.email1.focus();
		return false;
	}
	if(fn.email2.value==""){
		alert("이메일을 입력하세요");
		fn.email2.focus();
		return false;
	}
	if(fn.zip1.value==""){
		alert("우편번호를 입력하세요");
		fn.zip1.focus();
		return false;
	}
	if(fn.addr1.value==""){
		alert("주소를 입력하세요");
		fn.addr1.focus();
		return false;
	}
	if(fn.addr2.value==""){
		alert("주소를 입력하세요");
		fn.addr2.focus();
		return false;
	}
	
}

</script>
</head>

 <body>
	<center>
	<div id="wrap" name="userInfo">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<form name="joinFrm" method="post" action="./common/JoinProc.jsp" onsubmit="return joinValidate(this);">
				
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" id="name" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id" id="id" class="join_input" />&nbsp;<a style="cursor:hand;">
						<button type="button" onclick="id_check_person(this.form);"><img src="../images/btn_idcheck.gif" alt="중복확인"/></button>
						<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" id="pass" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" id="pass2" class="join_input" />&nbsp;&nbsp;<span id="msg"></span></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" id="tel1" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" id="tel2" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" id="tel3" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" id="mobile1" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" id="mobile2" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" id="mobile3" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email1" id="email1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
	<input type="text" name="email2" id="email2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
	<select name="last_email_check2" class="pass" id="selectEmail" >
		<option selected="" value="">선택해주세요</option>
		<option value="direct" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
	</select>
	 
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zip1" id="zip1"  class="join_input" style="width:50px;" />&nbsp;-&nbsp;
						<a href="javascript:;" title="새 창으로 열림" onclick="sample6_execDaumPostcode()">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" id="addr1"  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" id="addr2"  class="join_input" style="width:550px; margin-top:5px;" />
						<input type="hidden" id="sample6_extraAddress"  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>
				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
			</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
	
 </body>
</html>

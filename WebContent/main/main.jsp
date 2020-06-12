<%@page import="java.util.Calendar"%>
<%@page import="model1.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="model1.BbsDAO"%>
<%@page import="model1.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//리퀘스트 내장객체를 이용하여 쿠키를 읽어온다
	Cookie[] cookies = request.getCookies();
	//쿠키에 저장된 아이디를 저장할 변수 생성
	String user = "";
	//쿠키가 존재한다면 전체에서 USER_ID라는 쿠키명이 있는지 찾는다.
	if (cookies != null) {
		for (Cookie ck : cookies) {
			if (ck.getName().equals("USER_ID")) {
				//찾았다면 쿠키에 저장된 쿠키값을 변수에 저장한다.
				user = ck.getValue();
			}
		}
	}

	//한글깨짐처리 - 검색폼에서 입력된 한글이 전송되기때문
	request.setCharacterEncoding("UTF-8");

	//web.xml에 저장된 컨텍스트 초기화 파라미터를 application객체를 통해 가져옴
	String drv = application.getInitParameter("MariaJDBCDriver");
	String url = application.getInitParameter("MariaConnectURL");

	//DAO객체 생성 및 DB커넥션
	BbsDAO dao = new BbsDAO(drv, url);

	List<BbsDTO> freeboard = dao.selectFreeboard("freeboard", 0, 4);

	List<BbsDTO> notice = dao.selectFreeboard("notice", 0, 4);

	List<BbsDTO> photo = dao.selectFreeboard("photo", 0, 6);

	dao.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- <%
//한글깨짐처리 - 검색폼에서 입력된 한글이 전송되기때문
request.setCharacterEncoding("UTF-8");

//web.xml에 저장된 컨텍스트 초기화 파라미터를 application객체를 통해 가져옴
String drv = application.getInitParameter("MariaJDBCDiver");
String url = application.getInitParameter("MariaConnectURL");

//DAO객체 생성 및 DB커넥션
MemberDAO dao = new MemberDAO(drv, url);

//DB자원해제
dao.close();
%>  --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>

<script src="../jquery/jquery-3.5.1.js"></script>
<%
//켈린더 클래스로 현재 년월구하기
Calendar nowDay = Calendar.getInstance();
int now_year = nowDay.get(Calendar.YEAR);
int now_month = nowDay.get(Calendar.MONTH);
%>
<input type="hidden" id="now_year" value="<%=now_year%>"/>
<!-- Calendar클래스의 월은 0~11까지 표현된다. -->
<input type="hidden" id="now_month" value="<%=now_month%>"/>

<script>
	function loginValidate(fn) {
		if (!fn.user_id.value) {
			alert("아이디를 입력하세요");
			fn.user_id.focus();
			return false;
		}
		if (fn.user_pw.value == "") {
			alert("패스워드를 입력하세요");
			fn.user_pw.focus();
			return false;
		}
	}
	
$(function () {
	//메인페이지를 로드할때
	$('#calendar_view').load('../include/Calendar.jsp');
	//이전달을 콜백받음
	$('#month_prev').click(function(){
		var n_year = parseInt($('#now_year').val());
		var n_month = parseInt($('#now_month').val());
		if(n_month==0){
			n_year--;
			n_month=11;
		}else{
			n_month--;
		}
		
		$('#now_year').val(n_year);
		$('#now_month').val(n_month);
		$('#calendar_n_view').html(n_year+"년"+(n_month+1)+'월');
		
		$.get('../include/Calendar.jsp',
			{
				y : n_year,
				m: n_month
			},
			function(d){
				$('#calender_view').html(d);
			}
		);
	});
	//다음달을 콜백받음
	$('#month_next').click(function(){
		var n_year = parseInt($('#now_year').val());
		var n_month = parseInt($('#now_month').val());
		
		if(n_month==11){
			n_year++;
			n_month=0;
		}else{
			n_month++;
		}
		$('#now_year').val(n_year);
		$('#now_month').val(n_month);
		$('#calendar_n_view').html(n_year+'년'+(n_month+1)+'월');
		
		$.ajax({
			url : "../include/Calendar.jsp",
			dataType : "html",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				y : n_year, m : n_month
			},
			success : function(responseData){
				$('#calendar_view').html(responseData);
			},
			error : function(errorData){
				alert("오류발생: "+errorData.status+":"+errorData.statusText);
			}
		});
	});
});
	
</script>
<style type="text/css" media="screen">
@import url("../css/common.css");

@import url("../css/main.css");

@import url("../css/sub.css");

</style>
</head>
<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<div id="main_visual">
				<a href="/product/sub01.jsp">
					<img src="../images/main_image_01.jpg" />
				</a>
				
				<a href="../market/sub03.jsp?bname=clean">
					<img src="../images/main_image_02.jpg" />
				</a>
				
				<a href="/product/sub01_03.jsp">
					<img src="../images/main_image_03.jpg" />
				</a>
				
				<a href="/product/sub02.jsp">
					<img src="../images/main_image_04.jpg" />
				</a>
			</div>

			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title01.gif" alt="로그인 LOGIN" />
					</p>
					<div class="login_box">
						<%
							if (session.getAttribute("USER_ID") == null) {
						%>
						<form action="../member/common/LoginProcess.jsp" method="post"
							name="loginFrm" onsubmit="return loginValidate(this);">
							<table cellpadding="0" cellspacing="0" border="0">
								<colgroup>
									<col width="45px" />
									<col width="120px" />
									<col width="55px" />
								</colgroup>
								<tr>
									<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
									<td><input type="text" name="user_id"
										value="<%=user == null ? "" : user%>" class="login_input" /></td>
									<td rowspan="2"><input type="image"
										src="../images/login_btn01.gif" alt="로그인" /></td>
								</tr>
								<tr>
									<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
									<td><input type="password" name="user_pw" value=""
										class="login_input" /></td>
								</tr>
							</table>
							<p>
								<input type="checkbox" name="id_save"
									<%if (user.length() != 0) {%> checked="checked" <%}%> /><img
									src="../images/login_tit03.gif" alt="저장" /> <a
									href="../member/id_pw.jsp"><img
									src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a> <a
									href="../member/join01.jsp"><img
									src="../images/login_btn03.gif" alt="회원가입" /></a>
							</p>
						</form>
						<%
							} else {
						%>
						<!-- 로그인 후 -->
						<p style="padding: 10px 0px 10px 10px">
							<span style="font-weight: bold; color: #333;"><%=session.getAttribute("USER_NAME")%>님,</span>
							반갑습니다.<br />로그인 하셨습니다.
						</p>
						<p style="text-align: right; padding-right: 10px;">

							<a href=""><img src="../images/login_btn04.gif" /></a> <a
								href="../member/logout.jsp"><img
								src="../images/login_btn05.gif" /></a>
						</p>
						<%
							}
						%>
					</div>
				</div>
				<!--  -->
				<div class="main_con_center" style="margin-right: 60px;">
					<p class="main_title">
						<img src="../images/main_title02.gif" alt="공지사항 NOTICE" />
						<a href="../space/sub03.jsp?bname=notice">
							<img src="../images/more.gif" alt="more" class="more_btn" />
						</a>
					</p>
					<ul class="main_board_list">
						<%
							for (BbsDTO dto : notice) {
						%>
						<li>
							<p>
								<a href="../space/sub03_view.jsp?bname=notice&num=<%=dto.getNum()%>" 
								style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 200px; display: inline-block;"><%=dto.getTitle()%></a>
								<span><%=dto.getPostDate()%></span>
							</p>
						</li>
						<%
							}
						%>
					</ul>
				</div>
				<!--  -->

				<div class="main_con_center">
					<p class="main_title">
						<img src="../images/main_title03.gif" alt="공지사항 NOTICE" />
						<a href="../space/sub03.jsp?bname=freeboard">
							<img src="../images/more.gif" alt="more" class="more_btn" />
						</a>
					</p>
					<ul class="main_board_list">
						<%
							for (BbsDTO dto : freeboard) {
						%>
						<li>
							<p>
								<a href="../space/sub03_view.jsp?bname=freeboard&num=<%=dto.getNum()%>"
								style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 200px; display: inline-block;"><%=dto.getTitle()%></a>
								<span><%=dto.getPostDate()%></span>
							</p>
						</li>
						<%
							}
						%>
					</ul>
				</div>

			</div>

			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title">
						<img src="../images/main_title04.gif" alt="월간일정 CALENDAR" />
					</p>
					<img src="../images/main_tel.gif" />
				</div>
				<div class="main_con_center">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title05.gif" alt="월간일정 CALENDAR" />
					</p>
					<div class="cal_top">
						<table cellpadding="0" cellspacing="0" border="0">
							<colgroup>
								<col width="13px;" />
								<col width="*" />
								<col width="13px;" />
							</colgroup>
							<tr>
								<!-- 이전달보기 -->
								<td>
									<img src="../images/cal_a01.gif" style="margin-top: 3px; Cursor:pointer;" id="month_prev" />
								</td>
								<!-- 년/월 표시 -->
								<td style="font-weight: bold; font-size: 24px;" id="calendar_n_view">
									2020년 06월
								</td>
								<!-- 다음달보기 -->
								<td>
									<img src="../images/cal_a02.gif" style="margin-top: 3px; Cursor:pointer;" id="month_next" />
								</td>
							</tr>
						</table>
					</div>
					<div class="cal_bottom" id="calendar_view">
						<!-- 실제 달력이 출력되는 영역 -->
						<!-- <table cellpadding="0" cellspacing="0" border="0" class="calendar">
							<colgroup>
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="*" />
							</colgroup>
							<tr>
								<th><img src="../images/day01.gif" alt="S" /></th>
								<th><img src="../images/day02.gif" alt="M" /></th>
								<th><img src="../images/day03.gif" alt="T" /></th>
								<th><img src="../images/day04.gif" alt="W" /></th>
								<th><img src="../images/day05.gif" alt="T" /></th>
								<th><img src="../images/day06.gif" alt="F" /></th>
								<th><img src="../images/day07.gif" alt="S" /></th>
							</tr>
							<tr>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">1</a></td>
								<td><a href="">2</a></td>
								<td><a href="">3</a></td>
							</tr>
							<tr>
								<td><a href="">4</a></td>
								<td><a href="">5</a></td>
								<td><a href="">6</a></td>
								<td><a href="">7</a></td>
								<td><a href="">8</a></td>
								<td><a href="">9</a></td>
								<td><a href="">10</a></td>
							</tr>
							<tr>
								<td><a href="">11</a></td>
								<td><a href="">12</a></td>
								<td><a href="">13</a></td>
								<td><a href="">14</a></td>
								<td><a href="">15</a></td>
								<td><a href="">16</a></td>
								<td><a href="">17</a></td>
							</tr>
							<tr>
								<td><a href="">18</a></td>
								<td><a href="">19</a></td>
								<td><a href="">20</a></td>
								<td><a href="">21</a></td>
								<td><a href="">22</a></td>
								<td><a href="">23</a></td>
								<td><a href="">24</a></td>
							</tr>
							<tr>
								<td><a href="">25</a></td>
								<td><a href="">26</a></td>
								<td><a href="">27</a></td>
								<td><a href="">28</a></td>
								<td><a href="">29</a></td>
								<td><a href="">30</a></td>
								<td><a href="">31</a></td>
							</tr>
							<tr>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
							</tr>
						</table> -->
					</div>
				</div>

				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" />
						<a href="../space/sub03.jsp?bname=photo">
							<img src="../images/more.gif"alt="more" class="more_btn" />
						</a>
					</p>
					<ul class="main_photo_list">
					<% for (BbsDTO dto : photo) { %>
					<li>
						<dl>
							<dt>
								<a href="../space/sub03_view.jsp?bname=photo&num=<%=dto.getNum()%>">
									<img src="../Upload/<%=dto.getImg()%>" width="85px"
									height="85px" alt="" />
								</a>
							</dt>
							<dd style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 100px; display: inline-block;"><%=dto.getTitle()%></dd>
						</dl>
					</li>
					<% } %>
				</ul>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>

		<%@ include file="../include/footer.jsp"%>

	</center>
</body>
</html>
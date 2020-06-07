<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String uri = request.getRequestURI();
String a1="", a2="", a3="", a4="", a5="", a6="";
if(uri.indexOf("adminMain")>=0){
	a1="active";
}else if(uri.indexOf("bname=notice")>=0){
	a2="active";	
}else if(uri.indexOf("bname=program")>=0){
	a3="active";	
}else if(uri.indexOf("bname=free")>=0){
	a4="active";	
}else if(uri.indexOf("bname=picture")>=0){
	a5="active";	
}else if(uri.indexOf("bname=info")>=0){
	a6="active";	
}
%>
<ul class="sidebar navbar-nav">
	<li class="nav-item active"><a class="nav-link active" href="adminMain.jsp"> <i class="fas fa-fw fa-tachometer-alt"></i>
			<span>관리자 리스트</span>
	</a></li>
	<br />
	<li class="nav-item active"><a class="nav-link active" href="board_free.jsp?bname=notice"> <i
			class="fas fa-fw fa-table"></i> <span>공지사항 관리</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link active" href="board_free.jsp?bname=program"> <i
			class="fas fa-fw fa-table"></i> <span>프로그램일정 관리</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link active" href="board_free.jsp?bname=freeboard"> <i
			class="fas fa-fw fa-table"></i> <span>자유게시판 관리</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link active" href="board_free.jsp?bname=photo"> <i
			class="fas fa-fw fa-table"></i> <span>사진게시판 관리</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link active" href="board_free.jsp?bname=info"> <i
			class="fas fa-fw fa-table"></i> <span>정보자료실 관리</span>
	</a></li>
	<br/>
	<li class="nav-item active"><a class="nav-link active" href="../admin/board_community?bname=staff"> <i
			class="fas fa-fw fa-table"></i> <span>직원자료실 관리</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link active" href="../admin/board_community?bname=bohoja"> <i
			class="fas fa-fw fa-table"></i> <span>보호자게시판 관리</span>
	</a></li>
	<br/>
	<li class="nav-item active"><a class="nav-link active" href="board_request.jsp?bname=clean"> <i
			class="fas fa-fw fa-table"></i> <span>블루크리닝 리스트</span>
	</a></li>
	<li class="nav-item active"><a class="nav-link active" href="board_request.jsp?bname=leaning"> <i
			class="fas fa-fw fa-table"></i> <span>체험학습신청 리스트</span>
	</a></li>
</ul>






<%@page import="java.net.URLEncoder"%>
<%@page import="model1.BbsDTO"%>
<%@page import="model1.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="isFlag.jsp"%>
<%@ include file="isLogin.jsp"%>
<%
	/*
	검색후 파라미터 처리를 위한 추가부분
		:리스트에서 검색후 상세보기 , 그리고 다시 리스트 보기를 
		눌렀을때 검색이 유지되도록 처리하기위한 코드삽입*/
	String queryStr = "bname=" + bname + "&";
	String searchColumn = request.getParameter("searchColumn");
	String searchWord = request.getParameter("searchWord");

	if (searchWord != null) {
		queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
	}
	//3페이지에서 상세보기 했다면 리스트로 돌아갈때도 3페이지로 가야한다
	String nowPage = request.getParameter("nowPage");
	if (nowPage == null || nowPage.equals("")) {
		nowPage = "1";
	}

	queryStr += "&nowPage=" + nowPage;

	//폼값 받기 - 파라미터로 전달된 게시물의 일련번호
	String num = request.getParameter("num");
	BbsDAO dao = new BbsDAO(application);

	//게시물의 조회수 +1증가 
	dao.updateVisitCount(num);

	//게시물을 가져와서 DTO객체로 반환
	BbsDTO dto = dao.selectView(num);

	System.out.println(dto.getName());
	System.out.println(dto.getPostDate());
	System.out.println(dto.getTitle());
	System.out.println(dto.getVisitcount());
	System.out.println(dto.getContent().replace("\r\n", "<br/>"));
	dao.close();
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>자유게시판 보기</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

	<%@ include file="./include/top.jsp"%>
	<div id="wrapper">
		<%@ include file="./include/left.jsp"%>
		<div id="content-wrapper">
			<div class="container-fluid">

				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><%=boardTitle %></li>
				</ol>
				<!-- ********************************************************************************************* -->
				<div>
						<%if(bname.equals("photo")){ %>
							
							<table class="table table-bordered">
							<colgroup>
								<col width="20%" />
								<col width="30%" />
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th class="text-center" style="vertical-align: middle;">작성자</th>
									<td><%=dto.getName()%></td>
									<th class="text-center" style="vertical-align: middle;">작성일</th>
									<td><%=dto.getPostDate()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">제목</th>
									<td><%=dto.getTitle()%></td>
									<th class="text-center" style="vertical-align: middle;">조회수</th>
									<td><%=dto.getVisitcount()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">이미지</th>
									<td colspan="3">
										<img src="../Upload/<%=dto.getImg() %>" />
									</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">내용</th>
									<td colspan="3"><%=dto.getContent().replace("\r\n", "<br/>")%>
									</td>
								</tr>
							</tbody>
						</table>
							
							
							
							
							
						<%}else if(bname.equals("info")||bname.equals("freeboard")||bname.equals("notice")){ %>
						<table class="table table-bordered">
							<colgroup>
								<col width="20%" />
								<col width="30%" />
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th class="text-center" style="vertical-align: middle;">작성자</th>
									<td><%=dto.getName()%></td>
									<th class="text-center" style="vertical-align: middle;">작성일</th>
									<td><%=dto.getPostDate()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">제목</th>
									<td><%=dto.getTitle()%></td>
									<th class="text-center" style="vertical-align: middle;">조회수</th>
									<td><%=dto.getVisitcount()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">내용</th>
									<td colspan="3"><%=dto.getContent().replace("\r\n", "<br/>")%>
									</td>
								</tr>
								<%if(bname.equals("info")){ %>
								<tr>
									<th class="text-center" style="vertical-align: middle;">첨부파일</th>
									<td colspan="3"><%=dto.getOfile()%> : 
									<a href="Download2.jsp?oName=<%=URLEncoder.encode(dto.getOfile(), "UTF-8")%>
										&sName=<%=URLEncoder.encode(dto.getSfile(), "UTF-8")%>">
										<img src="../images/disk.png" width="20" alt="" />
									   </a>
									</td>
								</tr>
								<%} %>

							</tbody>
						</table>
						
						<%} %>
						
						<div class="row text-center" style="">
							<div class="col-6">
								<%
										if (session.getAttribute("USER_ID") != null
												&& session.getAttribute("USER_ID").toString().equals(dto.getId())) {
									%>

								<button type="button" class="btn btn-primary"
									onclick="location.href='board_free_edit.jsp?num=<%=dto.getNum()%>&bname=<%=bname%>';">수정하기</button>
								<button type="button" class="btn btn-success"
									onclick="isDelete();">삭제하기</button>

								<%
										}
									%>

								<button type="button" class="btn btn-warning"
									onclick="location.href='board_free?<%=queryStr%>';">리스트보기</button>

							</div>


							<form name="deleteFrm">
								<input type="hidden" name="num" value="<%=dto.getNum()%>" /> <input
									type="hidden" name="bname" value="<%=bname%>" />
							</form>
						</div>
						<script>
							function isDelete(){
							 	var c= confirm("삭제할까요?");
							 	if(c){
							 		var f= document.deleteFrm;
							 		f.method = "post";
							 		f.action = "./common/DeleteProc.jsp";
							 		f.submit();
							 	}
							}
						</script>
					</div>


				<!-- ********************************************************************************************* -->
				<%@ include file="./include/footer.jsp"%>
			</div>
			<!-- /.content-wrapper -->
		</div>
	</div>
	<!-- /#wrapper -->

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Page level plugin JavaScript-->
	<script src="vendor/chart.js/Chart.min.js"></script>
	<script src="vendor/datatables/jquery.dataTables.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin.min.js"></script>

	<!-- Demo scripts for this page-->
	<script src="js/demo/datatables-demo.js"></script>
	<script src="js/demo/chart-area-demo.js"></script>
</body>

</html>
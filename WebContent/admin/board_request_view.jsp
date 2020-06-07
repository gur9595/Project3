<%@page import="model1.RequestDTO"%>
<%@page import="model1.RequestDAO"%>
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
	RequestDAO dao = new RequestDAO(application);

	//게시물을 가져와서 DTO객체로 반환
	RequestDTO dto = dao.selectView(num);

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
					<li class="breadcrumb-item"><%=boardTitle%></li>
				</ol>
				<!-- ********************************************************************************************* -->
				<div>
					<table cellpadding="0" cellspacing="0" border="1" class="table table-bordered"style="width: 100%;">
						<colgroup>
							<col width="25%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th>고객명/회사명</th>
								<td style="text-align: left;">
								<%=dto.getName() %>
								</td>
							</tr>

							<%
								if (request.getParameter("bname").equals("clean")) {
							%>
							<tr>
								<th>청소할 곳 주소</th>
								<td style="text-align: left;">
								<%=dto.getAddr() %>
								</td>
							</tr>

							<tr>
								<th>휴대전화</th>
								<td style="text-align: left;">
								<%=dto.getTel() %>
								</td>
							</tr>

							<tr>
								<th>청소의뢰내역</th>
								<td style="text-align: left;" style="padding:0px;">
									<table>
										<tr>
											<td>청소종류</td>
											<td>
											<%=dto.getCleanType() %>
											</td>
										</tr>
										<tr>
											<td>분양평수/등기평수</td>
											<td>
											<%=dto.getCleanArea() %>
											</td>
										</tr>
									</table>
								</td>
							</tr>

							<%
								} else if (request.getParameter("bname").equals("leaning")) {
							%>
							<tr>
								<th>장애유무</th>
								<td style="text-align: left;" style="padding:0px;">
									<table cellpadding="0" cellspacing="0" border="0"
										>
										<tr>
											<td>
											<%=dto.getDisorder() %>
											</td>
											<th>주요장애유형</th>
											<td>
											<%=dto.getDisorderType() %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>보장구 사용유무</th>
								<td style="text-align: left;" style="padding:0px;">
									<table cellpadding="0" cellspacing="0" border="0"
										>
										<tr>
											<td>
											<%=dto.getBojanggu() %>
											</td>
											<th>보장구 명</th>
											<td>
											<%=dto.getBojangguName() %>
											</td>
										</tr>
									</table>
								</td>
							</tr>

							<tr>
								<th>담당자 휴대전화</th>
								<td style="text-align: left;">
								<%=dto.getAdminTel() %>
								</td>
							</tr>

							<tr>
								<th>체험내용</th>
								<td style="text-align: left;" style="padding:0px;">
									<table cellpadding="0" cellspacing="0" border="0"
										>
										<tr>
											<td>케익체험</td>
											<td>
											<%=dto.getCake() %>
											</td>
										</tr>
										<tr>
											<td>쿠키체험</td>
											<td>
											<%=dto.getCookie() %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<th>희망날짜</th>
								<td style="text-align: left;">
								<%=dto.getHopeDate() %>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td style="text-align: left;">
								<%=dto.getPhone() %>
								</td>
							</tr>

							<tr>
								<th>이메일</th>
								<td style="text-align: left;">
								<%=dto.getEmail() %>
								</td>
							</tr>

							<tr>
								<th>접수종류 구분</th>
								<td style="text-align: left;">
								<%=dto.getRegiType() %>
								</td>
							</tr>
							<tr>
								<th>기타특이사항</th>
								<td style="text-align: left;">
								<%=dto.getNote() %>
								</td>
							</tr>
						</tbody>
					</table>
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
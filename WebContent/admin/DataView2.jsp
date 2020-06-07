<%@page import="java.net.URLEncoder"%>
<%@page import="model1.BbsDTO"%>
<%@page import="model1.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="isFlag.jsp"%>
<%@ include file="isLogin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				<!-- *********************************** 입력 부 분 ******************************************************* -->
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th class="text-center table-active align-middle">작성자</th>
								<td colspan="3">${dto.id }</td>
							</tr>
							<tr>
								<th class="text-center table-active align-middle">작성일</th>
								<td>${dto.postDate }</td>
								<th class="text-center table-active align-middle">조회수</th>
								<td>${dto.visitcount }</td>
							</tr>
							<tr>
								<th class="text-center table-active align-middle">제목</th>
								<td colspan="3">${dto.title }</td>
							</tr>
							<tr>
								<th class="text-center table-active align-middle">내용</th>
								<td colspan="3" class="align-middle" style="height: 200px;">
									${dto.content }</td>
							</tr>
							<tr>
								<th class="text-center table-active align-middle">첨부파일</th>
								<td colspan="3">
									<!-- 첨부파일이 있는 경우에만 디스플레이 함 --> 
									<c:if test="${not empty dto.attachedfile }">
                        				${dto.attachedfile }
                        				<a href="./Download2?filename=${dto.attachedfile }"> 
                        				<img src="../images/disk.png" width="20" alt="" />
										</a>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="row text-center" style="">
						<div class="col-6">
							
							<button type="button" class="btn btn-secondary"
								onclick="location.href='../admin/DataEdit2?bname=<%=request.getParameter("bname")%>&num=${param.num}&mode=edit&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
								수정하기</button>

							<button type="button" class="btn btn-success"
								onclick="location.href='../admin/DataDelete2?bname=${param.bname }&num=${dto.num}&mode=delete&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
								삭제하기</button>

						</div>
						<div class="col-6 text-right pr-5">
							<button type="button" class="btn btn-warning"
								onclick="location.href='./board_community?bname=<%=request.getParameter("bname")%>&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
								리스트보기</button>
						</div>
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
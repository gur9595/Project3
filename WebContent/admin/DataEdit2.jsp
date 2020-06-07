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
					<div class="row mt-3 mr-1">
						<table class="table table-bordered table-striped">

							<!--  
					파일 업로드를 위해서는 반드시 enctype을 선언해야 한다. 그렇지
					않으면 파일은 서버로 전송되지 않는다.
				-->
							<form name="writeFrm" method="post" action="../admin/DataEdit2"
								enctype="multipart/form-data"
								onsubmit="return checkValidate(this);">
								<input type="hidden" name="num" value="${dto.num }" /> 
								<input type="hidden" name="nowPage" value="${param.nowPage }" />
								<input type="hidden" name="bname" value="${param.bname }" />
								
								<!-- 
					기존에 등록한 파일이 있는경우 수정시 첨부하지 않으면 기존파일을 
					유지해야하므로 별도의 hidden폼이 필요하다
					즉 새로운 파일을 등록하면 새로운값으로 업데이트하고
					파일을 등록하지 않으면 기존파일명으로 데이터를 유지하게된다
					 -->
								<input type="hidden" name="originalfile" value="${dto.attachedfile }" />

								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th class="text-center align-middle">작성자</th>
										<td><input type="text" class="form-control"
											style="width: 100px;" name="name" value="${dto.name }" readonly="readonly"/></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" class="form-control" name="title"
											value="${dto.title }" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" class="form-control"
												name="content">${dto.content }</textarea></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">첨부파일</th>
										<td>첨부파일명 : ${dto.attachedfile } <input type="file"
											class="form-control" name="attachedfile" />
										</td>
									</tr>
								</tbody>
						</table>
					</div>
					<div class="row mb-3">
						<div class="col text-right">
							<button type="submit" class="btn btn-danger">전송하기</button>
							<button type="reset" class="btn btn-dark">Reset</button>
							<button type="button" class="btn btn-warning"
								onclick="location.href='../community/sub02.do?bname=${param.bname }&nowPage=${param.nowPage}';">리스트보기</button>
						</div>
						</form>
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
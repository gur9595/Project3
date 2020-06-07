<%@page import="model1.BbsDTO"%>
<%@page import="model1.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="isFlag.jsp"%>
<%@ include file="isLogin.jsp"%>
<%
	//폼값 받기 - 파라미터로 전달된 게시물의 일련번호
	String num = request.getParameter("num");
	BbsDAO dao = new BbsDAO(application);

	//게시물을 가져와서 DTO객체로 반환
	BbsDTO dto = dao.selectView(num);
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

<title>관리</title>

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
						<%if(bname.equals("freeboard")||bname.equals("notice")) {%>
						<form name="editFrm" method="post" action="./proc/AdminEditProc.jsp" >
							<input type="hidden" name="num" value="<%=dto.getNum()%>" /> 
							
							<input type="hidden" name="bname" value="<%=bname%>" />
							<table class="table table-bordered">
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" name="title" class="form-control"
											value="<%=dto.getTitle()%>" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" name="content"
												class="form-control"><%=dto.getContent()%></textarea></td>
									</tr>
									
								</tbody>
							</table>

							<div class="row text-center" style="">
								<!-- 각종 버튼 부분 -->

								<button type="submit" class="btn btn-danger">전송하기</button>
								<button type="reset" class="btn">Reset</button>
								<button type="button" class="btn btn-warning"
									onclick="location.href='sub03.jsp?bname=<%=bname %>';">리스트보기</button>
							</div>
						</form>
						<%}else if(bname.equals("info")) {%>
						
						<form name="editFrm" method="post" action="./proc/AdminUploadProc_edit.jsp" enctype="multipart/form-data">
							<input type="hidden" name="num" value="<%=dto.getNum()%>" /> 
							
							<input type="hidden" name="bname" value="<%=bname%>" />
							<table class="table table-bordered">
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" name="title" class="form-control"
											value="<%=dto.getTitle()%>" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" name="content"
												class="form-control"><%=dto.getContent()%></textarea></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">첨부파일</th>
										<td><input type="file" name="chumFile1" class="form-control" value="<%=dto.getOfile()%>"/></td>
									</tr>
								</tbody>
							</table>
							<div class="row text-center" style="">
								<!-- 각종 버튼 부분 -->
								<button type="submit" class="btn btn-danger">전송하기</button>
								<button type="reset" class="btn">Reset</button>
								<button type="button" class="btn btn-warning"
									onclick="location.href='sub03.jsp?bname=<%=bname %>';">리스트보기</button>
							</div>
						</form>
						<%}else if(bname.equals("photo")){ %>
						<form name="editFrm" method="post" action="./proc/AdminUploadProc_img_edit.jsp" enctype="multipart/form-data">
							<input type="hidden" name="num" value="<%=dto.getNum()%>" /> 
							
							<input type="hidden" name="bname" value="<%=bname%>" />
							<table class="table table-bordered">
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" name="title" class="form-control"
											value="<%=dto.getTitle()%>" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" name="content"
												class="form-control"><%=dto.getContent()%></textarea></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">이미지</th>
										<<td><input type="file" name="img" class="form-control" /></td>
									</tr>
								</tbody>
							</table>
							<div class="row text-center" style="">
								<!-- 각종 버튼 부분 -->
								<button type="submit" class="btn btn-danger">전송하기</button>
								<button type="reset" class="btn">Reset</button>
								<button type="button" class="btn btn-warning"
									onclick="location.href='sub03.jsp?bname=<%=bname %>';">리스트보기</button>
							</div>
						</form>
						<%} %>

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
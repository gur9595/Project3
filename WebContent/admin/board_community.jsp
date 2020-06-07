<%@page import="java.net.URLEncoder"%>
<%@page import="util.PagingUtil"%>
<%@page import="model1.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="isFlag.jsp"%>
<%@ include file="isLogin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>자유게시판 관리</title>

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
				<!-- *********************************** 검 색 부 분 *********************************************** -->
				<div class="row">
					<form class="form-inline ml-auto" name="searchFrm" method="get">
						<!-- 검색시 필수파라미터인 bname이 전달되어야한다. -->
						<input type="hidden" name="bname" value="<%=bname%>" />

						<div class="form-group">
							<select name="searchColumn" class="form-control">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
						</div>
						<div class="input-group">
							<input type="text" name="searchWord" class="form-control" />
							<div class="input-group-btn">
								<button type="submit" class="btn btn-warning">
									<i class='fa fa-search' style='font-size: 20px'></i>
								</button>
							</div>
						</div>
					</form>
				</div>
				<!-- *********************************** 리 스 트 부 분 ******************************************************* -->
				<div class="row mt-3">
					<!-- 게시판리스트부분 -->
					<table class="table table-bordered table-hover table-striped">
						<colgroup>
							<col width="60px" />
							<col width="*" />
							<col width="120px" />
							<col width="120px" />
							<col width="80px" />
							<col width="60px" />
						</colgroup>
						<thead>
							<tr style="background-color: rgb(133, 133, 133);"
								class="text-center text-white">
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
								<th>첨부</th>
							</tr>
						</thead>
						<tbody>
							<!-- 
				ListCtrl 서블릿에서 request영역에 저장한 ResultSet을 JSTL과 EL을 통해 화면에 내용을 출력한다
					choose
						when ->list 컬렉션에 아무값도 없을때
						otherwise - > ResultSet 결과가 있을때 즉 출력할 레코드가 있을때
				 -->
							<c:choose>
								<c:when test="${empty lists }">
									<tr>
										<td colspan="6" align="center" height="100">등록된 게시물이
											없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${lists }" var="row" varStatus="loop">
										<tr>
											<td class="text-center">${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index) }
											</td>
											<td class="text-left"><a
												href="../admin/DataView2?bname=${row.bname }&num=${row.num}&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }">
													${row.title } </a></td>
											<td class="text-center">${row.id }</td>
											<td class="text-center">${row.postDate }</td>
											<td class="text-center">${row.visitcount }</td>
											<td class="text-center"><c:if
													test="${not empty row.attachedfile }">
													<a href="./Download2?filename=${row.attachedfile }"> <img
														src="../images/disk.png" width="20" alt="" />
													</a>
												</c:if></td>
										</tr>
						</tbody>
						</c:forEach>
						</c:otherwise>
						</c:choose>
					</table>
				</div>

				<!-- ****************************************각종 버튼 부분 *************************-->
				<div class="row">
					<div class="col text-right">
						<!-- <button type="button" class="btn">Basic</button> -->
						<button type="button" class="btn btn-primary"
							onclick="location.href='../community/DataWrite?bname=<%=request.getParameter("bname")%>';">글쓰기</button>
					</div>
				</div>

				<div class="row mt-3">
					<div class="col">
						<!-- ****************************페이지번호 부분*************************************-->
						<%-- <div style="text-align: center; padding: 0 0 10px 0;">
					${map.pagingImg }
					</div> --%>
						<!-- 페이지번호 부트스트랩4 적용 -->
						<ul class='pagination justify-content-center'>
							${map.pagingImg }
						</ul>
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
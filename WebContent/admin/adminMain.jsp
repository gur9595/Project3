<%@page import="java.net.URLEncoder"%>
<%@page import="util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>수아밀 관리자 페이지</title>

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
	<%@ include file="isLogin.jsp"%>
	<%@ include file="./include/top.jsp"%>
	<div id="wrapper">
		<%@ include file="./include/left.jsp"%>
		<div id="content-wrapper">
			<div class="container-fluid">

				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item">관리자 리스트</li>
				</ol>
				<!-- ********************************************************************************************* -->
					<!-- 게시판리스트부분 -->
					<%-- <table class="table table-bordered table-hover table-striped">
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
								<%
									if (bname.equals("info")) {
								%>
								<th>첨부파일</th>
								<%
									}
								%>
							</tr>
						</thead>
						<tbody>
							<%
								//List컬렉션에 입력된 데이터가 없을때 true를 반환. 
								if (bbs.isEmpty()) {
							%>
							<tr>
								<td colspan="6" align="center" height="100">등록된 게시물이 없습니다.
								</td>
							</tr>
							<%
								} else {
									//게시물의 가상번호로 사용할 변수
									int vNum = 0;
									int countNum = 0;

									/*
									컬렉션에 입력된 데이터가 있다면 저장된 BbsDTO의 갯수만큼
									즉, DB가 반환해준 레코드의 갯수만큼 반복하면서 출력한다. 
									*/
									for (BbsDTO dto : bbs) {
										//전체 레코드수를 이용하여 하나씩 차감하면서 가상번호 부여
										vNum = totalRecordCount - (((nowPage - 1) * pageSize) + countNum++);
										/*
										전체게시물수 : 106개
										페이지사이즈 : 10
										
										현제페이지1
											첫번째게시물 : 107-(((1-1)*10)+10)= 107
											두번째게시물 : 107-(((1-1)*10)+10)= 106
										현제페이지2
											첫번째게시물 : 107-(((2-1)*10)+10)= 97
											두번째게시물 : 107-(((2-1)*10)+10)= 96
												
										*/
							%>
							<!-- 리스트반복 start -->
							<tr>
								<td class="text-center"><%=vNum%></td>
								<td class="text-left"><a
									href="board_free_view.jsp?num=<%=dto.getNum()%>&nowPage=<%=nowPage%>&<%=queryStr%>"><%=dto.getTitle()%></a>
								</td>
								<td class="text-center"><%=dto.getId()%></td>
								<td class="text-center"><%=dto.getPostDate()%></td>
								<td class="text-center"><%=dto.getVisitcount()%></td>
								<%
									if (bname.equals("info")) {
								%>
								<td class="text-center">
									<%
										if (dto.getOfile() != null || dto.getSfile() != null) {

									%> <a href="Download2.jsp?oName=<%=URLEncoder.encode(dto.getOfile(), "UTF-8")%>
										&sName=<%=URLEncoder.encode(dto.getSfile(), "UTF-8")%>">
										<img src="../images/disk.png" width="20" alt="" />
									   </a> 
									<%}%>
								</td>
								<%}%>
							</tr>
							<!-- 리스트반복 end -->
							<%
								}
								}
							%>
						</tbody>
					</table>
					
				</div>
				<!-- ******************************* 버 튼 부 분****************************************************** -->

				<div class="row">
					<div class="col text-right">
						<!-- 각종 버튼 부분 -->
						<!-- 자유게시판과 질문과답변에서만  글쓰기버튼처리-->

						
						<button type="button" class="btn btn-primary"
							onclick="location.href='sub03_write.jsp?bname=<%=bname%>';">글쓰기</button>
						

					</div>
				</div>

				<!-- ******************************* 페 이 지 번 호 부 분 ************************************************************** -->

				<div class="row mt-3">
					<div class="col">

						<ul class="pagination justify-content-center">
							<%=PagingUtil.pagingBS4(totalRecordCount, pageSize, blockPage, nowPage, "board_free.jsp?" + queryStr)%>
						</ul>
					</div>
				</div> --%>


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
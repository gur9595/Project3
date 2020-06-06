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
<%
	//한글깨짐처리 - 검색폼에서 입력된 한글이 전송되기때문
	request.setCharacterEncoding("UTF-8");

	//web.xml에 저장된 컨텍스트 초기화 파라미터를 application객체를 통해 가져옴
	String drv = application.getInitParameter("MariaJDBCDriver");
	String url = application.getInitParameter("MariaConnectURL");

	//DAO객체 생성 및 DB커넥션
	BbsDAO dao = new BbsDAO(drv, url);

	/*
	파라미터를 저장할 용도로 생성한 Map컬렉션. 여러개의 파라미터가
	있는경우 한꺼번에 저장한 후 DAO로 전달할것임.
	*/
	Map<String, Object> param = new HashMap<String, Object>();

	//필수파라미터인 bname을 DAO로 전달하기위해 Map컬렉션에 저장한다
	param.put("bname", bname);

	//폼값을 받아서 파라미터를 저장할 변수 생성
	String queryStr = ""; //검색시 페이지번호로 퀴리스트링을 넘겨주기 위한용도

	//필수파라미터에 대한 쿼리스트링 처리
	queryStr = "bname=" + bname + "&";

	//검색어 입력시 전송된 폼값을 받아 Map에 저장
	String searchColumn = request.getParameter("searchColumn");
	String searchWord = request.getParameter("searchWord");
	if (searchWord != null) {
		//검색어를 입력한 경우 Map에 값을 입력함.
		param.put("Column", searchColumn);
		param.put("Word", searchWord);

		//검색어가 있을때 쿼리스트링을 만들어준다.
		queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
	}

	//board테이블에 입력된 전체 레코드 갯수를 카운트하여 반환받음
	int totalRecordCount = dao.getTotalRecordCount(param);

	//web.xml의 초기화 파라미커 가져와서 정수로 변경후 저장
	int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
	int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

	//전체페이지수 계산=>105개 /10 => 10.5 => ceil(10.5)=>11
	int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);

	/*
	현제 페이지번호 : 파라미커가 없을때는 무조건 1페이지로 지정하고 
				있을때는 해당 값을 얻어와서 지정한다 
				즉 리스트에 처음 진입했을때 1페이지가 된다
	*/
	int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals("")) ? 1
			: Integer.parseInt(request.getParameter("nowPage"));

	//MariaDB를 통해 한페이지에 출력할 게시물의 범위를 결정한다.
	//limit의 첫번쨰 인자 : 시작인덱스
	int start = (nowPage - 1) * pageSize;
	//limit의 두번째 인자 : 가져올 레코드의 갯수
	int end = pageSize;

	//게시물의 범위를 Map컬렉션에 저장하고 DAO로 전달한다
	param.put("start", start);
	param.put("end", end);

	//조건에 맞는 레코드를 select하여 결과셋을 List컬렉션으로 반환받음
	List<BbsDTO> bbs = dao.selectListPage(param);

	//DB자원해제
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
					<li class="breadcrumb-item"><%=boardTitle %></li>
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
				<%if(bname.equals("photo")){ %>
				<%
					//List컬렉션에 입력된 데이터가 없을때 true를 반환. 
					if (bbs.isEmpty()) {
				%>
				<table>
					<tr>
						<td>등록된 게시물이 없습니다</td>
					</tr>
				</table>
				<%}else{ 
					int vNum = 0;
					int countNum = 0;

					for (BbsDTO dto : bbs) {
						vNum = totalRecordCount - (((nowPage - 1) * pageSize) + countNum++);
				%>
				<table style="margin-bottom: 20px; margin-left: 20px; margin-right: 20px; margin-top: 20px">
					<tr>
						<td colspan="2">게시물 번호 : <%=vNum%> </td>
					</tr>
					<tr>
						<td colspan="2">
						<a href="board_free_view.jsp?num=<%=dto.getNum()%>&nowPage=<%=nowPage%>&<%=queryStr%>">
						<img src="../Upload/<%=dto.getImg() %>" width="200" height="200"/>
						</a>
						</td>
					</tr>
					<tr>
						<td colspan="2">타이틀 : <%=dto.getTitle() %></td>
					</tr>
					<tr>
						<td colspan="2">아이디 : <%=dto.getId()%></td>
					</tr>
					<tr>
						<td>날짜 : <%=dto.getPostDate()%></td>
						<td>조회수 : <%=dto.getVisitcount() %></td>
					</tr>
				</table>
				<%} %>
				<%} %>
				
				<%}else if(bname.equals("info")||bname.equals("freeboard")||bname.equals("notice")){ %>
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
					<%} %>
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
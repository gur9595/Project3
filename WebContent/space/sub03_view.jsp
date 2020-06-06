<%@page import="java.net.URLEncoder"%>
<%@page import="model1.MemberDTO"%>
<%@page import="model1.BbsDTO"%>
<%@page import="model1.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%@ include file="../member/common/isFlag.jsp"%>
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
	

	dao.close();
%>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/space/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">
					<%@ include file="../include/space_leftmenu.jsp"%>
				</div>
				<div class="right_contents">
					<div class="top_title">
					
						<%
						if (bname.equals("notice")) {
					%>
					<img src="../images/space/sub01_title.gif" class="con_title" />
					<%
						} else if (bname.equals("program")) {
					%>
					<img src="../images/space/sub02_title.gif" class="con_title" />
					<%
						} else if (bname.equals("freeboard")) {
					%>
					<img src="../images/space/sub03_title.gif" class="con_title" />
					<%
						} else if (bname.equals("photo")) {
					%>
					<img src="../images/space/sub04_title.gif" class="con_title" />
					<%
						} else if (bname.equals("info")) {
					%>
					<img src="../images/space/sub05_title.gif" class="con_title" />
					<%
						}
					%>
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardTitle%>
					<p>
						
					</div>
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
									onclick="location.href='sub03_edit.jsp?num=<%=dto.getNum()%>&bname=<%=bname%>';">수정하기</button>
								<button type="button" class="btn btn-success"
									onclick="isDelete();">삭제하기</button>

								<%
										}
									%>

								<button type="button" class="btn btn-warning"
									onclick="location.href='sub03.jsp?<%=queryStr%>';">리스트보기</button>

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
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>


		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
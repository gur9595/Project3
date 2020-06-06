<%@page import="model1.BbsDAO"%>
<%@page import="model1.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%@include file="../member/common/isLogin.jsp"%>
<%@include file="../member/common/isFlag.jsp"%>
<%
	//폼값 받기 - 파라미터로 전달된 게시물의 일련번호
	String num = request.getParameter("num");
	BbsDAO dao = new BbsDAO(application);

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
						<%if(bname.equals("freeboard")||bname.equals("notice")) {%>
						<form name="editFrm" method="post" action="./common/EditProc.jsp" >
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
						
						<form name="editFrm" method="post" action="./common/UploadProc_Edit.jsp" enctype="multipart/form-data">
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
						<form name="editFrm" method="post" action="./common/UploadProc_img_edit.jsp" enctype="multipart/form-data">
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
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>


		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
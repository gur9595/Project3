<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/global_head.jsp"%>
<%@ include file="../member/common/isFlag.jsp"%>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/community/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">

					<%@ include file="../include/community_leftmenu.jsp"%>
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
							} else if (bname.equals("bohoja")) {
						%>
						<img src="../images/community/sub02_title.gif" class="con_title" />
						<%
							} else if (bname.equals("staff")) {
						%>
						<img src="../images/community/sub01_title.gif" class="con_title" />
						<%
							}
						%>
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardTitle%>
						<p>
					</div>
					<!-- *********************************** 입력 부 분 ******************************************************* -->
					<form action="../community/DataWrite" name="writeFrm" method="post" 
						enctype="multipart/form-data">
							<input type="hidden" name="id" value="<%=session.getAttribute("USER_ID")%>" />
							<input type="hidden" name="bname" value="<%=bname%>" />
							<table class="table table-bordered">
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" name="title" class="form-control" />
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" name="content"
												class="form-control"></textarea></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">첨부파일</th>
										<td><input type="file" name="attachedfile"
											class="form-control" /></td>
									</tr>
								</tbody>
							</table>

							<div class="row text-center" style="">
								<!-- 각종 버튼 부분 -->

								<button type="submit" class="btn btn-danger">전송하기</button>
								<button type="reset" class="btn">Reset</button>
								<button type="button" class="btn btn-warning"
									onclick="location.href='../space/sub03.jsp';">리스트보기</button>
							</div>
						</form>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
		</div>
		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>

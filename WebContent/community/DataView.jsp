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
                        				<a href="./Download?filename=${dto.attachedfile }"> 
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
								onclick="location.href='../community/DataEdit?bname=<%=request.getParameter("bname")%>&num=${param.num}&mode=edit&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
								수정하기</button>

							<button type="button" class="btn btn-success"
								onclick="location.href='../community/DataDelete?bname=${param.bname }&num=${dto.num}&mode=delete&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
								삭제하기</button>

						</div>
						<div class="col-6 text-right pr-5">
							<button type="button" class="btn btn-warning"
								onclick="location.href='./sub02.do?bname=<%=request.getParameter("bname")%>&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
								리스트보기</button>
						</div>
					</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
		</div>
		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>

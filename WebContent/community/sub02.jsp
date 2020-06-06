<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../member/common/isFlag.jsp"%>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
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
						} else if (bname.equals("bohoja")){
					%>
					<img src="../images/community/sub02_title.gif" class="con_title" />
					<%
						} else if (bname.equals("staff")){
					%>
					<img src="../images/community/sub01_title.gif" class="con_title" />
					<%} %>
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=boardTitle%>
					<p>
				</div>
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
					<col width="60px"/>
					<col width="*"/>
					<col width="120px"/>
					<col width="120px"/>
					<col width="80px"/>
					<col width="60px"/>
				</colgroup>				
				<thead>
				<tr style="background-color: rgb(133, 133, 133); " class="text-center text-white">
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
	 					<td colspan="6" align="center" height="100">
	 						등록된 게시물이 없습니다. 
	 					</td>
	 				</tr>
	 		</c:when>
 			<c:otherwise>
	 			<c:forEach items="${lists }" var="row" varStatus = "loop">
					<tr>
						<td class="text-center">
							${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index) }
						</td>
						<td class="text-left">
							<a href="../community/DataView?bname=${row.bname }&num=${row.num}&nowPage=${param.nowPage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }">
								${row.title }
							</a>
						</td>
						<td class="text-center">${row.id }</td>
						<td class="text-center">${row.postDate }</td>
						<td class="text-center">${row.visitcount }</td>
						<td class="text-center">
						<c:if test= "${not empty row.attachedfile }">
						<a href="./Download?filename=${row.attachedfile }">
							<img src="../images/disk.png" width="20" alt="" />
						</a>
						</c:if>
						</td>
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
			
			
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>

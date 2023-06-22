<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	//유효성 검사
	if(request.getParameterValues("oqNo")==null
		|| session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	// 값 받아오기
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	String id = (String)session.getAttribute("loginId");
	System.out.println(id);
	
	//OrderDao 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	// employ레벨 확인
	int empLevel = employeesdao.checkEmployees(id);

	// 7) 1대1문의 상세 페이지불러오기
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = csdao.oneCs(oqNo);
	
	// 10) 1대1 문의 답변 불러오기
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	list2 = csdao.etcAnswerList(oqNo);
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>1대1 문의 상세보기</title>
</head>

<body>
	 <!-- 검색 최상단 호출 -->
    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<!-- nav 호출 -->
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
    <!-- Faq Section Begin -->
    <div class="faq-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                	<div class="row">
                		<div class="col-lg-1">
                		</div>
                		<div class="col-lg-1" style="border-left: 1px solid #D5D5D5;">
                		</div>
                		<div class="col-lg-8">
		                	<h2>1대1 상세보기</h2>
		                	<%
								for(HashMap<String,Object> m : list){
									if(m.get("id").equals(id)) {
							%>
				                	<div>
				                		<a class="btn btn-outline-secondary btn-sm" style="float:right; margin-right:10px;" href="<%=request.getContextPath() %>/cs/deleteEtcCsOneAction.jsp?oqNo=<%=oqNo %>">삭제하기</a>
					                	<a class="btn btn-outline-secondary btn-sm" style="float:right; margin-right:10px;" href="#" onclick="openNewWindow()">수정하기</a>
				                	</div>
		                	<%
									}
								}
		                	%>
		                	<br><br>
		                	<form action="<%=request.getContextPath() %>/cs/insertEtcCsAnswerAction.jsp" method="post">
			                	<table class="table">
									<%
										for(HashMap<String,Object> m : list){
									%>
										<tr>
											<th colspan="2" style="width:500px; font-size:18pt;">
												제목: <%=(String)m.get("oqTitle") %>
											</th>
										</tr>
										<tr>
											<th colsapn="2" style="height:500px;">
												<%=(String)m.get("oqContent") %>
											</th>
										</tr>
									<%
										}
									%>
										<tr>
											<%
												//일반 고객일 경우 댓글 작성
												if(empLevel==0){
											%>
												<td>
													<label for="comment">댓글 작성&nbsp;&nbsp;&nbsp;<sapn style="font-weight:bold;"><%=id %></sapn></label>
													<textarea class="form-control" rows="5" id="comment" name="oaContent"></textarea>
												</td>
												<td style="width:100px;">
													<button class="btn btn-secondary" style="margin-top: 130px;" type="submit">작성</button>
													<input type="hidden" name="oqNo" value="<%=oqNo %>">
												</td>
											<%
												// 관리자 일경우 댓글작성
												} else if (empLevel>0){
											%>
												<td>
													<label for="comment">댓글 작성&nbsp;&nbsp;&nbsp;<sapn style="font-weight:bold;">관리자</sapn></label>
													<textarea class="form-control" rows="5" id="comment" name="oaContent"></textarea>
												</td>
												<td style="width:100px;">
													<button class="btn btn-secondary" style="margin-top: 130px;" type="submit">작성</button>
													<input type="hidden" name="oqNo" value="<%=oqNo %>">
												</td>
											<%
												}
											%>
										</tr>
								</table>
							</form>
							<h4>💬댓글</h4>
							<hr>
							<%
								for(HashMap<String,Object> m : list2){
							%>
							<table class="table">
								<tr>
									<th style="font-size:10pt; background-color: #F6F6F6;">
										<%
											if((int)m.get("checked")==1){
										%>
											관리자
										<%
											} else {
										%>
											<%=(String)m.get("id") %>
										<%
											}
										%>
										<div style="float:right; color:#BDBDBD;">
											<%=(String)m.get("updatedate") %>
										<%
											if(m.get("id").equals(id) || empLevel>0){
										%>
											<a style="text-decoration: none; color:#000000;" href="<%=request.getContextPath()%>/cs/deleteEtcCsCommentAction.jsp?oaNo=<%=(int)m.get("oaNo") %>&oqNo=<%=oqNo%>">삭제</a>
										<%
											}
										%>
										</div>
									</th>
								</tr>
								<tr>
									<td style="font-size:12pt;">
										<%=(String)m.get("oaContent") %>
									</td>
								</tr>
							</table><br>
							<%
								}
							%>
						</div><!-- col-lg-8 -->
						<div class="col-lg-1" style="border-right:1px solid #D5D5D5;">
						</div>
						<div class="col-lg-1">
						</div>
					</div><!-- row -->
                </div><!-- col lg 12 -->
            </div>
        </div>
    </div>
    <!-- Faq Section End -->

<script>
	function openNewWindow() {
		var url = "<%=request.getContextPath() %>/cs/updateEtcCsOne.jsp?oqNo=<%=oqNo %>";
		window.open(url, '문의 내용 수정', 'width=500,height=500');
	}
</script>
</body>

</html>
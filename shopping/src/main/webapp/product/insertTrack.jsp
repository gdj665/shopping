<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if(session.getAttribute("loginId") == null){
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//값 받기
	String id = (String)session.getAttribute("loginId");
	
	// EmployeesDao 선언
	EmployeesDao ed = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 유의성 검사
	
	if (request.getParameter("productNo") == null
			|| request.getParameter("totalTrackCnt") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// param값 선언
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int totalTrackCnt = Integer.parseInt(request.getParameter("totalTrackCnt"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<hr>
	<h4>수록곡 입력</h4>
	<hr>
	<form action="<%=request.getContextPath()%>/product/insertTrackAction.jsp" method="post">
		<input type="hidden" name="productNo" value="<%=productNo%>">
		<input type="hidden" name="totalTrackCnt" value="<%=totalTrackCnt%>">
		<table class="table">
			<tr>
				<th>곡 번호</th>
				<th>곡 정보</th>
				<th>재생 시간</th>
			</tr>
	<%
			// 입력한 수록곡 수만큼 input 출력
			for(int i = 0; i < totalTrackCnt; i++){
	%>
				<tr>
					<td>
						<%=i + 1%>
						<input type="hidden" name="trackNo" value ="<%=i + 1%>">
					</td>
					<td>
						<input type="text" name="trackName" required="required">
					</td>
					<td>
						<input type="number" name="trackTime" required="required">
					</td>
				</tr>
	<%
			}
	%>
		</table>
		<button class="btn btn-outline-danger" type="submit">입력</button>
		<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/product/deleteProductAction.jsp?productNo=<%=productNo%>">
			취소
		</a>
	</form>
</body>
</html>
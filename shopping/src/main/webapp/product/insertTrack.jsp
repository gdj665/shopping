<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* if (request.getParameter("productNo") == null
			|| request.getParameter("totalTrackCnt") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	} */
	// int productNo = Integer.parseInt(request.getParameter("productNo"));
	int productNo = 1; 
	// int totalTrackCnt = Integer.parseInt(request.getParameter("totalTrackCnt"));
	int totalTrackCnt = 2;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=productNo%> 수록곡 입력</h1>
	<form action="<%=request.getContextPath()%>/product/insertTrackAction.jsp" method="post">
		<input type="hidden" name="productNo" value="<%=productNo%>">
		<input type="hidden" name="totalTrackCnt" value="<%=totalTrackCnt%>">
		<table>
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
		<button type="submit">입력</button>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의글 작성페이지</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/cs/insertEtcCsListAction.jsp">
		<table>
			<tr>
				<th>제목</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="oqTitle">
				</td>
			</tr>
			<tr>
				<th>내용</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="oqContent">
				</td>
			</tr>
		</table>
		<button type="submit">전송</button>
	</form>
</body>
</html>
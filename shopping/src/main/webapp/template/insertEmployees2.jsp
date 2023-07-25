<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>직원 추가</h1>
	<form action="<%=request.getContextPath()%>/employees/insertEmployeesAction.jsp" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="employeesId" required="required">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="employeesPw" required="required">
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="checkPw" required="required">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text"  name="employeesName" required="required">
				</td>
			</tr>
			<tr>
				<th>레벨</th>
				<td>
					<input type="number" name="employeesLevel" required="required">
				</td>
			</tr>
		</table>
		<button type="submit">추가</button>
	</form>
</body>
</html>
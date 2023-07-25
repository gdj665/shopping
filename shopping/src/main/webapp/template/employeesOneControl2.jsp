<%@page import="vo.id.Employees"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("employeesId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	String employeesId = request.getParameter("employeesId");
	EmployeesDao ed = new EmployeesDao();
	Employees employees = new Employees();
	employees = ed.selectEmployees(employeesId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>직원 관리</h1>
	<form action="<%=request.getContextPath()%>/employees/updateEmployeesAction.jsp" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="hidden" value="<%=employees.getId()%>" name="preEmployeesId">
					<input type="text" value="<%=employees.getId()%>" name="employeesId">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="employeesPw" required="required">
				</td>
			</tr>
			<tr>
				<th>새 비밀번호</th>
				<td>
					<input type="password" name="employeesNewPw">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" value="<%=employees.getEmpName()%>" name="employeesName">
				</td>
			</tr>
			<tr>
				<th>레벨</th>
				<td>
					<input type="number" value="<%=employees.getEmpLevel()%>" name="employeesLevel">
				</td>
			</tr>
			<tr>
				<th>입사일</th>
				<td>
					<%=employees.getCreatedate()%>
				</td>
			</tr>
			<tr>
				<th>진급일</th>
				<td>
					<%=employees.getUpdatedate()%>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
<%@page import="vo.id.Employees"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// employees 유의성 검사
	
	
	EmployeesDao ed = new EmployeesDao();
	ArrayList<Employees> employeesList = new ArrayList<>();
	employeesList = ed.selectEmployees();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 관리</h1>
	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>레벨</th>
			<th>입사일</th>
			<th>진급일</th>
			<th>수정</th>
		</tr>
	<%
		for(Employees e : employeesList){
	%>
			<form action="<%=request.getContextPath()%>/employees/updateEmployeesAction.jsp" method="post">
				<tr>
					<td>
						<input type="hidden" value="<%=e.getId()%>" name="employeesId">
						<%=e.getId()%>
					</td>
					<td>
						<%=e.getEmpName()%>
					</td>
					<td>
						<input type="number" value="<%=e.getEmpLevel()%>" name="employeesLevel">
					</td>
					<td>
						<%=e.getCreatedate()%>
					</td>
					<td>
						<%=e.getUpdatedate()%>
					</td>
					<td>
						<button type="submit">수정</button>
					</td>
				</tr>
			</form>
	<%
		}
	%>
	</table>
</body>
</html>
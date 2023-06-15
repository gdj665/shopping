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
	<h1>직원 관리</h1>
	<a href="<%=request.getContextPath()%>/employees/insertEmployees.jsp">
		직원 추가
	</a>
	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>레벨</th>
			<th>상세보기</th>
		</tr>
	<%
		for(Employees e : employeesList){
	%>
				<tr>
					<td>
						<%=e.getId()%>
					</td>
					<td>
						<%=e.getEmpName()%>
					</td>
					<td>
						<%=e.getEmpLevel()%>
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/employees/employeesOneControl.jsp?employeesId=<%=e.getId()%>">
							상세보기
						</a>
					</td>
				</tr>
	<%
		}
	%>
	</table>
</body>
</html>
<%@page import="vo.id.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// admin 유의성 검사
	
	
	EmployeesDao ad = new EmployeesDao();
	ArrayList<Customer> customerList = new ArrayList<>();
	customerList = ad.selectCustomer();
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
			<th>상태</th>
			<th>회원등급</th>
			<th>포인트</th>
			<th>최종로그인</th>
			<th>정보동의</th>
			<th>상세보기</th>
		</tr>
	<%
		for(Customer c : customerList){
	%>
			<tr>
				<td>
					<%=c.getId()%>
				</td>
				<td>
					<%=c.getActive()%>
				</td>
				<td>
					<%=c.getCstmRank()%>
				</td>
				<td>
					<%=c.getCstmPoint()%>
				</td>
				<td>
					<%=c.getCstmLastLogin()%>
				</td>
				<td>
					<%=c.getCstmAgree()%>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/employees/customerOneControl.jsp?customerId=<%=c.getId()%>">
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
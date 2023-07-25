<%@page import="vo.id.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("customerId") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	String customerId = request.getParameter("customerId");
	EmployeesDao ad = new EmployeesDao();
	Customer customer = new Customer();
	customer = ad.selectCustomer(customerId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 관리</h1>
	<form action="<%=request.getContextPath()%>/employees/updateCustomerAction.jsp" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="hidden" value="<%=customer.getId()%>" name="cstmId">
					<%=customer.getId()%>
				</td>
			</tr>
			<tr>
				<th>상태</th>
				<td>
					<input type="number" value="<%=customer.getActive()%>" name="cstmActive">
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<%=customer.getCstmName()%>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<%=customer.getCstmAddress()%>
				</td>
			</tr>
			<tr>
				<th>E-mail</th>
				<td>
					<%=customer.getCstmEmail()%>
				</td>
			</tr>
			<tr>
				<th>생일</th>
				<td>
					<%=customer.getCstmBirth()%>
				</td>
			</tr>
			<tr>
				<th>휴대폰번호</th>
				<td>
					<%=customer.getCstmPhone()%>
				</td>
			</tr>
			<tr>
				<th>회원등급</th>
				<td>
					<%=customer.getCstmRank()%>
				</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td>
					<%=customer.getCstmPoint()%>
				</td>
			</tr>
			<tr>
				<th>최종로그인</th>
				<td>
					<%=customer.getCstmLastLogin()%>
				</td>
			</tr>
			<tr>
				<th>정보동의</th>
				<td>
					<%=customer.getCstmAgree()%>
				</td>
			</tr>
			<tr>
				<th>가입날짜</th>
				<td>
					<%=customer.getCreatedate()%>
				</td>
			</tr>
			<tr>
				<th>수정날짜</th>
				<td>
					<%=customer.getUpdatedate()%>
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
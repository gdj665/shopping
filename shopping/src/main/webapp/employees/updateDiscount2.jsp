<%@page import="vo.product.Discount"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	EmployeesDao ed = new EmployeesDao();
	Discount d = new Discount();
	d = ed.selectDiscountOne(discountNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>할인 수정</h1>
	<form action="<%=request.getContextPath()%>/employees/updateDiscountAction.jsp">
		<input type="hidden" name="discountNo" value="<%=discountNo%>">
		<table>
			<tr>
				<th>품목</th>
				<th>품명</th>
				<th>할인시작날짜</th>
				<th>할인종료날짜</th>
				<th>할인율</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
				<tr>
					<td>
						<input type="hidden" name="productNo" value="<%=d.getProductNo()%>">
						<%=d.getProductNo()%>
					</td>
					<td>
						<%=d.getProductName()%>
					</td>
					<td>
						<input type="date" name="discountBegin" value="<%=d.getDiscountBegin()%>">
					</td>
					<td>
						<input type="date" name="discountEnd" value="<%=d.getDiscountEnd()%>">
						
					</td>
					<td>
						<input type="number" name="discountRate" value="<%=(int)(d.getDiscountRate() * 100)%>">
					</td>
					<td>
						<%=d.getCreatedate()%>
					</td>
					<td>
						<%=d.getUpdatedate()%>
					</td>
				</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
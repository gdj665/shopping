<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>할인 추가</h1>
	<form action="<%=request.getContextPath()%>/employees/insertDiscountAction.jsp">
		<table>
			<tr>
				<th>상품번호</th>
				<th>할인시작날짜</th>
				<th>할인종료날짜</th>
				<th>할인률</th>
			</tr>
			<tr>
				<td>
					<input type="number" name="productNo" required="required">
				</td>
				<td>
					<input type="date" name="discountBegin" required="required">
				</td>
				<td>
					<input type="date" name="discountEnd" required="required">
				</td>
				<td>
					<input type="number" name="discountRate" required="required">
				</td>
				<td>
					<button type="submit">추가</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
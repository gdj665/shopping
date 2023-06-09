<%@page import="vo.order.OrdersHistory"%>
<%@page import="vo.order.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.AdminDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	AdminDao ad = new AdminDao();
	ArrayList<Orders> ordersList = new ArrayList<>();
	ordersList = ad.ordersList();
	ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주문 내역(관리자)</h1>
	<table>
		<tr>
			<th>고객ID</th>
			<th>주문번호</th>
			<th>총가격가격</th>
			<th>포인트사용</th>
			<th>주문상태</th>
			<th>주문날짜</th>
			<th>품목</th>
			<th>품명</th>
			<th>제품가격</th>
			<th>수량</th>
		</tr>
	<%
		for (Orders o : ordersList){
			System.out.println("check");
			ordersHistoryList = (ArrayList<OrdersHistory>)o.getOrdersHistoryList();
			int tdSize = ordersHistoryList.size();
	%>
			<tr>
				<td rowspan="<%=tdSize%>">
					<%=o.getId()%>
				</td>
				<td rowspan="<%=tdSize%>">
					<%=o.getOrderNo()%>
				</td>
				<td rowspan="<%=tdSize%>">
					<%=o.getOrderPrice()%>
				</td>
				<td rowspan="<%=tdSize%>">
					<%=o.getOrderPointUse()%>
				</td>
				<td rowspan="<%=tdSize%>">
					<%=o.getOrderStatus()%>
				</td>
				<td rowspan="<%=tdSize%>">
					<%=o.getCreatedate()%>
				</td>
			</tr>
	<%
				for(OrdersHistory oh : ordersHistoryList){
	%>
				<tr>
					<td>
						<%=oh.getProductNo()%>
					</td>
					<td>
						<%=oh.getProductName()%>
					</td>
					<td>
						<%=oh.getProductPrice()%>
					</td>
					<td>
						<%=oh.getOrderCnt()%>
					</td>
				</tr>
	<%
				}
	%>
	<%
		}
	%>
	</table>
</body>
</html>
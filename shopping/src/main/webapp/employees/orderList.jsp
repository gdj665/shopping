<%@page import="vo.order.OrdersHistory"%>
<%@page import="vo.order.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//controller
	int searchOrderStatus = 0;
	if (request.getParameter("searchOrderStatus") != null){
		searchOrderStatus = Integer.parseInt(request.getParameter("searchOrderStatus"));
	}
	String searchBeginDate = null; 
	if (!"".equals(request.getParameter("searchBeginDate"))){
		searchBeginDate = request.getParameter("searchBeginDate");
	}
	//System.out.println(searchBeginDate + " <-searchBeginDate");
	String searchEndDate = null; 
	if (!"".equals(request.getParameter("searchEndDate"))){
		searchEndDate = request.getParameter("searchEndDate");
	}
	//model
	EmployeesDao ed = new EmployeesDao();
	ArrayList<Orders> ordersList = new ArrayList<>();
	
	if (searchOrderStatus != 0
			&& searchBeginDate != null){
		ordersList = ed.ordersList(searchOrderStatus, searchBeginDate, searchEndDate);
	} else if (searchOrderStatus != 0){
		ordersList = ed.ordersList(searchOrderStatus);
	} else if (searchBeginDate != null){
		ordersList = ed.ordersList(searchBeginDate, searchEndDate);
	} else {
		ordersList = ed.ordersList();
	}
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
	<h4>검색</h4>
	<form action="<%=request.getContextPath()%>/employees/orderList.jsp" method="get" id="sort">
		<select name="searchOrderStatus">
			<option value="0">전체</option>
			<option value="1">주문완료</option>
			<option value="2">배송중</option>
			<option value="3">배송완료</option>
			<option value="4">주문취소</option>
		</select>
		<input type="date" name="searchBeginDate">
		<input type="date" name="searchEndDate">
		<button type="submit" form="sort">검색</button>
	</form>
	<h4>주문상태 변경</h4>
	<form action="<%=request.getContextPath()%>/employees/orderListAction.jsp" method="post" id="update">
	<select name="orderStatus">
		<option value="1">주문완료</option>
		<option value="2">배송중</option>
		<option value="3">배송완료</option>
		<option value="4">주문취소</option>
	</select>
	<button type="submit" form="update">변경</button>
		<table>
			<tr>
				<th>체크박스</th>
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
				//System.out.println("checkListPage");
				ordersHistoryList = (ArrayList<OrdersHistory>)o.getOrdersHistoryList();
				int tdSize = ordersHistoryList.size();
				//System.out.println(tdSize + " <- tdSize");
		%>
				<tr>
					<td rowspan="<%=tdSize%>">
						<input type="checkbox" name="checkedOrderNo" value="<%=o.getOrderNo()%>">
					</td>
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
		<%
					for(OrdersHistory oh : ordersHistoryList){
		%>
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
					<tr>
		<%
					}
		%>
				</tr>
		<%
			}
		%>
		</table>
	</form>
</body>
</html>
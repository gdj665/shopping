<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));
	
		
	//세션아이디 디버깅
	System.out.println(id+"<--orderMyPage id");	
	
	OrderListDao orderDao = new OrderListDao();
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo + "<-- orderMyPage orderList");
	
	ArrayList<HashMap<String, Object>> list = orderDao.orderOne(orderNo);
	System.out.println(list + "<-- orderMyPage orderList");
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>주문내역</h1>
	
	<%
		for(HashMap<String, Object> m : list){
	%>
		<table border="1px">
			<tr>
				<th>상품이미지</th>
				<th>주문번호</th>
				<th>상품이름</th>
				<th>상품가격</th>
				<th>배송상태</th>
				<th>구매일</th>
			</tr>
			<tr>
				<td><%=(String)(m.get("saveFile")) %></td>
				<td><%=(Integer)(m.get("orderNo"))%></td>
				<td><%=(String)(m.get("productName"))%></td>
				<td><%=(Integer)(m.get("productPrice"))%></td>
				<td><%=(Integer)(m.get("orderCnt"))%></td>
				<td><%=(String)(m.get("createdate"))%></td>
				
			</tr>
		</table>
	
	<div>
	
		<%
			}
		%>
		
	</div>
</body>
</html>
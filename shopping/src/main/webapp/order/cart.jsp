<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 메세지 출력 설정
	String msg = null;
	
	
	// 값 받아오기
	String id = "admin";
	

	// 1) 장바구니 리스트 출력 메서드
	OrderDao orderdao = new OrderDao();
	ArrayList<HashMap<String,Object>> list = orderdao.cartList(id);
	// 2) 장바구니 각 항목의 총 합계의 최종합계를 구하는 메서드
	int row = orderdao.totalPrice(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	table,td,th {
		border:1px solid #000000;
	}
</style>
</head>
<body>
	<table>
		<!-- 테이블 헤더 -->
		<tr>
			<th>선택</th>
			<th>이미지</th>
			<th>상품명</th>
			<th>가격</th>
			<th>수량</th>
			<th>합계</th>
			<th>삭제</th>
		</tr>
		
		<!-- 장바구니 리스트 출력문 -->
		<%
			for(HashMap<String,Object> m : list){
				int productNo = (int)m.get("c.product_no");
				int cartCnt = (int)m.get("c.cart_cnt");
				String checked = (String)m.get("c.checked");
				
				// 3) 각 제품의 재고량을 구하는 메서드
				int tcnt = orderdao.totalstock(productNo);
		%>
		<tr>
			<td style="width:200px;"><input type="checkbox" <%= (checked.equals("Y")) ? "checked" : "" %>/></td>
			<td style="width:200px;"><img src="<%=(String)m.get("i.product_save_filename")%>"><%=(String)m.get("i.product_save_filename")%></td>
			<td style="width:200px;"><%=(String)m.get("p.product_name") %></td>
			<td style="width:200px;"><%=m.get("discount_price")%></td>
			<td style="width:200px;">
				<select>
					<%
						for(int i = 1; i<=tcnt; i++){
							
					%>
						<option <%= (i == cartCnt) ? "selected" : "" %>><%= i %></option>
					<%
						}
					%>
				</select>
			</td>
			<td style="width:200px;"><%=m.get("total_price") %></td>
			<td><a href="<%=request.getContextPath()%>/order/deleteCart.jsp?cartNo=<%=(int)m.get("cart_no")%>">삭제</a></td>
		</tr>
		<%
			}
		%>
	</table>
	
	
	<!-- 최종가격 출력 -->
	<table>
		<tr>
			<td>최종가격</td>
			<td><%=row%>원</td>
		</tr>
	</table>
</body>
</html>
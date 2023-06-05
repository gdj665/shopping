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

	String[] array = new String[3] ;

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
<script>
	// 구매하기 버튼을 눌럿는대 장바구니에서 체크된 항목이 없으면 장바구니에 선택된 제품이 없다고 메세지 출력
	function checkCart() {
		var totalAmount = <%=row%>;
		if (totalAmount === 0) {
			alert("장바구니에서 선택된 제품이 없습니다.");
		} else {
			location.href = "<%=request.getContextPath()%>/order/cartAction.jsp?id=<%=id%>";
		}
	}
	document.getElementById("input_check").addEventListener("change", function() {
		  if (this.checked) {
		    document.getElementById("input_check").value = "Y";
		    document.getElementById("input_check_hidden").value = null;
		    document.getElementById("input_check_hidden").disabled = true;
		  } else {
		    document.getElementById("input_check_hidden").value = "N";
		    document.getElementById("input_check_hidden").disabled = false;
		  }
		});

</script>
</head>
<body>
	<form action="<%=request.getContextPath() %>/order/updateCartAction.jsp">
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
						int productNo = (int)m.get("productNo");
						int cartCnt = (int)m.get("cartCnt");
						String checked = (String)m.get("checked");
						
						// 3) 각 제품의 재고량을 구하는 메서드
						int tcnt = orderdao.totalstock(productNo);
				%>
			<tr>
				<input type="hidden" name="cartNo" value="<%=(int)m.get("cartNo")%>">
				<td style="width:200px;">
					<input name="checked" value="Y" type="checkbox" id="input_check" <%= (checked != null && checked.equals("Y")) ? "checked" : "" %>/>
					<input name="checked" value="N" type="hidden" id="input_check_hidden"/>
				</td>
				<td style="width:200px;"><img src="<%=(String)m.get("productSaveFilename")%>"><%=(String)m.get("productSaveFilename")%></td>
				<td style="width:200px;"><%=(String)m.get("productName") %></td>
				<td style="width:200px;"><%=m.get("discountPrice")%></td>
				<td style="width:200px;">
					<select name="cartCnt">
						<%
							for(int i = 1; i<=tcnt; i++){
								
						%>
							<option <%= (i == cartCnt) ? "selected" : "" %> value=<%=i %>><%= i %></option>
						<%
							}
						%>
					</select>
				</td>
				<td style="width:200px;"><%=m.get("totalPrice") %></td>
				<td><a href="<%=request.getContextPath()%>/order/deleteCartAction.jsp?cartNo=<%=(int)m.get("cartNo")%>">삭제</a></td>
			</tr>
			<%
				}
			%>
		</table>
		<button type="submit">장바구니 정보 변경</button>
	</form>
	
	<!-- 최종가격 출력 -->
	<table>
		<tr>
			<td>최종가격</td>
			<td><%=row%>원</td>
		</tr>
	</table>
	<a id="buyButton" href="#" onclick="checkCart()">구매하기</a>
</body>
</html>
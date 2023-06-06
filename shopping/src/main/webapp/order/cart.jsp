<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 값 받아오기
	String id = "admin";

	// OrderDao사용 선언
	OrderDao orderdao = new OrderDao();
	
	// 1) OrderDao 장바구니 리스트 출력 메서드
	ArrayList<HashMap<String,Object>> list = orderdao.cartList(id);
	
	// 2) OrderDao 장바구니 각 항목의 총 합계의 최종합계를 구하는 메서드
	int row = orderdao.totalPrice(id);
	
	int cnt = 0;
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
		// totalAmount에 장바구니 총 합산 금액 삽입
		var totalAmount = <%=row%>;
		// 토탈금액이 0원일 경우
		if (totalAmount === 0) {
			// 제품이 한개도 없다면 alert메세지로 하단의 문구 출력
			alert("장바구니에서 선택된 제품이 없습니다.");
		} else {
			// 제품이 있다면 cartAction.jsp 실행
			location.href = "<%=request.getContextPath()%>/order/cartAction.jsp?id=<%=id%>";
		}
	}
</script>
</head>
<body>
	<!-- 업데이트 버튼을 누르면 장바구니 정보가 변경됨 -->
	<form action="<%=request.getContextPath() %>/order/updateCartAction.jsp">
		<!-- 카트 테이블 출력 -->
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
				// 장바구니 리스트 출력
				for(HashMap<String,Object> m : list){
					int productNo = (int)m.get("productNo");
					int cartCnt = (int)m.get("cartCnt");
					String checked = (String)m.get("checked");
					
					
					// 3) 각 제품의 재고량을 구하는 메서드
					int tcnt = orderdao.totalstock(productNo);
			%>
			<tr>			
				<td style="width:200px;">
					<!-- 카트 테이블 기본키 넘기기 -->
					<input type="hidden" name="cartNo" value="<%=(int)m.get("cartNo")%>">
					<!-- 장바구니 체크박스 -->
					<input name="checked<%=cnt%>" value="Y" type="checkbox" <%= (checked != null && checked.equals("Y")) ? "checked" : "" %>/>
				</td>
				<!-- 장바구니 사진삽입 -->
				<td style="width:200px;"><img src="<%=(String)m.get("productSaveFilename")%>"><%=(String)m.get("productSaveFilename")%></td>
				<!-- 제품이름 -->
				<td style="width:200px;"><%=(String)m.get("productName") %></td>
				<!-- 할인률 적용 후 가격 -->
				<td style="width:200px;"><%=m.get("discountPrice")%></td>
				<!-- 해당 제품의 재고량 안에서 수량 선택 가능 -->
				<td style="width:200px;">
					<select name="cartCnt">
						<%
							for(int i = 1; i<=tcnt; i++){
						%>
							<!-- 제품 갯수를 변경하면 그 값을 넘김 -->
							<option <%= (i == cartCnt) ? "selected" : "" %> value=<%=i %>><%= i %></option>
						<%
							}
						%>
					</select>
				</td>
				<!-- 제품과 갯수를 고른 뒤 총 합을 출력 (장바구니 전체 출력 X) -->
				<td style="width:200px;"><%=m.get("totalPrice") %></td>
				<!-- 해당 행의 장바구니 데이터 삭제 -->
				<td><a href="<%=request.getContextPath()%>/order/deleteCartAction.jsp?cartNo=<%=(int)m.get("cartNo")%>">삭제</a></td>
			</tr>
			<%
				cnt++;
				}
			%>
		</table>
		<!-- 해당 버튼으로 정보를 보내면 checked 여부와 장바구니 제품 갯수가 업데이트 됨 -->
		<button type="submit">장바구니 정보 변경</button>
	</form>
	
	<!-- 최종가격 출력 -->
	<table>
		<tr>
			<td>최종가격</td>
			<td><%=row%>원</td>
		</tr>
	</table>
	<!-- buyButton js 실행 -->
	<a id="buyButton" href="#" onclick="checkCart()">구매하기</a>
</body>
</html>
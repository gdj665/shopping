<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	
	// 값 받아오기
	String id = "admin";
	
	
	//OrderDao 선언
	OrderDao orderdao = new OrderDao();

	// 6) 주문내역 간략하게 받기
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	list2 = orderdao.finishorder(id);
	
	// 7) 받을 주소출력
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = orderdao.addressName(id);
	
	// 9) 주문자 정보 받아오기
	ArrayList<Customer> list3 = new ArrayList<>();
	list3 = orderdao.orderinfo(id);
	
	// 10) 주문정보가져오기
	ArrayList<HashMap<String,Object>> list4 = new ArrayList<>();
	list4 = orderdao.selordertable(id);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, td, th {
		border:1px solid #000000;
	}
</style>
<script>
	// 포인트 사용량이 보유 포인트량 기입보다 많을 시에 보유 포인트량으로 자동변경 하는 JS
	function limitInput(inputField) {
		// const는 한번 선언하면 변경이 불가능한 변수 선언
		const maxInput = parseInt(inputField.getAttribute('max'));
		const inputValue = parseInt(inputField.value);
		// 입력값이 최대값을 초과하는 경우 최대값으로 설정
		if (inputValue > maxInput) {
		  inputField.value = maxInput; 
		}
	}
</script>
</head>
<body>
	<h1>주문결제</h1>
	
	<!-- 주문자 정보 //9번 메서드사용 -->
	<hr>
	<h3>구매자 정보</h3>
	<!-- 포인트 사용을 누를시에 포인트 사용이 됨 -->
	<form action="<%=request.getContextPath() %>/order/orderPointAction.jsp">
		<table>
			<%
				for(Customer c : list3){
			%>
			<tr>
				<th>주문자 이름</th>
				<th><%=c.getCstmName() %></th>
			</tr>
			<tr>
				<th>보유 포인트량</th>
				<th><%=c.getCstmPoint() %></th>
			</tr>
			<%
				for(HashMap<String,Object> m : list4){
			%>
				<tr>
					<th>포인트 사용량</th>
					<td>
						<input type="hidden" name="orderNo" value="<%=(int)m.get("orderNo")%>">
						<input type="number" name="usepoint" value="<%=(int)m.get("orderPointUse")%>" min="0" max="<%=c.getCstmPoint()%>" class="inputfield" onchange="limitInput(this)" value=0>
						<button type="submit">포인트사용</button>
					</td>
				</tr>
			<%	
				}
			%>
			<tr>
				<th>주문자 이메일</th>
				<th><%=c.getCstmEmail() %></th>
			</tr>
			<%
				}
			%>
		</table>
	</form><!-- 포인트 사용 업데이트 form문 종료 -->
	
	<!-- 주소정보 // 7번메서드 사용 -->
	<form action="<%=request.getContextPath()%>/order/orderAction.jsp">
		<h3>주소지 입력</h3>
		<table>
			<tr>
				<th>주소</th>
				<th>최근사용</th>
			</tr>
			<%
				for(HashMap<String,Object> m : list){
			%>
				<tr>
	                <td>
	                    <input type="radio" name="address" value="<%=(String) m.get("address")%>" required="required">
	                    <%=(String) m.get("address")%>
	                </td>
                <td><%=(String) m.get("recentlyUseDate")%></td>
          		</tr>
			<%	
				}
			%>
		</table>
		<!-- 주소 추가하기 -->
		<a href="<%=request.getContextPath()%>/order/insertAddress.jsp?id=<%=id%>">추가하기</a>
		
		<!-- 주문내역 장바구니를 통해서 넘어온 제품 명과 제품 수량만 -->
		<h3>주문 내역</h3>
		<table>
			<tr>
				<th>제품 명</th>
				<th>수량</th>
			</tr>
			<%
				for(HashMap<String,Object> m : list2){
			%>
			<tr>
				<th><%=(String)m.get("productName") %></th>
				<td><%=(int)m.get("cartCnt") %>개</td>
			</tr>
			<%
				}
			%>
		</table>
		
		<!-- 총금액,포인트사용량,최종금액 기입 // 10번 메소드사용 -->
		<h3>결제정보</h3>
			<table>
				<tr>
					<th>총 금액</th>
					<th>포인트 사용</th>
					<th>최종 금액</th>
				</tr>
				<%
					for(HashMap<String,Object> m : list4){
				%>
					<tr>
						<td><%=(int)m.get("orderPrice")%></td>
						<td><%=(int)m.get("orderPointUse") %></td>
						<td><%=(int)m.get("totalPrice")%></td>
						<!-- 히든 값으로 orderNo와 id를 넘기기 -->
						<input type="hidden" name="orderNo" value="<%=(int)m.get("orderNo")%>">
						<input type="hidden" name="id" value="<%=id %>">
					</tr>
					
				<%	
					}
				%>
			</table>
		<!-- 주소정보와 orderNo, id등을 값 넘기기 -->
		<button type="submit">결제하기</button>
	</form>
</body>
</html>
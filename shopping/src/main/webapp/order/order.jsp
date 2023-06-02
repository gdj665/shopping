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
	
	// 메세지 출력 설정
	String msg = null;
	
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
	function limitInput(inputField) {
		const maxInput = parseInt(inputField.getAttribute('max'));
		const inputValue = parseInt(inputField.value);
		
		if (inputValue > maxInput) {
		  inputField.value = maxInput; // 입력값이 최대값을 초과하는 경우 최대값으로 설정
		}
	}
</script>
</head>
<body>
	<h1>주문결제</h1>
	<!-- 주문자 정보 //9번 메서드사용 -->
	<hr>
	<h3>구매자 정보</h3>
	<form action="<%=request.getContextPath()%>/order/orderAction.jsp">
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
			<tr>
				<th>주문자 이메일</th>
				<th><%=c.getCstmEmail() %></th>
			</tr>
			<%
				}
			%>
		</table>
		<!-- 주소정보 // 7번메서드 사용 -->
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
	                    <input type="radio" name="address" value="<%=(String) m.get("address")%>">
	                    <%=(String) m.get("address")%>
	                </td>
                <td><%=(String) m.get("recentlyUseDate")%></td>
          		</tr>
			<%	
				}
			%>
		</table>
		<!-- 주문내역간략하게 -->
		<h3>주문 내역</h3>
		<table>
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
					<%
						for(Customer c : list3){
					%>
						<td>
						  <input type="number" min="0" max="<%=c.getCstmPoint()%>" class="inputfield" onchange="limitInput(this)" value=0>
						</td>
					<%
						}
					%>
					<td><%=(int)m.get("totalPrice")%></td>
				</tr>
				<input type="hidden" name="orderNo" value="<%=(int)m.get("orderNo")%>">
			<%	
				}
			%>
		</table>
		<button type="submit">결제하기</button>
	</form>
</body>
</html>
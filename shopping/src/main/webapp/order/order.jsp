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
</head>
<body>
	<!-- 주문자 정보 //9번 메서드사용 -->
	<table>
		<tr>
			<th colspan="2">주문자 정보</th>
		</tr>
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
	<table>
		<tr>
			<th>주소</th>
			<th>최근사용</th>
		</tr>
		<%
			for(HashMap<String,Object> m : list){
		%>
			<tr>
				<td><%=(String)m.get("address")%></td>
				<td><%=(String)m.get("recentlyUseDate")%></td>
			</tr>
		<%	
			}
		%>
	</table>
	<!-- 총금액,포인트사용량,최종금액 기입 // 10번 메소드사용 -->
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
				<td><%=(int)m.get("orderPointUse")%></td>
				<td><%=(int)m.get("totalPrice")%></td>
			</tr>
		<%	
			}
		%>
	</table>
</body>
</html>
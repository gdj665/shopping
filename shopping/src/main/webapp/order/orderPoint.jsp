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
	
	//유효성 검사
	if(session.getAttribute("loginId") == null
		||request.getParameter("orderNo") == null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("orderPoint null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}	


	// 값 받아오기
	String id = (String)session.getAttribute("loginId");
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	
	//OrderDao 선언
	OrderDao orderdao = new OrderDao();

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
<title>포인트 사용</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<br>
	<h3 style="text-align: center;">포인트 사용</h3>
	<hr>
	<div class="container">
		<form id="updateOrderPoint" action="<%=request.getContextPath() %>/order/orderPointAction.jsp">
			<table>
				<%
					for(Customer c : list3){
				
						for(HashMap<String,Object> m : list4){
				%>
				<tr>
					<th>사용할 포인트 설정 : </th>
					<td>
						<input type="hidden" name="orderNo" value="<%=(int)m.get("orderNo")%>">
						<input class="form-control" type="number" name="usepoint" value="<%=(int)m.get("orderPointUse")%>" min="0" max="<%=c.getCstmPoint()%>" class="inputfield" onchange="limitInput(this)" value=0>
					</td>
				</tr>
				<%
						}
					}
				%>
			</table>
			<br>
			<div class="d-grid">
				<button class="btn btn-outline-secondary btn-block" type="submit" onclick="submitForm()">사용하기</button><br>
			</div>
		</form>
		<div class="d-grid">
			<a href="#" class="btn btn-outline-secondary btn-block" onclick="useAllPoints()">모든 포인트 사용하기</a>
		</div>
	</div>
	
<!-- 스크립트 -->
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
	// 포인트 사용 누를시에 원래 창 종료 후 원래 창 새로고침
	function submitForm() {
		// Form 데이터를 가져와서 새 창에 전송
		var form = document.getElementById('updateOrderPoint');
		form.target = 'newWindow'; // 새 창의 이름
		form.action = '<%= request.getContextPath() %>/order/orderPointAction.jsp'; // 액션 URL
		form.submit();
		
		// 원래 창으로 돌아가고 새로고침
		window.opener.location.reload();
		// 현재 창 닫기
		window.close();
	}
	// 모든 포인트 사용
	function useAllPoints() {
		var orderNo = parseInt(document.getElementsByName("orderNo")[0].value);
		var usepoint = parseInt(document.getElementsByName("usepoint")[0].getAttribute('max'));

		// URL 생성
		var url = "<%= request.getContextPath() %>/order/orderPointAction.jsp?orderNo=" + orderNo + "&usepoint=" + usepoint;
		// 새 창에서 URL 열기
		var newWindow = window.open(url, "newWindow");
		// 새로고침
		newWindow.opener.location.reload();
		// 현재 창 닫기
		window.close();
	}
</script>
</body>
</html>
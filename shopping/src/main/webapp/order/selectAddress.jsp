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
	
	
	// 7) 받을 주소출력
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = orderdao.addressName(id);

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
		<br><h3 style="text-align: center;">주소목록</h3>
	</div>
	<hr>
	<br>
	<div class="container">
		<form id="addressForm" action="<%= request.getContextPath() %>/order/order.jsp">
		<%
			for(HashMap<String,Object> m : list){
		%>
		        <input type="radio" style="width:15px;height:15px;border:1px;" name="addressNo" value="<%=(int) m.get("addressNo")%>" required="required">
		        <%=(String) m.get("address")%><br><br>
	  	<%	
			}
		%>
		<br>
		<div class="d-grid">
			<button class="btn btn-outline-secondary btn-block" type="submit" onclick="submitForm()">선택하기</button>
		</div>
		<br>
		</form>
		<div class="d-grid">
			<a class="btn btn-outline-secondary btn-block" href="<%=request.getContextPath()%>/order/insertAddress.jsp">주소찾기</a>
		</div>
	</div>
</body>

<script>
	function submitForm() {
		// Form 데이터를 가져와서 새 창에 전송
		var form = document.getElementById('addressForm');
		form.target = 'newWindow'; // 새 창의 이름
		form.submit();
		
		// 원래 창으로 돌아가고 새로고침
		window.opener.location.reload();
		window.close();
	}
</script>
</html>
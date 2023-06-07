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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 주소 추가</title>
<script>
	function submitForm() {
		// Form 데이터를 가져와서 새 창에 전송
		var form = document.getElementById('addressForm');
		form.target = 'newWindow'; // 새 창의 이름
		form.action = '<%= request.getContextPath() %>/order/insertAddressAction.jsp'; // 액션 URL
		form.submit();
		
		// 원래 창으로 돌아가고 새로고침
		window.opener.location.reload();
		window.close();
	}
</script>
</head>
<body>
	<form id="addressForm" method="post" action = "<%=request.getContextPath() %>/order/insertAddressAction.jsp">
		<table>
			<tr>
				<th>주소 추가</th>
				<th><input type="text" name="address" required="required"></th>
				<input type="hidden" name="id" value="<%=id%>">
			</tr>
		</table>
		<button type = "submit" onclick="submitForm()">추가하기</button>
	</form>
</body>
</html>
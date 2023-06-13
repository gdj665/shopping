<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/main/home.jsp");
		return;
	}

	String id = (String)(session.getAttribute("loginId"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 탈퇴</h1>
	
	<form action="<%=request.getContextPath()%>/customer/memberOutAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="hidden" name="id">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="pw" >
				</td>
			</tr>
			
		</table>
		<button type="submit">탈퇴</button>
	</form>
</body>
</html>
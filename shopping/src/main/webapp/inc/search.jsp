<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/product/searchList.jsp" method="post">
		<a href="<%=request.getContextPath()%>/home.jsp">
			홈으로
		</a>
		<input type="text" name="searchWord"><button type="submit">검색</button>
	</form>
</body>
</html>
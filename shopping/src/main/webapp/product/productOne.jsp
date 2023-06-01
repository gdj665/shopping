<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	//controller
	/*
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	*/
	
	int productNo = 1;
	MainDao md = new MainDao();
	Product p = new Product();
	p = md.selectProductOne(productNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>앨범 상세보기</h1>
	<table>
		<tr>
			<td>
				<%=p.getProductName()%>
			</td>
		</tr>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	// cotroller
	int currentPage = 1;
	if (request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	String mainName = "한국";
	if (request.getParameter("mainName") != null){
		mainName = request.getParameter("mainName");
	}
	String subName = "전체";
	if (request.getParameter("subName") != null){
		subName = request.getParameter("subName");
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// model
	MainDao md = new MainDao();
	int categoryNo = md.checkCategory(mainName, subName);
	ArrayList<Product> productList = new ArrayList<>();
	productList = md.selectProduct(categoryNo, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>앨범 리스트</h1>
	<table>
		<tr>
		<%
			int cnt = 0;
			for(Product p : productList) {
				if(cnt %2 == 0){
		%>
					</tr>
					<tr>
		<%
				}
		%>
				<td>
					<%=p.getProductName()%>
				</td>
		<%
			cnt++;
			}
		%>
		</tr>
	</table>
</body>
</html>
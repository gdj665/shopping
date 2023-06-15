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
	
	// categoryNo 매개변수
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
	ArrayList<Product> productList = new ArrayList<>();
	productList = md.selectProduct(mainName, subName, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<h1>최신 앨범</h1>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<h4>앨범 리스트</h4>
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
					<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
						<%=p.getProductName()%>
					</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
						<img style="width:150px; height:150px;" src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
					</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=p.getProductNo()%>">
						수정
					</a>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/product/deleteProductAction.jsp?productNo=<%=p.getProductNo()%>">
						삭제
					</a>
				</td>
		<%
			cnt++;
			}
		%>
		</tr>
	</table>
	<a href="<%=request.getContextPath()%>/product/insertProduct.jsp">
		추가
	</a>
</body>
</html>
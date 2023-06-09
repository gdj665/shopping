<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	// cotroller
	String loginId = (String)session.getAttribute("loginId");
	int viewNum = 20;
	
	// model
	MainDao md = new MainDao();
	EmployeesDao ed = new EmployeesDao();
	ArrayList<Product> productList = new ArrayList<>();
	productList = md.selectRecentlyProduct(viewNum);
	int checkId = 0;
	checkId = ed.checkEmployees(loginId);
	System.out.println(checkId + " <- checkId");

	// 금액 , 표시
	DecimalFormat priceFormat = new DecimalFormat("###,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New product</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<div class="banner-section spad">
		<h3>
			최신 앨범
		<%
			if(checkId > 0){
		%>
			<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/product/insertProduct.jsp">
				추가
			</a>
		<%
			}
		%>
		</h3>
		<hr>
		<div class="product-list">
			<div class="row">
			<%
				for(Product p : productList) {
					Product productOne = new Product();
					productOne = md.selectProductOne(p.getProductNo());
			%>
			    <div class="col-lg-3 col-sm-6">
			        <div class="product-item">
			        <%
						if(checkId > 0){
					%>
							<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=p.getProductNo()%>">
								수정
							</a>
							<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/product/deleteProductAction.jsp?productNo=<%=p.getProductNo()%>">
								삭제
							</a>
						<div style="line-height:50%;">
							<br>
						</div>
					<%
						}
					%>
			            <div class="pi-pic">
			                <a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
								<img src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
							</a>
			            </div>
			            <div class="pi-text">
			                <div class="catagory-name"><%=p.getCategorySubName()%></div>
			                <a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
			                    <h5><%=p.getProductName()%></h5>
			                </a>
					<%
						// 할인금액이랑 일반 금액이랑 같으면 할인 x
						if (productOne.getProductDiscountPrice() == productOne.getProductPrice()){
					%>
							<div class="product-price">
							    <%=priceFormat.format(productOne.getProductPrice())%>원
							</div>
					<%
						} else {
					%>
							<div class="product-price">
							    <%=priceFormat.format(productOne.getProductPrice())%>원
							  	<span><%=priceFormat.format(productOne.getProductPrice())%>원</span>
							</div>
					<%
						}
					%>
			            </div>
			        </div>
			    </div>
			<%
				}
			%>
			</div>
		</div>
	</div>
</body>
</html>
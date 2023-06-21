<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.main.*" %>
<%@ page import="vo.product.*" %>
<%
	MainDao md = new MainDao();
	ArrayList<Product> recentlyList = new ArrayList<>();
	ArrayList<Product> popularList = new ArrayList<>();
	int viewNum = 6;
	recentlyList = md.selectRecentlyProduct(viewNum);
	popularList = md.selectPopularProduct(viewNum);
	
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
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<!-- Hero Section Begin -->
    <div>
		<jsp:include page="/inc/banner.jsp"></jsp:include>
	</div>
    <!-- Hero Section End -->
	<div class="banner-section spad">
	<h3>최신 앨범</h3>
	<hr>
		<div class="product-list">
			<div class="row">
			<%
				for(Product p : recentlyList) {
					Product productOne = new Product();
					productOne = md.selectProductOne(p.getProductNo());
			%>
			    <div class="col-lg-3 col-sm-6">
			        <div class="product-item">
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
			            </div>
			        </div>
			    </div>
			<%
				}
			%>
			</div>
		</div>
	<hr>
	<h3>인기 앨범</h3>
	<hr>
		<div class="product-list">
			<div class="row">
			<%
				for(Product p : popularList) {
					Product productOne = new Product();
					productOne = md.selectProductOne(p.getProductNo());
			%>
			    <div class="col-lg-3 col-sm-6">
			        <div class="product-item">
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
			            </div>
			        </div>
			    </div>
			<%
				}
			%>
			</div>
		</div>
	</div>
<!-- Js Plugins -->
<script src="<%=request.getContextPath() %>/template/js/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.countdown.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.nice-select.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.zoom.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.dd.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.slicknav.js"></script>
<script src="<%=request.getContextPath() %>/template/js/owl.carousel.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/main.js"></script>
</body>
</html>
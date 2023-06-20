<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	// cotroller
	String loginId = (String)session.getAttribute("loginId");
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
	
	// 페이징
	int rowPerPage = 4;
	int beginRow = (currentPage - 1) * rowPerPage;
	int endRow = beginRow + rowPerPage;
	int pagePerPage = 10;
	int beginPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1;
	int endPage = beginPage + pagePerPage - 1;
	
	int totalCnt = 0;
	int totalPageCnt = 0;
	
	// model
	MainDao md = new MainDao();
	EmployeesDao ed = new EmployeesDao();
	ArrayList<Product> productList = new ArrayList<>();
	productList = md.selectProduct(mainName, subName, beginRow, rowPerPage);
	int checkId = 0;
	checkId = ed.checkEmployees(loginId);
	System.out.println(checkId + " <- checkId");
	
	// 총 앨범수
	totalCnt = md.productCnt(mainName, subName);
	System.out.println(totalCnt);
	totalPageCnt = (int)Math.ceil((double)totalCnt / rowPerPage);
	System.out.println(totalPageCnt);
	if(endRow > totalCnt) {
		endRow = totalCnt;
	}
	
	if (endPage > totalPageCnt){
		endPage = totalPageCnt;
	}
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
	<hr>
	<h3>
		앨범 리스트
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
			<%
				}
			%>
		            <div class="pi-pic">
		                <a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
							<img width="200px" height="300px" src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
						</a>
		            </div>
		            <div class="pi-text">
		                <div class="catagory-name"><%=p.getCategorySubName()%></div>
		                <a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
		                    <h5><%=p.getProductName()%></h5>
		                </a>
				<%
					if (productOne.getProductDiscountPrice() == productOne.getProductPrice()){
				%>
						<div class="product-price">
						    <%=productOne.getProductPrice()%>원
						</div>
				<%
					} else {
				%>
						<div class="product-price">
							<%=productOne.getProductDiscountPrice()%>원
						    <span><%=productOne.getProductPrice()%>원</span>
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
			<table class="table text-center">
			<!-- 페이징 -->
	<%
				int prePage = beginPage - pagePerPage;
				if (prePage < 1){
					prePage = 1;
				}
	
				int nextPage = beginPage + pagePerPage;
				if (nextPage > totalPageCnt){
					nextPage = totalPageCnt;
				}
				
	
				if (beginPage != 1){
	%>
					<td>
						<a class="btn btn-sm" href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=<%=subName%>&currentPage=<%=prePage%>">
							이전
						</a>
					</td>
	<%
				}
				for(int i = beginPage; i <= endPage; i++){
					String highlightCurrentPage = null;
					if (currentPage ==  i) {
						highlightCurrentPage = "table-danger";
					}
	%>
					<td class="<%=highlightCurrentPage%>">
						<a class="btn btn-sm" href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=<%=subName%>&currentPage=<%=i%>">
							<%=i%>
						</a>
					</td>
	<%
					int blankPage = endPage;
					while (i == endPage && blankPage % 10 != 0){
	%>
						<td>&nbsp;</td>
	<%
						blankPage ++;
					}
				}
				if (endPage != totalPageCnt){
	%>
					<td>
						<a class="btn btn-sm" href="<%=request.getContextPath()%>/product/productList.jsp?mainName=<%=mainName%>&subName=<%=subName%>&currentPage=<%=nextPage%>">
							다음
						</a>
					</td>
	<%
				}
	%>
		</table>
	</div>
</body>
</html>
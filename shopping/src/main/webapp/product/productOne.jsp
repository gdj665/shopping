<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	//controller
	// 유의성 검사
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	// 로그인 확인하고 로그인 안했고 장바구니에 물건 넣으면 비로그인 기준으로 하기위해 만듬
	String loginId = (String)session.getAttribute("loginId");
	String notLoginId = (String)session.getAttribute("notLoginId");
	if (loginId == null
			|| notLoginId == null){
		session.setAttribute("notLoginId", "notLoginId");
	}
	
	// 로그인 안했으면 id = "notLoginId"
	String id = null;
	if (loginId == null){
		id = notLoginId;
	} else {
		id = loginId;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	MainDao md = new MainDao();
	EmployeesDao ed = new EmployeesDao();
	
	int checkId = 0;
	checkId = ed.checkEmployees(loginId);
	System.out.println(checkId + " <- checkId");
	
	// 앨범 세부 내용
	Product p = new Product();
	p = md.selectProductOne(productNo);
	// 할인 데이터 가져오기 위함
	Product productOne = new Product();
	productOne = md.selectProductOne(productNo);
	
	// 수록곡 리스트
	ArrayList<Track> trackList = new ArrayList<>();
	trackList = md.selectTrack(productNo);
	
	String[] categoryName = md.printCategory(p.getCategoryNo());
	String mainCategory = categoryName[0];
	String subCategory = categoryName[1];
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>앨범상세보기</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
	<script>
		$(document).ready(function(){
			$('#cartBtn').click(function(){
				console.log($('#cartCnt').val())
				if($('#cartCnt').val() < 1){
					alert('1개 이상 구매해주세요');
				}else{
					$('#addCart').submit();
				}
			})
		})
	</script>
</head>
<style>
	ul.nav {
	  display: flex;
	  justify-content: space-between;
	}
	
	ul.nav li {
	  flex-basis: calc(100% / 3); /* li 요소들을 세 개의 동일한 너비로 분할 */
	  text-align: center; /* li 요소 내의 텍스트를 가운데 정렬 */
	}
</style>
<body>
	<div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<div class="banner-section spad">
		<h3>
			앨범 정보
			<%
				if(checkId > 0){
			%>
				<a class="btn btn-outline-danger " href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productNo%>">
					수정
				</a>
				<a class="btn btn-outline-danger " href="<%=request.getContextPath()%>/product/deleteProductAction.jsp?productNo=<%=productNo%>">
					삭제
				</a>
			<%
				}
			%>
		</h3>
		<hr>
	 <!-- Product Shop Section Begin -->
	    <section class="product-shop spad page-details">
	        <div class="container">
	            <div class="row">
	                <div class="col-lg-6">
				        <div class="product-item">
				            <div class="pi-pic">
								<img src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
				            </div>
				        </div>
	                </div>
	                <div class="col-lg-6">
	                    <div class="product-details">
	                        <div class="pd-title">
	                            <span><%=p.getProductSinger()%></span>
	                            <h3><%=p.getProductName()%></h3>
	                        </div>
	                        <div class="pd-desc">
	                            <p>
	                            	<%=p.getProductInfo()%>
	                            </p>
	                            <h4>
	                            <%
									if (productOne.getProductDiscountPrice() == productOne.getProductPrice()){
								%>
										    <%=productOne.getProductPrice()%>원
								<%
									} else {
								%>
											<%=productOne.getProductDiscountPrice()%>원
										  	<span><%=productOne.getProductPrice()%>원</span>
								<%
									}
								%>
	                            </h4>
	                        </div>
	                        <div class="quantity">
	                        <%
	                        	if("1".equals(p.getProductStatus())){
	                       	%>
	                        	<form action="<%=request.getContextPath()%>/product/addCartAction.jsp" method="post" id="addCart">
									<input type="hidden" name="id" value="<%=id%>">
									<input type="hidden" name="productNo" value="<%=productNo%>">
									<button class="primary-btn pd-cart" type="button" id="cartBtn" form="addCart">장바구니 추가</button>
	                            <div class="pro-qty">
									<input type="number" id="cartCnt" name="cartCnt" value="1">
	                            </div>
								</form>
	                       	<%
	                        	} else if("2".equals(p.getProductStatus())) {
	                        %>
	                        	<h5>품절</h5>
	                        <%
	                        	} else {
	                        %>
	                        	<h5>단종</h5>
	                        <%
	                        	}
	                        %>
	                        </div>
	                        <ul class="pd-tags">
	                            <li><span>카테고리</span>: <%=mainCategory%>, <%=subCategory%></li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
				<div class="product-tab">
	                <div class="tab-item">
	                    <ul class="nav" role="tablist">
	                        <li>
	                            <a style="width:100%;" class="active" data-toggle="tab" href="#tab-1" role="tab">수록곡</a>
	                        </li>
	                        <li>
	                            <a style="width:100%;" data-toggle="tab" href="#tab-2" role="tab">리뷰</a>
	                        </li>
	                        <li>
	                            <a style="width:100%;" data-toggle="tab" href="#tab-3" role="tab">문의</a>
	                        </li>
	                    </ul>
	                </div>
	                <div class="tab-item-content">
	                    <div class="tab-content">
	                        <div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
	                            <div class="product-content">
	                                <div class="row">
	                                    <div class="col-lg-12">
	                                        <table class="table">
												<tr>
													<th>번호</th>
													<th>곡정보</th>
													<th>재생시간</th>
												</tr>
											<%
												for (Track t : trackList){
											%>
												<tr>
													<td rowspan="2">
														<%=t.getTrackNo()%>
													</td>
													<td>
														<%=t.getTrackName()%>
													</td>
													<td rowspan="2">
														<%=md.calculateTime(t.getTrackTime())%>
													</td>
												</tr>
												<tr>
													<td>
														<%=t.getProductSinger()%>
													</td>
												</tr>
											<%
												}
											%>
											</table>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="tab-pane fade" id="tab-2" role="tabpanel">
                        		<div class="row">
                                    <div class="col-lg-12">
				                        <div>
											<jsp:include page="/inc/reviewList.jsp"></jsp:include>
										</div>
									</div>
								</div>
	                        </div>
	                        <div class="tab-pane fade" id="tab-3" role="tabpanel">
	                        	<div class="row">
                                    <div class="col-lg-12">
			                        	<div>
											<jsp:include page="/cs/productCsList.jsp"></jsp:include>
										</div>
									</div>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
    <!-- Product Shop Section End -->
    </div>
</body>
</html>
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
<body>
	<div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<hr>
	<h4>
		앨범 정보
		<%
			if(checkId > 0){
		%>
			<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productNo%>">
				수정
			</a>
			<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/product/deleteProductAction.jsp?productNo=<%=productNo%>">
				삭제
			</a>
		<%
			}
		%>
	</h4>
	<hr>
	<div class="product-list">
		<div class="row">
		    <div class="col-lg-4 col-sm-6">
		        <div class="product-item">
		            <div class="pi-pic">
		                <a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=p.getProductNo()%>">
							<img src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
						</a>
		            </div>
		        </div>
		    </div>
		    <div class="col-lg-6 col-sm-6">
				<table class="table">
					<tr>
						<th>앨범가격</th>
						<td>
							<%
								if (productOne.getProductDiscountPrice() == productOne.getProductPrice()){
							%>
									    <%=productOne.getProductPrice()%>원
							<%
								} else {
							%>
										<%=productOne.getProductDiscountPrice()%>원
									  	<font style="text-decoration:line-through"><%=productOne.getProductPrice()%>원</font>
							<%
								}
							%>
						</td>
					</tr>
					<tr>
						<th colspan="2">
							<form action="<%=request.getContextPath()%>/product/addCartAction.jsp" method="post" id="addCart">
								<input type="hidden" name="id" value="<%=id%>">
								<input type="hidden" name="productNo" value="<%=productNo%>">
								구매수량: <input type="number" id="cartCnt" name="cartCnt">
								<button class="btn btn-outline-secondary btn-sm" type="button" id="cartBtn" form="addCart">장바구니 추가</button>
							</form>
						</td>
					</tr>
					<tr>
						<th>앨범명</th>
						<td>
							<%=p.getProductName()%>
						</td>
					</tr>
					<tr>
						<th>가수명</th>
						<td>
							<%=p.getProductSinger()%>
						</td>
					</tr>
					<tr>
						<th>총 재생 시간</th>
						<td>
							<%=md.calculateTime(p.getTrackSumTime())%>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<%=p.getProductInfo()%>
						</td>
					</tr>
				</table>
		    </div>
		</div>
	</div>
	<h4>수록곡(<%=trackList.size()%>)</h4>
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
	<div>
		<jsp:include page="/inc/reviewList.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/cs/productCsList.jsp"></jsp:include>
	</div>
</body>
</html>
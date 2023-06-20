<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	//controller
	if (request.getParameter("reviewNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	
	ReviewDao rd = new ReviewDao();
	Review review = new Review();
	review = rd.selectReview(reviewNo);
	ArrayList<Review> reviewImgList = new ArrayList<>();
	reviewImgList = rd.selectReviewImg(reviewNo);
	
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
	<h4>
		상품 리뷰
		<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/review/updateReview.jsp?reviewNo=<%=reviewNo%>">
			수정
		</a>
		<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/review/deleteReviewAction.jsp?reviewNo=<%=reviewNo%>&productNo=<%=review.getProductNo()%>">
			삭제
		</a>
	</h4>
	<hr>
	<table class="table">
		<tr>
			<th>리뷰 제목</th>
			<td>
				<%=review.getReviewTitle()%>
			</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>
				<%=review.getId()%>
			</td>
		</tr>
		<tr>
			<th>작성날짜</th>
			<td>
				<%=review.getCreatedate()%>
			</td>
		</tr>
		<tr>
			<th>
				앨범명
			</th>
			<td>
				<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=review.getProductNo()%>">
					<%=review.getProductName()%>
				</a>
			</td>
		</tr>
	</table>
	<hr>
	<div class="product-list">
		<div class="row">
	<%
			for(Review r : reviewImgList){
	%>
			    <div class="col-lg-2 col-sm-2">
			        <div class="product-item">
			            <div class="pi-pic">
							<img src="<%=request.getContextPath() + "/img/reviewImg/" + r.getReviewSaveFilename()%>">
			            </div>
			        </div>
			    </div>
	<%	
			}
	%>
		</div>
	</div>
	<hr>
	<table class="table">
		<tr>
			<th>
				리뷰 내용
			</th>
		</tr>
		<tr>
			<td>
				<%=review.getReviewContent()%>
			</td>
		</tr>
	</table>
</body>
</html>
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
	<h1>상품 리뷰</h1>
	<a href="<%=request.getContextPath()%>/review/updateReview.jsp?reviewNo=<%=reviewNo%>">
		수정
	</a>
	<a href="<%=request.getContextPath()%>/review/deleteReviewAction.jsp?reviewNo=<%=reviewNo%>&productNo=<%=review.getProductNo()%>">
		삭제
	</a>
	<table>
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
	</table>
	<h4>
		<a href="<%=request.getContextPath()%>/product/productOne.jsp?productNo=<%=review.getProductNo()%>">
			<%=review.getProductName()%>
		</a>
	</h4>
	<table>
		<tr>
	<%
			for(Review r : reviewImgList){
	%>
				<td>
					<img src="<%=request.getContextPath() + "/img/reviewImg/" + r.getReviewSaveFilename()%>">
				</td>
	<%	
			}
	%>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<%=review.getReviewContent()%>
			</td>
		</tr>
	</table>
</body>
</html>
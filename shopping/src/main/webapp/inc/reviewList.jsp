<%@page import="vo.product.Review"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//리뷰 title만 가져와서 나열 클릭하면 리뷰 상세로 이동
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// System.out.println(productNo);
	ReviewDao rd = new ReviewDao();
	
	ArrayList<Review> reviewTitleList = new ArrayList<>();
	// 나열할 review title list 선언
	reviewTitleList = rd.selectReviewTitleList(productNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>리뷰</h1>
	
	<table>
		<tr>
			<td>
				<a href="<%=request.getContextPath()%>/review/insertReview.jsp?productNo=<%=productNo%>">
					리뷰 작성
				</a>
			</td>
		</tr>
	<%
		for(Review r : reviewTitleList){
	%>
			<tr>
				<td>
					<a href="<%=request.getContextPath()%>/review/review.jsp?reviewNo=<%=r.getReviewNo()%>">
						<%=r.getReviewTitle()%>
					</a>
				</td>
			</tr>
	<%
		}
	%>
	</table>
</body>
</html>
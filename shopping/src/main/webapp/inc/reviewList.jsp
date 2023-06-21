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
	String id = (String)session.getAttribute("loginId");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// System.out.println(productNo);
	ReviewDao rd = new ReviewDao();
	
	ArrayList<Review> reviewTitleList = new ArrayList<>();
	// 나열할 review title list 선언
	reviewTitleList = rd.selectReviewTitleList(productNo);
	
	// 리뷰 작성탭 유의성
	boolean checkId = rd.checkId(id, productNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="customer-review-option">
    <h4>
    	리뷰 수 <%=reviewTitleList.size()%>
   	<%
   		if (checkId){
   	%>
			<a class="btn btn-outline-danger btn-sm" href="<%=request.getContextPath()%>/review/insertReview.jsp?productNo=<%=productNo%>">
				리뷰 작성
			</a>
   	<%
   		}
   	%>
    </h4>
		<div class="comment-option">
		<%
			for(Review r : reviewTitleList){
		%>
			    <div class="co-item">
			        <div class="avatar-text">
			            <h5>
				            <a href="<%=request.getContextPath()%>/review/review.jsp?reviewNo=<%=r.getReviewNo()%>">
								<%=r.getReviewTitle()%>
							</a>
			            	<span>
			            		<%=r.getCreatedate()%>
			            	</span>
			            </h5>
			            <div class="at-reply">
			            	<%=r.getId()%>
			            </div>
			        </div>
			    </div>
		<%
			}
		%>
		</div>
	</div>
</body>
</html>
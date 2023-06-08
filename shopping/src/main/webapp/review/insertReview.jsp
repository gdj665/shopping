<%@page import="dao.main.ReviewDao"%>
<%@page import="dao.main.MainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	ReviewDao rd = new ReviewDao();
	// String id = (String)session.getAttribute("loginId");
	String id = "aa";
	boolean checkId = rd.checkId(id, productNo);
	// System.out.println(checkId);
	if(!checkId){
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
		return;
	}
	MainDao md = new MainDao();
	String productName = md.selectProductOne(productNo).getProductName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4><%=productName%> 리뷰 작성 페이지</h4>
	<form action="<%=request.getContextPath()%>/review/insertReviewAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="productNo" value="<%=productNo%>">
		<table>
			<tr>
				<th>리뷰 제목</th>
				<td>
					<input type="text" name="reviewTitle" required="required">
				</td>
			</tr>
			<tr>
				<th>리뷰 내용</th>
				<td>
					<textarea cols="50" rows="4" name="reviewContent" required="required"></textarea>
				</td>
			</tr>
			<tr>
				<th rowspan="3">리뷰 이미지</th>
				<td>
					jpg 파일만 선택하세요.<input type="file" name="reviewImgFile1">
				</td>
			</tr>
			<tr>
				<td>
					jpg 파일만 선택하세요.<input type="file" name="reviewImgFile2">
				</td>
			</tr>
			<tr>
				<td>
					jpg 파일만 선택하세요.<input type="file" name="reviewImgFile3">
				</td>
			</tr>
		</table>
		<button type="submit">작성</button>
	</form>
</body>
</html>
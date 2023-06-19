<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	/* if (session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	} */
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
	<h4>앨범 입력</h4>
	<hr>
	<form action="<%=request.getContextPath()%>/product/insertProductAction.jsp" method="post" enctype="multipart/form-data">
	<table class="table">
		<tr>
			<th>앨범 카테고리</th>
			<td>
				<select name="categoryMainName">
					<option value="한국">한국</option>
					<option value="미국">미국</option>
					<option value="일본">일본</option>
				</select>
				<select name="categorySubName">
					<option value="싱글">싱글</option>
					<option value="정규">정규</option>
					<option value="ep">ep</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>앨범 제목</th>
			<td>
				<input type="text" name="productName" required="required">
			</td>
		</tr>
		<tr>
			<th>앨범 가격</th>
			<td>
				<input type="number" name="productPrice" required="required">
			</td>
		</tr>
		<tr>
			<th>앨범 재고량</th>
			<td>
				<input type="number" name="productStock" required="required">
			</td>
		</tr>
		<tr>
			<th>앨범 가수명</th>
			<td>
				<input type="text" name="productSinger" required="required">
			</td>
		</tr>
		<tr>
			<th>앨범 수록곡 수</th>
			<td>
				<input type="number" name="totalTrackCnt" required="required">
			</td>
		</tr>
		<tr>
			<th>앨범 설명</th>
			<td>
				<textarea cols="50" rows="4" name="productInfo" required="required"></textarea>
			</td>
		</tr>
		<tr>
			<th>앨범 재킷</th>
			<td>
				jpg 파일만 선택하세요.<input type="file" name="productImgFile" required="required">
			</td>
		</tr>
	</table>
	<button type="submit">입력</button>
	</form>
</body>
</html>
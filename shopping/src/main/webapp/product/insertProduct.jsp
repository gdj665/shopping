<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>앨범 추가</h1>
	<form action="<%=request.getContextPath()%>/product/insertProductAction.jsp" method="post" enctype="multipart/form-data">
	<table>
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
				<input type="text" name="productName">
			</td>
		</tr>
		<tr>
			<th>앨범 가격</th>
			<td>
				<input type="number" name="productPrice">
			</td>
		</tr>
		<tr>
			<th>앨범 재고량</th>
			<td>
				<input type="number" name="productStock">
			</td>
		</tr>
		<tr>
			<th>앨범 가수명</th>
			<td>
				<input type="text" name="productSinger">
			</td>
		</tr>
		<tr>
			<th>앨범 설명</th>
			<td>
				<textarea cols="50" rows="4" name="productInfo"></textarea>
			</td>
		</tr>
		<tr>
			<th>앨범 재킷</th>
			<td>
				jpg 파일만 선택하세요.<input type="file" name="productImgFile" required="required">
			</td>
		</tr>
	</table>
	<button type="submit">추가</button>
	</form>
</body>
</html>
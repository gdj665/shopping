<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.product.*" %>
<%@ page import = "java.util.*" %>
<%
	//controller
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	MainDao md = new MainDao();
	
	// 앨범 세부 내용
	Product p = new Product();
	p = md.selectProductOne(productNo);
	
	// 수록곡 리스트
	ArrayList<Track> trackList = new ArrayList<>();
	trackList = md.selectTrack(productNo);
	
	// 카테고리 네임
	String[] categoryName = md.printCategory(p.getCategoryNo());
	
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
	<h1>앨범 정보 수정</h1>
	<form action="<%=request.getContextPath()%>/product/updateProductAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="productNo" value="<%=productNo%>">
		<table>
			<tr>
				<td rowspan="8">
					<div>
						<img src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
					</div>
					<div>
						jpg 파일만 선택하세요.<input type="file" name="productImgFile">
					</div>
				</td>
			<tr>
				<th>
					앨범 이름
				</th>
				<th>
					판매 상태
				</th>
			</tr>
			<tr>
				<td>
					<input type="text" name="productName" value="<%=p.getProductName()%>" required="required">
				</td>
				<td>
					<select name="productStatus" required="required">
						<option value="<%=p.getProductStatus()%>"><%=p.getProductStatus()%></option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>
					앨범 가격
				</th>
				<th>
					앨범 수량
				</th>
			</tr>
			<tr>
				<td>
					<input type="number" name="productPrice" value="<%=p.getProductPrice()%>" required="required">
				</td>
				<td>
					<input type="number" name="productStock" value="<%=p.getProductStock()%>" required="required">
				</td>
			</tr>
			<tr>
				<th>
					카테고리
				</th>
				<th>
					가수
				</th>
			</tr>
			<tr>
				<td>
					<select name="categoryMainName" required="required">
						<option value="<%=categoryName[0]%>"><%=categoryName[0]%></option>
						<option value="한국">한국</option>
						<option value="미국">미국</option>
						<option value="일본">일본</option>
					</select>
					<select name="categorySubName" required="required">
						<option value="<%=categoryName[1]%>"><%=categoryName[1]%></option>
						<option value="싱글">싱글</option>
						<option value="정규">정규</option>
						<option value="ep">ep</option>
					</select>
				</td>
				<td>
					<input type="text" name="productSinger" value="<%=p.getProductSinger()%>" required="required">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea cols="50" rows="4" name="productInfo" required="required"><%=p.getProductInfo()%></textarea>
				</td>
			</tr>
		</table>
		<h2>수록곡(<%=trackList.size()%>)</h2>
		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>재생시간</th>
				<th>삭제</th>
				<th>
					<a href="<%=request.getContextPath()%>/product/addTrackAction.jsp?productNo=<%=productNo%>&trackNo=<%=trackList.size() + 1%>">
						추가
					</a>
				</th>
			</tr>
		<%
			for (Track t : trackList){
		%>
			<tr>
				<td>
					<input type="number" name="trackNo" value="<%=t.getTrackNo()%>" required="required">
					<input type="hidden" name="productTrackNo" value="<%=t.getProductTrackNo()%>">
				</td>
				<td>
					<input type="text" name="trackName" value="<%=t.getTrackName()%>" required="required">
				</td>
				<td>
					<input type="number" name="trackTime" value="<%=t.getTrackTime()%>" required="required">
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/product/deleteTrackAction.jsp?productNo=<%=t.getProductNo()%>&trackNo=<%=t.getTrackNo()%>">
						삭제
					</a>
				</td>
			</tr>
		<%
			}
		%>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
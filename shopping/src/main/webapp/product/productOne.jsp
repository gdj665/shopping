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
	ReviewDao rd = new ReviewDao();
	
	// 앨범 세부 내용
	Product p = new Product();
	p = md.selectProductOne(productNo);
	
	// 수록곡 리스트
	ArrayList<Track> trackList = new ArrayList<>();
	trackList = md.selectTrack(productNo);
	
	// 초로 분계산
	
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
	<h1>앨범 정보</h1>
	<a href="<%=request.getContextPath()%>/product/updateProduct.jsp?productNo=<%=productNo%>">
		수정
	</a>
	<a href="<%=request.getContextPath()%>/product/deleteProductAction.jsp?productNo=<%=productNo%>">
		삭제
	</a>
	<table>
		<tr>
			<td>
				<img src="<%=request.getContextPath() + "/img/productImg/" + p.getProductSaveFilename()%>">
			</td>
			<td>
				<%=p.getProductName()%>
			</td>
			<td>
				<%=md.calculateTime(p.getTrackSumTime())%>
			</td>
		</tr>
	</table>
	<h2>수록곡(<%=trackList.size()%>)</h2>
	<table>
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
	<%
		if(rd.selectReviewTitleList(productNo).size() != 0){
			
	%>
			<div>
				<jsp:include page="/inc/reviewList.jsp"></jsp:include>
			</div>
	<%	
		};
	%>
</body>
</html>
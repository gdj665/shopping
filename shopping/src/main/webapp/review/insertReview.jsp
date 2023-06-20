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
	String id = (String)session.getAttribute("loginId");
	boolean checkId = rd.checkId(id, productNo);
	// System.out.println(checkId);
	if(!checkId){
		System.out.println("접근권한이 없습니다.");
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let cnt = 0;
		$('#imgCnt').val(cnt);
		$('#addFile').click(function(){
			if($('.pic').length == 0){
				cnt++;
				let inputName = "reviewImgFile" + cnt;
				$('#files').append("<div><input type=\"file\" name=" + inputName + " class=\"pic\"></div>");
				console.log(inputName);
				$('#imgCnt').val(cnt);
			} else {
				if($('.pic').last().val() == ''){
					alert('빈 파일업로드 태그가 있읍니다.');
				} else {
					cnt++;
					let inputName = "reviewImgFile" + cnt;
					$('#files').append("<div><input type=\"file\" name=" + inputName + " class=\"pic\"></div>");
					console.log(inputName);
					console.log(cnt);
					$('#imgCnt').val(cnt);
				}
			}
		})
		$('#delFile').click(function(){
			$('.pic').last().remove();
			cnt--;
			console.log(cnt);
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
	<h4><%=productName%> 앨범 리뷰 작성 페이지</h4>
	<hr>
	<form action="<%=request.getContextPath()%>/review/insertReviewAction.jsp" method="post" enctype="multipart/form-data" id="insertForm">
		<input type="hidden" id="imgCnt" name="imgCnt">
		<input type="hidden" name="productNo" value="<%=productNo%>">
		<table class="table">
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
		</table>
		<div>
			리뷰 이미지
			<button class="btn btn-sm btn-outline-danger" id="addFile" type="button">파일추가</button>
			<button class="btn btn-sm btn-outline-danger" id="delFile" type="button">파일삭제</button>
		</div>
		<div>
			jpg 파일만 업로드 가능합니다.
		</div>
		<div id="files"></div>
		<button id="submit">작성</button>
	</form>
</body>
</html>
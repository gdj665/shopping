<%@page import="java.util.ArrayList"%>
<%@page import="vo.product.Review"%>
<%@page import="dao.main.ReviewDao"%>
<%@page import="dao.main.MainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("reviewNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	// id 유효성 검사
	String id = (String)session.getAttribute("loginId");
	ReviewDao rd = new ReviewDao();
	ArrayList<String> idList = new ArrayList<>();
	idList = rd.checkId(reviewNo);
	boolean checkId = false;
	
	for (String s : idList){
		if (s.equals(id)){
			checkId = true;
			System.out.println("id 일치");
		}
		if (!checkId){
			System.out.println("접근권한이 없습니다.");
			response.sendRedirect(request.getContextPath() + "/review/review.jsp?reviewNo=" + reviewNo);
			return;
		}
	}
	Review review = new Review();
	review = rd.selectReview(reviewNo);
	ArrayList<Review> reviewImgList = new ArrayList<>();
	reviewImgList = rd.selectReviewImg(reviewNo);
	System.out.println(reviewImgList.size());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let cnt = $('#reviewImgCnt').val();
		console.log(cnt);
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
	<h4>리뷰 수정 페이지</h4>
	<hr>
	<form action="<%=request.getContextPath()%>/review/updateReviewAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" id="imgCnt" name="imgCnt">
		<input type="hidden" id="reviewImgCnt" value="<%=reviewImgList.size()%>">
		<input type="hidden" name="reviewNo" value="<%=reviewNo%>">
		<table class="table">
			<tr>
				<th>리뷰 제목</th>
				<td>
					<input type="text" name="reviewTitle" value="<%=review.getReviewTitle()%>" required="required">
				</td>
			</tr>
			<tr>
				<th>리뷰 내용</th>
				<td>
					<textarea cols="50" rows="4" name="reviewContent" required="required"><%=review.getReviewContent()%></textarea>
				</td>
			</tr>
		</table>
		<div>
			리뷰 이미지
		</div>
	<%
			// 리뷰 이미지 있는것만 출력
			// 이전 save file 넘겨서 리뷰 파일에 데이터 있으면 이전 파일 삭제하고 새파일 저장 없으면 x 
			int cnt = 0;
			for(Review r : reviewImgList){
				cnt++;
	%>
				<div>
					<img src="<%=request.getContextPath() + "/img/reviewImg/" + r.getReviewSaveFilename()%>">
				</div>
				<div>
					jpg 파일만 선택하세요.<input type="file" name="reviewImgFile<%=cnt%>">
					<input type="hidden" name="preSaveFilename<%=cnt%>" value="<%=r.getReviewSaveFilename()%>">
					<a href="<%=request.getContextPath()%>/review/deleteReviewImgAction.jsp?reviewNo=<%=reviewNo%>&reviewSaveFilename=<%=r.getReviewSaveFilename()%>">
						삭제
					</a>
				</div>
	<%	
			}
	%>
		<div>
			jpg 파일만 업로드 가능합니다.
		</div>
		<div id="files"></div>
		<div>
			<button class="btn btn-sm btn-outline-danger" id="addFile" type="button">파일추가</button>
			<button class="btn btn-sm btn-outline-danger" id="delFile" type="button">파일추가 취소</button>
			<button class="btn btn-sm btn-outline-danger" type="submit">수정</button>
		</div>
	</form>
</body>
</html>
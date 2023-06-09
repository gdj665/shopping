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
	// String id = (String)session.getAttribute("loginId");
	String id = "aa";
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
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>리뷰 수정 페이지</h4>
	<form action="<%=request.getContextPath()%>/review/updateReviewAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="reviewNo" value="<%=reviewNo%>">
		<table>
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
			<tr>
				<th rowspan="3">리뷰 이미지</th>
	<%
			// 리뷰 이미지 있는것만 출력
			// 이전 save file 넘겨서 리뷰 파일에 데이터 있으면 이전 파일 삭제하고 새파일 저장 없으면 x 
			int cnt = 1;
			for(Review r : reviewImgList){
	%>
					<td>
						<img src="<%=request.getContextPath() + "/img/reviewImg/" + r.getReviewSaveFilename()%>">
						jpg 파일만 선택하세요.<input type="file" name="reviewImgFile<%=cnt%>">
						<input type="hidden" name="preSaveFilename<%=cnt%>" value="<%=r.getReviewSaveFilename()%>">
					</td>
					<td>
						<a href="<%=request.getContextPath()%>/review/deleteReviewImgAction.jsp?reviewNo=<%=reviewNo%>&reviewSaveFilename=<%=r.getReviewSaveFilename()%>">
							삭제
						</a>
					</td>
				</tr>
				<tr>
	<%	
				cnt++;
			}
			while (cnt <= 3) {
	%>
					<td colspan="2">
						jpg 파일만 선택하세요.<input type="file" name="reviewImgFile<%=cnt%>">
					</td>
				</tr>
				<tr>
	<%
				cnt++;
			}
	%>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>
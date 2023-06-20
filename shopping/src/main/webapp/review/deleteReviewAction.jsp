<%@page import="vo.product.Review"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="dao.main.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("reviewNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	String dir = request.getServletContext().getRealPath("/img/reviewImg");
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	// id 유효성 검사
	String id = (String)session.getAttribute("loginId");
	System.out.println(id);
	ReviewDao rd = new ReviewDao();
	ArrayList<String> idList = new ArrayList<>();
	idList = rd.checkId(reviewNo);
	boolean checkId = false;
	
	for (String s : idList){
		if (s.equals(id)){
			checkId = true;
			System.out.println("id 일치");
			break;
		}
	}
	if (!checkId){
		response.sendRedirect(request.getContextPath() + "/review/review.jsp?reviewNo=" + reviewNo);
		System.out.println("접근권한이 없습니다.");
		return;
	}
	ArrayList<Review> deleteReviewImgList = new ArrayList<>();
	deleteReviewImgList = rd.selectReviewImg(reviewNo);
	
	
	//이전 파일 삭제
	for(Review r : deleteReviewImgList){
		int checkDelete = rd.deleteReviewImg(reviewNo, r.getReviewSaveFilename());
		
		File f = new File(dir + "\\" + r.getReviewSaveFilename());
		if(f.exists()){
			f.delete();
		System.out.println(dir + "\\" + r.getReviewSaveFilename() + "파일삭제");
		}
	}
	
	int checkDeleteReview = rd.deleteReview(reviewNo);
	
	System.out.println(checkDeleteReview + " <- checkDeleteReview");
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
%>

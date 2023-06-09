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
	String reviewSaveFilename = request.getParameter("reviewSaveFilename");
	
	ReviewDao rd = new ReviewDao();
	
	//이전 파일 삭제
	int checkDelete = rd.deleteReviewImg(reviewNo, reviewSaveFilename);
	
	File f = new File(dir + "\\" + reviewSaveFilename);
	if(f.exists()){
		f.delete();
	System.out.println(dir + "\\" + reviewSaveFilename + "파일삭제");
	}
	response.sendRedirect(request.getContextPath() + "/review/updateReview.jsp?reviewNo=" + reviewNo);
%>

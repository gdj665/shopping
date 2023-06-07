<%@page import="dao.main.MainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("productNo") == null
			||request.getParameter("trackNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	// System.out.println(productNo + " <- deleteTrack productNo");
	int trackNo = Integer.parseInt(request.getParameter("trackNo"));
	// System.out.println(trackNo + " <- deleteTrack trackNo");
	// 주문 내역 없으면 삭제 가능
	MainDao md = new MainDao();
	int check = md.deleteTrack(productNo, trackNo);
	// System.out.println(check + " <- deleteTrack");
	
	response.sendRedirect(request.getContextPath() + "/product/updateProduct.jsp?productNo=" + productNo);
%>

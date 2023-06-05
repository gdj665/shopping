<%@page import="dao.main.MainDao"%>
<%@page import="com.oreilly.servlet.MailMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String dir = request.getServletContext().getRealPath("/img/productImg");
	
	// 주문 내역 없으면 삭제 가능
	MainDao md = new MainDao();
	int check = md.deleteProduct(productNo, dir);
	System.out.println(check + " <- deleteProduct");
	
	response.sendRedirect(request.getContextPath() + "/home.jsp");
%>

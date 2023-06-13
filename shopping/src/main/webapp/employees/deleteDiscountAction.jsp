<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	
	EmployeesDao ed = new EmployeesDao();
	// 할인삭제
	int checkDelete = ed.deleteDiscount(discountNo);
	System.out.println(checkDelete + " <- checkDelete");
	response.sendRedirect(request.getContextPath() + "/employees/discountList.jsp");
%>

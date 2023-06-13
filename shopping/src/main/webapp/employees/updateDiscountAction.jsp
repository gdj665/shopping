<%@page import="vo.product.Discount"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountBegin = request.getParameter("discountBegin");
	String discountEnd = request.getParameter("discountEnd");
	double discountRate = (double)Integer.parseInt(request.getParameter("discountRate")) / 100;
	
	EmployeesDao ed = new EmployeesDao();
	Discount d = new Discount();
	d.setDiscountBegin(discountBegin);
	d.setProductNo(productNo);
	d.setDiscountEnd(discountEnd);
	d.setDiscountRate(discountRate);
	
	// 할인 유효성 검사
	if (!ed.checkDiscount(d)){
		response.sendRedirect(request.getContextPath() + "/employees/updateDiscount.jsp?discountNo=" + discountNo);
		System.out.println("중복되는 할인이 있습니다.");
		return;
	}
	
	// 할인 수정
	int checkUpdate = ed.updateDiscount(discountNo, d);
	System.out.println(checkUpdate + " <- checkUpdate");
	response.sendRedirect(request.getContextPath() + "/employees/updateDiscount.jsp?discountNo=" + discountNo);
%>

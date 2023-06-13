<%@page import="vo.product.Discount"%>
<%@page import="dao.main.EmployeesDao"%>
<%@page import="vo.product.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.MainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountBegin = request.getParameter("discountBegin");
	String discountEnd = request.getParameter("discountEnd");
	double discountRate = (double)Integer.parseInt(request.getParameter("discountRate")) / 100;
	
	// productNo 유효성 체크
	MainDao md = new MainDao();
	ArrayList<Product> productList = new ArrayList<>();
	productList = md.selectProduct();
	boolean checkProductNo = false;
	for (Product p : productList){
		if(productNo == p.getProductNo()){
			checkProductNo = true;
		}
	}
	if (checkProductNo != true){
		response.sendRedirect(request.getContextPath() + "/employees/insertDiscount.jsp");
		System.out.println("유효하지않음 품목");
		return;
	}
	Discount discount = new Discount();
	discount.setProductNo(productNo);
	discount.setDiscountBegin(discountBegin);
	discount.setDiscountEnd(discountEnd);
	discount.setDiscountRate(discountRate);
	EmployeesDao ed = new EmployeesDao();
	
	// discount 유효성 체크
	if (!ed.checkDiscount(discount)){
		response.sendRedirect(request.getContextPath() + "/employees/insertDiscount.jsp");
		System.out.println("중복된 할인");
		return;
	}
	
	int checkInsert = ed.insertDiscount(discount);
	System.out.println(checkInsert + " <- checkInsert");
	response.sendRedirect(request.getContextPath() + "/employees/discountList.jsp");
%>

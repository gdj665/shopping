<%@page import="vo.product.Discount"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if(session.getAttribute("loginId") == null){
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//값 받기
	String id = (String)session.getAttribute("loginId");
	
	// EmployeesDao 선언
	EmployeesDao ed = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(id);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 유의성 검사
	if(request.getParameter("discountNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// param값 선언
	int discountNo = Integer.parseInt(request.getParameter("discountNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String discountBegin = request.getParameter("discountBegin");
	String discountEnd = request.getParameter("discountEnd");
	double discountRate = (double)Integer.parseInt(request.getParameter("discountRate")) / 100;
	
	// 수정된값 vo에 저장
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

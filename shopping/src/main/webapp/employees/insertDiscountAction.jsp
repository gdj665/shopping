<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="vo.product.Discount"%>
<%@page import="dao.main.EmployeesDao"%>
<%@page import="vo.product.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.MainDao"%>
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
	
	// 제품번호 없으면 홈
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}
	
	// param 값 선언
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	double discountRate = (double)Integer.parseInt(request.getParameter("discountRate")) / 100;

	// 날짜 데이터 입력 안하면 오늘 자로 입력
	String discountBegin = request.getParameter("discountBegin");
	if ("".equals(request.getParameter("discountBegin"))){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		discountBegin = dateFormat.format(today);
	}
	String discountEnd = request.getParameter("discountEnd");
	if ("".equals(request.getParameter("discountEnd"))){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		discountEnd = dateFormat.format(today);
	}
	
	// productNo 유효성 체크
	MainDao md = new MainDao();
	ArrayList<Product> productList = new ArrayList<>();
	productList = md.selectProduct();
	boolean checkProductNo = false;
	for (Product p : productList){
		if(productNo == p.getProductNo()){
			checkProductNo = true;
			break;
		}
	}
	if (checkProductNo != true){
		response.sendRedirect(request.getContextPath() + "/employees/insertDiscount.jsp");
		System.out.println("유효하지않음 품목");
		return;
	}
	
	// db 입력을 위해 vo에 값 대입
	Discount discount = new Discount();
	discount.setProductNo(productNo);
	discount.setDiscountBegin(discountBegin);
	discount.setDiscountEnd(discountEnd);
	discount.setDiscountRate(discountRate);
	
	// discount 유효성 체크
	if (!ed.checkDiscount(discount)){
		response.sendRedirect(request.getContextPath() + "/employees/insertDiscount.jsp");
		System.out.println("중복된 할인");
		return;
	}
	
	// discount 입력
	int checkInsert = ed.insertDiscount(discount);
	System.out.println(checkInsert + " <- checkInsert");
	response.sendRedirect(request.getContextPath() + "/employees/discountList.jsp");
%>

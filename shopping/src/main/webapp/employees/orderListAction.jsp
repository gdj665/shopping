<%@page import="java.util.ArrayList"%>
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
	String loginId = (String)session.getAttribute("loginId");
	
	// EmployeesDao 선언
	EmployeesDao ed = new EmployeesDao();
	
	// 관리자 레벨 출 력
	int empLevel = ed.checkEmployees(loginId);
	
	// 관리자가 아닐시 홈화면으로
	if(empLevel<1){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 유의성 검사
	if (request.getParameter("orderStatus") == null
			|| request.getParameterValues("checkedOrderNo") == null){
		response.sendRedirect(request.getContextPath() + "/employees/orderList.jsp");
		return;
	}
	
	// param값 선언
	int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));
	String id = request.getParameter("id");
	String[] checkedOrderNo = request.getParameterValues("checkedOrderNo");
	System.out.println(orderStatus + " <- orderStatus");
	System.out.println(checkedOrderNo[0] + " <- checkedOrderNo");
	
	// orderStatus update
	int checkUpdate = ed.orderStatusUpdate(orderStatus, checkedOrderNo,id);
	System.out.println(checkUpdate + " <- checkUpdate");
	
	response.sendRedirect(request.getContextPath() + "/employees/orderList.jsp");
%>

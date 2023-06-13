<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("orderStatus") == null
			|| request.getParameterValues("checkedOrderNo") == null){
		response.sendRedirect(request.getContextPath() + "/employees/orderList.jsp");
		return;
	}
	int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));
	String[] checkedOrderNo = request.getParameterValues("checkedOrderNo");
	System.out.println(orderStatus + " <- orderStatus");
	System.out.println(checkedOrderNo[0] + " <- checkedOrderNo");
	
	EmployeesDao ed = new EmployeesDao();
	int checkUpdate = ed.orderStatusUpdate(orderStatus, checkedOrderNo);
	System.out.println(checkUpdate + " <- checkUpdate");
	
	response.sendRedirect(request.getContextPath() + "/employees/orderList.jsp");
%>

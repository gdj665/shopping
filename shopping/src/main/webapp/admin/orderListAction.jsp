<%@page import="java.util.ArrayList"%>
<%@page import="dao.main.AdminDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("orderStatus") == null
			|| request.getParameterValues("checkedOrderNo") == null){
		response.sendRedirect(request.getContextPath() + "/order/orderList.jsp");
		return;
	}
	int orderStatus = Integer.parseInt(request.getParameter("orderStatus"));
	String[] checkedOrderNo = request.getParameterValues("checkedOrderNo");
	System.out.println(orderStatus + " <- orderStatus");
	System.out.println(checkedOrderNo[0] + " <- checkedOrderNo");
	
	AdminDao ad = new AdminDao();
	int checkUpdate = ad.orderStatusUpdate(orderStatus, checkedOrderNo);
	System.out.println(checkUpdate + " <- checkUpdate");
	
	response.sendRedirect(request.getContextPath() + "/admin/orderList.jsp");
%>

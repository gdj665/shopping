<%@page import="vo.id.Employees"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cstmId = request.getParameter("cstmId");
	int cstmActive = Integer.parseInt(request.getParameter("cstmActive"));
	//System.out.println(employeesId + " <-employeesId");
	//System.out.println(preEmployeesId + " <-preEmployeesId");
	//System.out.println(employeesLevel + " <-employeesLevel");
	
	EmployeesDao ed = new EmployeesDao();
	int checkUpdate = ed.updateCustomer(cstmId, cstmActive);
	response.sendRedirect(request.getContextPath() + "/employees/customerOneControl.jsp?customerId=" + cstmId);
%>
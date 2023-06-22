<%@page import="java.net.URLEncoder"%>
<%@page import="vo.id.Employees"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String empId = request.getParameter("employeesId");
	String empPw = request.getParameter("employeesPw");
	String empName = request.getParameter("employeesName");
	int empLevel = Integer.parseInt(request.getParameter("employeesLevel"));
	Employees employees = new Employees();
	employees.setId(empId);
	employees.setEmpPw(empPw);
	employees.setEmpName(empName);
	employees.setEmpLevel(empLevel);
	
	EmployeesDao ed = new EmployeesDao();
	if (ed.checkId(empId)){
		String msg = URLEncoder.encode("중복된 id 입니다","utf-8");
		response.sendRedirect(request.getContextPath() + "/employees/insertEmployees.jsp?msg=" + msg);
		return;
	}
	int checkInsert = ed.insertEmployees(employees);
	response.sendRedirect(request.getContextPath() + "/employees/employeesControl.jsp");
%>
<%@page import="vo.id.Employees"%>
<%@page import="dao.main.EmployeesDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String employeesId = request.getParameter("employeesId");
	String employeesPw = request.getParameter("employeesPw");
	String employeesNewPw = request.getParameter("employeesNewPw");
	String preEmployeesId = request.getParameter("preEmployeesId");
	String employeesName = request.getParameter("employeesName");
	int employeesLevel = Integer.parseInt(request.getParameter("employeesLevel"));
	//System.out.println(employeesId + " <-employeesId");
	//System.out.println(preEmployeesId + " <-preEmployeesId");
	//System.out.println(employeesLevel + " <-employeesLevel");
	
	if (employeesPw.equals(employeesNewPw)){
		System.out.println("다른비번 입력");
		response.sendRedirect(request.getContextPath() + "/employees/employeesOneControl.jsp?employeesId=" + employeesId);
		return;
	}
	EmployeesDao ed = new EmployeesDao();
	Employees employees = new Employees();
	employees.setId(employeesId);
	employees.setEmpPw(employeesPw);
	employees.setEmpName(employeesName);
	employees.setEmpLevel(employeesLevel);
	if (!ed.checkPw(employees)){
		System.out.println("비번틀림");
		response.sendRedirect(request.getContextPath() + "/employees/employeesOneControl.jsp?employeesId=" + employeesId);
		return;
	}
	if (request.getParameter("employeesNewPw") != null){
		employees.setEmpPw(employeesNewPw);
	}
	int checkUpdateEmp = 0; 
	if (preEmployeesId.equals(employeesId)){
		checkUpdateEmp = ed.updateEmployees(employees);
	} else {
		checkUpdateEmp = ed.updateEmployees(preEmployeesId, employees);
	}
	System.out.println(checkUpdateEmp + " <- checkUpdateEmp");
	response.sendRedirect(request.getContextPath() + "/employees/employeesOneControl.jsp?employeesId=" + employeesId);
%>
<%@page import="vo.id.Employees"%>
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

	// param 값 선언
	String cstmId = request.getParameter("cstmId");
	int cstmActive = Integer.parseInt(request.getParameter("cstmActive"));
	//System.out.println(employeesId + " <-employeesId");
	//System.out.println(preEmployeesId + " <-preEmployeesId");
	//System.out.println(employeesLevel + " <-employeesLevel");
	
	// customerActive update
	int checkUpdate = ed.updateCustomer(cstmId, cstmActive);
	response.sendRedirect(request.getContextPath() + "/employees/customerOneControl.jsp?customerId=" + cstmId);
%>
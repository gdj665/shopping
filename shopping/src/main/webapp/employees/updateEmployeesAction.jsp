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

	// param값 선언
	String employeesId = request.getParameter("employeesId");
	String employeesPw = request.getParameter("employeesPw");
	String employeesNewPw = request.getParameter("employeesNewPw");
	String preEmployeesId = request.getParameter("preEmployeesId");
	String employeesName = request.getParameter("employeesName");
	int employeesLevel = Integer.parseInt(request.getParameter("employeesLevel"));
	//System.out.println(employeesId + " <-employeesId");
	//System.out.println(preEmployeesId + " <-preEmployeesId");
	//System.out.println(employeesLevel + " <-employeesLevel");
	
	// 비밀번호 유의성 검사
	if (employeesPw.equals(employeesNewPw)){
		System.out.println("다른비번 입력");
		response.sendRedirect(request.getContextPath() + "/employees/employeesOneControl.jsp?employeesId=" + employeesId);
		return;
	}
	
	// 수정데이터 vo에 저장
	Employees employees = new Employees();
	employees.setId(employeesId);
	employees.setEmpPw(employeesPw);
	employees.setEmpName(employeesName);
	employees.setEmpLevel(employeesLevel);
	
	// 비밀번호 체크
	if (!ed.checkPw(employees)){
		System.out.println("비번틀림");
		response.sendRedirect(request.getContextPath() + "/employees/employeesOneControl.jsp?employeesId=" + employeesId);
		return;
	}
	
	// 새 비밀번호 기존 비밀번호랑 교체 
	if (request.getParameter("employeesNewPw") != null){
		employees.setEmpPw(employeesNewPw);
	}
	
	// id 바꾼지 안바꾼지에 대한 분기
	int checkUpdateEmp = 0; 
	if (preEmployeesId.equals(employeesId)){
		checkUpdateEmp = ed.updateEmployees(employees);
	} else {
		checkUpdateEmp = ed.updateEmployees(preEmployeesId, employees);
	}
	System.out.println(checkUpdateEmp + " <- checkUpdateEmp");
	response.sendRedirect(request.getContextPath() + "/employees/employeesOneControl.jsp?employeesId=" + employeesId);
%>
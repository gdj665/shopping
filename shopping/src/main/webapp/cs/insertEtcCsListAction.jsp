<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "dao.main.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
		
	//유효성 검사
	if(request.getParameterValues("oqTitle")==null
		||request.getParameterValues("oqContent")==null
		||session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
		
	// 값받기
	String oqTitle = request.getParameter("oqTitle");
	String oqContent = request.getParameter("oqContent");
	String id = (String)session.getAttribute("loginId");

	
	//CsDao.java 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	int row = 0;
	int empLevel = employeesdao.checkEmployees(id);
	if(empLevel==0){
		// 6) 1대1 문의 추가 메서드
		row = csdao.insertCsList(id,oqTitle,oqContent);
	}
	
	if(row>0){
		System.out.println("insertEtcCsListAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/etcCsList.jsp?id="+id);
		return;
	} else {
		System.out.println("insertEtcCsListAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
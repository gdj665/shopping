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
	
	//유효성 검사 1
	if(request.getParameterValues("productNo")==null
		||request.getParameterValues("aNo")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("deleteProductAnswerAction null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//유효성 검사 2
	if(session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("deleteProductAnswerAction ID값 null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값받기
	String id = (String)session.getAttribute("loginId");
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	// Dao사용선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	// 값선언
	int empLevel = employeesdao.checkEmployees(id);
	// 성공한 sql문
	int row = 0;
	
	// 관리자만 가능
	if(empLevel>0){
		// 13) 제품 문의 댓글 삭제 메서드
		row = csdao.deleteProductAnswer(aNo);
	}
	
	if(row>0){
		System.out.println("deleteProductAnswerAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
		return;
	} else {
		System.out.println("deleteProductAnswerAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
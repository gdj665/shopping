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
	if(request.getParameterValues("productNo")==null
		||request.getParameterValues("qNo")==null
		||session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("deleteProductQuestionAction null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값받기
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String id = (String)session.getAttribute("loginId");

	//CsDao.java 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	// 관리자or고객 분기
	int empLevel = employeesdao.checkEmployees(id);
	int row = 0;
	
	// 고객만 사용가능
	if(empLevel==0){
		// 14) 제품 문의 질문 삭제 메서드
		row = csdao.deleteProductQuestion(qNo);
	}
	
	if(row>0){
		System.out.println("deleteProductQuestionAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/product/productOne.jsp?productNo="+productNo);
		return;
	} else {
		System.out.println("deleteProductQuestionAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
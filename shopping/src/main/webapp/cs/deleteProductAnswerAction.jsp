<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
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
		||request.getParameterValues("aNo")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값받기
	String id = "admin";
	int aNo = Integer.parseInt(request.getParameter("aNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	//CsDao.java 선언
	CsDao csdao = new CsDao();

	// 4) 질문 입력테이블에 질문 입력하면 질문 테이블에 데이터 추가
	int row = csdao.deleteProductAnswer(aNo);
	
	if(row==1){
		System.out.println("deleteProductAnswerAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/productCsList.jsp?productNo="+productNo);
		return;
	} else {
		System.out.println("deleteProductAnswerAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
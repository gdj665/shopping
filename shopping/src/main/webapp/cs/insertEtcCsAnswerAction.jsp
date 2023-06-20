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
	if(request.getParameterValues("oqNo")==null
		||request.getParameterValues("oaContent")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값받기
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	String oaContent = request.getParameter("oaContent");
	String id = (String)session.getAttribute("loginId");
	
	//CsDao.java 선언
	CsDao csdao = new CsDao();
	EmployeesDao employeesdao = new EmployeesDao();
	
	// empLevel분기
	int empLevel = employeesdao.checkEmployees(id);
	int row = 0;
	
	// 분기 값에 따라서 해당 댓글이 관리자 댓글인지 고객 댓글인지 판별
	if(empLevel==0){
		// 8) 답변 입력 메서드
		row = csdao.insertEtcCs(oqNo,oaContent,id);
	} else if(empLevel>0){
		// 8-1) 관리자 답변 입력 메서드
		row = csdao.insertEmpAnswer(oqNo,oaContent,id);
	}
	
	if(row>0){
		System.out.println("insertEtcCsAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/etcCsOne.jsp?oqNo="+oqNo);
		return;
	} else {
		System.out.println("insertEtcCsAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
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
		||request.getParameterValues("qNo")==null
		||request.getParameter("aContent")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("productCsListAction null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//유효성 검사 2
	if(session.getAttribute("loginId")==null
		&&session.getAttribute("loginEmpId1")==null
		&&session.getAttribute("loginEmpId2")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("insertProductCsAction ID값 null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값받기
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int qNo = Integer.parseInt(request.getParameter("qNo"));
	String aContent = request.getParameter("aContent");
	String id = (String)session.getAttribute("loginId");
	
	if((String)session.getAttribute("loginEmpId1")!=null){
		id = (String)session.getAttribute("loginEmpId1");
	} else if ((String)session.getAttribute("loginEmpId2")!=null){
		id = (String)session.getAttribute("loginEmpId2");
	}

	//CsDao.java 선언
	CsDao csdao = new CsDao();
	
	
	// 3) 댓글입력시 댓글 정보 추가
	int row = csdao.insertProductContent(qNo,aContent,id);
	
	if(row==1){
		System.out.println("productCsListAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/productCsList.jsp?id="+productNo);
		return;
	} else {
		System.out.println("productCsListAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
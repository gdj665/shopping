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
	if(request.getParameterValues("oqNo")==null
		||request.getParameterValues("oaContent")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//CsDao.java 선언
	CsDao csdao = new CsDao();
	int row = 0;
	// 값받기
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	String oaContent = request.getParameter("oaContent");
	String id = null;
	
	if(session.getAttribute("loginId")!=null){
		id = (String)session.getAttribute("loginId");
		
		// 8) 1대1 문의 답변 추가
		row = csdao.insertEtcCs(oqNo,oaContent,id);
		
	} else if(session.getAttribute("loginEmpId1")!=null){
		id = (String)session.getAttribute("loginEmpId1");
		
		// 8-1) 1대1 문의 답변 추가(관리자 버전)
		row = csdao.insertEmpAnswer(oqNo,oaContent,id);
		
	} else if (session.getAttribute("loginEmpId2")!=null){
		id = (String)session.getAttribute("loginEmpId2");
		
		// 8-1) 1대1 문의 답변 추가(관리자 버전)
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
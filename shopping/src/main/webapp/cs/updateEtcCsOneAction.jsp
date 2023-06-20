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
		||request.getParameterValues("oqTitle")==null
		||request.getParameter("oqContent")==null){
		
		// null값이 있을 경우 홈으로 이동
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//유효성 검사2
	if(session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("updateEtcCsOneAction Id null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값받기
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	String oqTitle = request.getParameter("oqTitle");
	String oqContent = request.getParameter("oqContent");
	String id = (String)session.getAttribute("loginId");

	//CsDao.java 선언
	CsDao csdao = new CsDao();
	
	// 11) ETC문의글 수정 메서드
	int row = csdao.updateEtcCsOne(oqTitle,oqContent,oqNo);
	
	if(row>0){
		System.out.println("updateEtcCsOneAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/etcCsOne.jsp?oqNo="+oqNo);
		return;
	} else {
		System.out.println("updateEtcCsOneAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
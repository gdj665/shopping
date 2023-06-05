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
	
	// 메세지 출력 설정
	String msg = null;
	
	// 값받기
	int oqNo = Integer.parseInt(request.getParameter("oqNo"));
	String oqTitle = request.getParameter("oqTitle");
	String oqContent = request.getParameter("oqContent");
	String id = "admin";

	//CsDao.java 선언
	CsDao csdao = new CsDao();
	
	// 4) 질문 입력테이블에 질문 입력하면 질문 테이블에 데이터 추가
	int row = csdao.updateEtcCsOne(oqTitle,oqContent,oqNo);
	
	if(row==1){
		System.out.println("updateEtcCsOneAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/etcCsOne.jsp?oqNo="+oqNo);
		return;
	} else {
		System.out.println("updateEtcCsOneAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
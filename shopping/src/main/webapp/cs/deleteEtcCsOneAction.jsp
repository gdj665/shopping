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
	String id = "admin";

	//CsDao.java 선언
	CsDao csdao = new CsDao();
	
	// 12) 질문 입력테이블에 질문 입력하면 질문 테이블에 데이터 추가
	int row = csdao.deleteEtcCsOne(oqNo);
	
	if(row==1){
		System.out.println("deleteEtcCsOneAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/cs/etcCsList.jsp?id="+id);
		return;
	} else {
		System.out.println("deleteEtcCsOneAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
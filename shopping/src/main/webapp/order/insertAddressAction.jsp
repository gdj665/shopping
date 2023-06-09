<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 유효성 검사
	if(request.getParameter("address1")==null
		||request.getParameter("address2")==null
		||session.getAttribute("loginId")==null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("insertAddressAction null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값 받아오기
	String address = request.getParameter("address1")+","+request.getParameter("address2");
	String id = (String)session.getAttribute("loginId");
	
	// OrderDao 사용 선언
	OrderDao orderdao = new OrderDao();
	
	// 20) 주소 추가 메서드
	int row = orderdao.insertAddress(id,address);
	
	// row값 분기 설정
	if(row>0){
		System.out.println("insertAddressAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/order/selectAddress.jsp?id="+id);
		return;
	}else{
		System.out.println("insertAddressAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
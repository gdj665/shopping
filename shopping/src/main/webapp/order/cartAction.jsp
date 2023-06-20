<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");

	//유효성 검사
	if(session.getAttribute("loginId") == null){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("cartAction null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}

	// 값 받아오기
	String id = (String)session.getAttribute("loginId");
	
	// OrderDao 선언
	OrderDao orderdao = new OrderDao();
	
	// 5) 카트안에 체크된 항목 금액 총합 데이터삽입
	int row = orderdao.insertSumTotalPrice(id);
	
	// row값에 따른 분기문 선언
	if(row==1){
		System.out.println("cartAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/order/order.jsp?id="+id);
		return;
	}else{
		System.out.println("cartAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
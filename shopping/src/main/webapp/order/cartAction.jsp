<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// 메세지 출력 설정
	String msg = null;
	
	
	// 값 받아오기
	String id = "admin";
	
	
	OrderDao orderdao = new OrderDao();
	// 5-1 카트안에 체크된 항목 금액 총합 데이터삽입
	int row = orderdao.insertsumtotalprice(id);
	
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
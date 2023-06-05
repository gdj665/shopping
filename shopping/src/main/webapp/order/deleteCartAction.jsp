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
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	String id = "admin";
	

	// 4) 장바구니 단일 삭제 메서드
	OrderDao orderdao = new OrderDao();
	int row = orderdao.deletecart(cartNo);
	
	if(row==1){
		System.out.println("deleteCartAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/order/cart.jsp?id="+id);
		return;
	}else{
		System.out.println("deleteCartAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
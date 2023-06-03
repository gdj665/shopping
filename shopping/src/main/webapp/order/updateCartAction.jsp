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
	String checked = null;
	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	
	// 유효성검사
	if(request.getParameter("checked")==null){
		checked = "N";
	} else {
		checked = "Y";
	}
	
	OrderDao orderdao = new OrderDao();
	// 18)
	int row = orderdao.updateCartData(checked,cartCnt,id,cartNo);
	
	if(row==1){
		System.out.println("updateCartAction row값 정상");
		response.sendRedirect(request.getContextPath()+"/order/cart.jsp?id="+id);
		return;
	}else{
		System.out.println("updateCartAction row값 오류");
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
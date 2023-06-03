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
	int usePoint = Integer.parseInt(request.getParameter("usepoint"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	// OrderDao 사용 선언
	OrderDao orderdao = new OrderDao();
	
	int row = orderdao.updateUsePoint(usePoint,orderNo);
	
	if(row==1){
		System.out.println("포인트 변경 성공");
		response.sendRedirect(request.getContextPath()+"/order/order.jsp");
		return;
	} else {
		System.out.println("포인트 변경 실패");
		response.sendRedirect(request.getContextPath()+"/order/order.jsp");
		return;
	}
%>
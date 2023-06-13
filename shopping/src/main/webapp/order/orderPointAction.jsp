<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if((request.getParameterValues("usepoint")==null)
		||(request.getParameterValues("orderNo")==null)){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("orderPointAction null 있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값 받아오기
	int usePoint = Integer.parseInt(request.getParameter("usepoint"));
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	// OrderDao 사용 선언
	OrderDao orderdao = new OrderDao();
	
	
	// 17) 사용 포인트량 변경
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
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
	String[] checkedValues = request.getParameterValues("checked");
	String[] cartCntValues = request.getParameterValues("cartCnt");
	String[] cartNoValues = request.getParameterValues("cartNo");
	int row = 0;
	// 값 디버깅
	System.out.println("checkedValues.length-->" + checkedValues.length);
	System.out.println("checkedValues-->" + Arrays.toString(checkedValues));
	System.out.println("cartCntValues.length-->" + cartCntValues.length);
	System.out.println("cartNoValues.length-->" + cartNoValues.length);
	
	// 받아온 모든 값이 null이 아닐경우 실행
	if (checkedValues != null && cartCntValues != null && cartNoValues != null) {
		// cartNo의 길이만큼 for문 실행
		for (int i = 0; i < cartNoValues.length; i++) {
			// checked는 Y또는 N으로 값이 들어오므로 
			String checked = request.getParameter("checked");
			checked = (checked != null && checked.equals("Y")) ? "Y" : "N";
			System.out.println("checked-->" + checked);
			int cartCnt = 0;
			int cartNo = Integer.parseInt(cartNoValues[i]);
		
			if (cartCntValues.length > i && cartCntValues[i] != null) {
				cartCnt = Integer.parseInt(cartCntValues[i]);
			}
			// for문 만큼 update메서드 실행
			OrderDao orderdao = new OrderDao();
			row = orderdao.updateCartData(checked, cartCnt, id, cartNo);
		}
	}
	
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
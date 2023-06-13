<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	// OrderDao 사용 선언
	OrderDao orderdao = new OrderDao();
	
	
	// 유효성 검사
	if((request.getParameterValues("cartCnt")==null)
		||(request.getParameterValues("cartNo")==null)
		||(session.getAttribute("loginId")==null)){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("updateCartAction null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	
	// 값 받아오기
	String id = (String)session.getAttribute("loginId");
	String[] cartCntValues = request.getParameterValues("cartCnt");
	String[] cartNoValues = request.getParameterValues("cartNo");
	// row값 분기 변수 선언
	int row = 0;
	
	
	// 카트 번호와 카트수량 디버깅
	System.out.println("cartCntValues.length-->" + cartCntValues.length);
	System.out.println("cartNoValues.length-->" + cartNoValues.length);
	
	
	// checkbox를 통해서 값 가져오기
	// 새로운 array를 cartNoValues의 길이 만큼 생성
	String[] array = new String[cartNoValues.length];
	// array의 길이만큼 반복문 진행
	for(int i =0; i < array.length; i++){
		// checked 변수 선언 (cart.jsp의 checkbox name)
		String checked = "checked" + i;
		// checked로 들어오는 값 디버깅
		System.out.println("checked-->" + checked);
		System.out.println("request.getParameter-->" + request.getParameter(checked));
		// checkbox에서 선택을 해서 value값이 Y가 넘어오면 해당 배열에 Y 아닐시에 N 삽입
		if ("Y".equals(request.getParameter(checked))) {
			array[i] = "Y";
			System.out.println("array["+i+"]-->" + array[i]);
		} else {
			array[i] = "N";
			System.out.println("array["+i+"]-->" + array[i]);
		}
	}// for문 닫기
	
	
	// 받아온 모든 값이 null이 아닐경우 실행
	if (array != null && cartCntValues != null && cartNoValues != null) {
		// cartNo의 길이만큼 for문 실행
		for (int i = 0; i < array.length; i++) {
			// checked는 Y또는 N으로 값이 들어오므로 
			String checked = array[i];
			checked = (checked != null && checked.equals("Y")) ? "Y" : "N";
			System.out.println("checked-->" + checked);
			int cartCnt = 0;
			int cartNo = Integer.parseInt(cartNoValues[i]);
		
			if (cartCntValues.length > i && cartCntValues[i] != null) {
				cartCnt = Integer.parseInt(cartCntValues[i]);
			}
			// for문 만큼 update메서드 실행
			// 18) OrdrDao 장바구니 업데이트 하는 메서드
			row = orderdao.updateCartData(checked, cartCnt, id, cartNo);
		}// for문닫기
	}// if문 닫기
	  
	
	// 성공 실패 분기
	if(row==1){
		System.out.println("updateCartAction row값 정상");
		// 성공시에 다시 카트 페이지로 이동
		response.sendRedirect(request.getContextPath()+"/order/cart.jsp?id="+id);
		return;
	}else{
		System.out.println("updateCartAction row값 오류");
		// 실패시에 이전 페이지로 이동
		response.sendRedirect(request.getHeader("Referer"));
		return;
	}
%>
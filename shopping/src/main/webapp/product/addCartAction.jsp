<%@page import="java.util.ArrayList"%>
<%@page import="vo.order.Cart"%>
<%@ page import = "dao.order.*" %>
<%@page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("productNo") == null
    	||request.getParameter("cartCnt") == null) {
        response.sendRedirect(request.getContextPath() + "/home.jsp");
        return;
    }

    String id = (String)session.getAttribute("loginId");
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
    
    if(session.getAttribute("loginId")!=null){
    	// OrderDao사용 선언
    	OrderDao orderdao = new OrderDao();
    	int row = orderdao.insertCartAction(id,productNo,cartCnt);
    	
    	// 제품 상세 페이지로 이동합니다.
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
		return;
    }
    
	Cart cart = new Cart();
	cart.setId(id);
	cart.setProductNo(productNo);
	cart.setCartCnt(cartCnt);
    
	// 비회원인 경우에는 바로 장바구니를 생성하고 제품을 추가
	if (session.getAttribute("loginId") == null) {
		HashMap<String, Cart> cartMap;
		if (session.getAttribute("cartMap") == null) {
			// 장바구니가 없으면 새로운 HashMap을 생성합니다.
			cartMap = new HashMap<>();
			session.setAttribute("cartMap", cartMap);
		} else {
			// 장바구니가 이미 있으면 기존 맵을 사용합니다.
			cartMap = (HashMap<String, Cart>) session.getAttribute("cartMap");
		}
		//기본 ckProduct false선언
		boolean ckProduct = false;
	    for (Cart ckCart : cartMap.values()) {
	    	// 원래있던 카트에 productNo와 추가된 cartNo가 같으면 진행
	        if (ckCart.getProductNo()==(productNo)) {
	            // 동일한 ProductNo가 있으면 해당 cartCnt를 증가시킵니다.
	            ckCart.setCartCnt(ckCart.getCartCnt() + cartCnt);
	            // true로 변환시켜서 제품추가 다시 안되도록 설정
	            ckProduct = true;
	        }
	    }
	    // 동일 제품 추가안된 제품의 경우에는 새롭게 추가
	    if (!ckProduct) {
		// 제품을 추가
		// 제품을 추가할때마다 새로운 ID값을 추가
		cart.setId(UUID.randomUUID().toString());
		cartMap.put(cart.getId(), cart);
	    }
		// 디버깅용 코드
		for (Cart c : cartMap.values()) {
			System.out.println(c.getId());
			System.out.println(c.getProductNo());
			System.out.println(c.getCartCnt());
		}
		// 제품 상세 페이지로 이동합니다.
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
		return;
	}
%>
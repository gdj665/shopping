<%@page import="java.util.ArrayList"%>
<%@page import="vo.order.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (request.getParameter("productNo") == null) {
        response.sendRedirect(request.getContextPath() + "/home.jsp");
        return;
    }

    String id = (String)session.getAttribute("loginId");
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
    Cart cart = new Cart();
    cart.setId(id);
    cart.setProductNo(productNo);
    cart.setCartCnt(cartCnt);
    
    // 비회원인 경우에는 바로 장바구니를 생성하고 제품을 추가
    if ("notLoginId".equals(id)) {
        ArrayList<Cart> cartList;
        if (session.getAttribute("cartList") == null) {
        	// 장바구니가 없으면 새로운 arrayList생성
            cartList = new ArrayList<>();
            session.setAttribute("cartList", cartList);
        } else {
        	// 장바구니가 이미 있으면 기존 리스트사용
            cartList = (ArrayList<Cart>) session.getAttribute("cartList");
        }
        // 제품 추가
        cartList.add(cart);
        
        // 디버깅용 코드
	        for (Cart c : cartList) {
	            System.out.println(c.getId());
	            System.out.println(c.getProductNo());
	            System.out.println(c.getCartCnt());
	        }
        // 제품상세페이지로 이동
        response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
        return;
    }
    
    // 로그인한 사용자인 경우에는 기존 코드를 실행
    if (session.getAttribute("cartList") == null) {
        ArrayList<Cart> cartList = new ArrayList<>();
        cartList.add(cart);
        session.setAttribute("cartList", cartList);
        response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
        return;
    }
    
    // 장바구니 리스트가 있는 경우에는 기존 리스트에 추가
    ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cartList");
    cartList.add(cart);
    session.setAttribute("cartList", cartList);
    
    // 제품상세페이지로 이동
    response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
%>
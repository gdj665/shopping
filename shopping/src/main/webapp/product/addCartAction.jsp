<%@page import="java.util.ArrayList"%>
<%@page import="vo.order.Cart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (request.getParameter("productNo") == null){
		response.sendRedirect(request.getContextPath() + "/home.jsp");
		return;
	}

	String id = request.getParameter("id");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int cartCnt = Integer.parseInt(request.getParameter("cartCnt"));
	Cart cart = new Cart();
	cart.setId(id);
	cart.setProductNo(productNo);
	cart.setCartCnt(cartCnt);
	if ("notLoginId".equals(id)){
		if (session.getAttribute("cartList") == null){
			ArrayList<Cart> cartList = new ArrayList<>();
			cartList.add(cart);
			session.setAttribute("cartList", cartList);
			response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
			return;
		}
		ArrayList<Cart> cartList = new ArrayList<>();
		cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		cartList.add(cart);
		session.setAttribute("cartList", cartList);
		//System.out.println("check addCartAction");
		cartList = (ArrayList<Cart>)session.getAttribute("cartList");
		for (Cart c : cartList){
			System.out.println(c.getId());
			System.out.println(c.getProductNo());
			System.out.println(c.getCartCnt());
		}
		response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo=" + productNo);
		return;
	}
	
	
	
%>
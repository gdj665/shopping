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
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String address = request.getParameter("address");
	
	// OrderDao 사용 선언
	OrderDao orderdao = new OrderDao();
	
	// 11) orders_cart테이블에 order_no와 매칭되는 cart_no 삽입
	ArrayList<Integer> list = new ArrayList<>();
	list = orderdao.insertOrdersCart();
	System.out.println(list);
	
	// 12) orders_cart에 있는 정보를 토대로 orders_history에 데이터 이관
	ArrayList<Integer> list2 = new ArrayList<>();
	list2 = orderdao.insertOrdersHistory(id);
	System.out.println(list2);
	
	// 13) 결제가 완료되면 order_status가 0에서 1로변경 (0은 결제미완료 1은 결제완료)
	int row = orderdao.updateOrderStatus(orderNo);
	System.out.println(row);
	
	// 16) order 주소 업데이트
	int row4 = orderdao.addressOrder(address,orderNo);
	System.out.println(row4);
	
	// 14) check="Y"인 cart테이블 정보와 order_status=0인 orders 테이블 정보를 지우기(orders_cart테이블도 같이 지워짐)
	int row2 = orderdao.deleteData(id);
	System.out.println(row2);
	
	// 15) point_history 테이블에 결제금액 의 1퍼센트 적립
	int row3 = orderdao.pointstat(orderNo);
	System.out.println(row3);
	
	// 성공 여부에 따른 페이지 출력
	if(row>0 && row2>0 && row3>0){
		System.out.println("주문 결제완료");
		response.sendRedirect(request.getContextPath()+"/order/successOrder.jsp");
		return;
	} else {
		System.out.println("주문 결제실패");
		response.sendRedirect(request.getContextPath()+"/order/failOrder.jsp");
		return;
	}
%>
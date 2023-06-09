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
	if((request.getParameter("orderNo")==null)
		||(request.getParameter("address")==null)
		||(session.getAttribute("loginId") == null)){
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("orderAction null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 값 받아오기
	String id = (String)session.getAttribute("loginId");
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String address = request.getParameter("address");
	
	// 디버깅
	System.out.println("id-->"+id);
	System.out.println("orderNo-->"+orderNo);
	System.out.println("address-->"+address);
	
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
	System.out.println("row-->"+row);
	
	// 16) order 주소 업데이트
	int row4 = orderdao.addressOrder(address,orderNo);
	System.out.println("row4-->"+row4);
	
	// 14) check="Y"인 cart테이블 정보와 order_status=0인 orders 테이블 정보를 지우기(orders_cart테이블도 같이 지워짐)
	int row2 = orderdao.deleteData(id);
	System.out.println("row2-->"+row2);
	
	// 15) point_history 테이블에 결제금액 의 1퍼센트 적립
	// 랭크에 따른 적립량 다름 브론즈 1퍼 실버 1.5퍼 골드 2퍼
	int row3 = orderdao.pointstat(orderNo,id);
	System.out.println("row3-->"+row3);
	
	// 19) 제품 구매에 의한 재고량 변경
	int row5 = orderdao.updateProductStock(orderNo);
	System.out.println("row5-->"+row5);
	
	// 29) 구매금액조회 후 랭크 변경
	int row7 = orderdao.threeMonthAmount(id);
	System.out.println("row7-->"+row7);
	
	// 21) 제품 구매할때 최근 사용 주소 변경
	// 주소 변경 시에만 사용
	int row6 = orderdao.updateAddressDate(address);
	System.out.println("row6-->"+row6);
	
	// 성공 여부에 따른 페이지 출력
	if(row>0 && row2>0 && row3>0  && row4>0 && row5>0 && row7>0){
		System.out.println("주문 결제완료");
		String msg = "결제가 완료되었습니다";
		String redirectUrl = request.getContextPath()+"/customer/orderMyPage.jsp";
		
		// alert 메세지 출력
		String script = 
				"<script>"+
					"alert('" + msg + "');"+
					"window.location.href='" + redirectUrl + "';"+
				"</script>";
		response.getWriter().println(script);
		return;
		
	} else {
		
		System.out.println("주문 결제실패");
		String msg = "결제가 실패하였습니다 관리자에게 문의해주시기 바랍니다";
		String redirectUrl = request.getContextPath()+"/home.jsp";
		
		// alert 메세지 출력
		String script = 
				"<script>"+
					"alert('" + msg + "');"+
					"window.location.href='" + redirectUrl + "';"+
				"</script>";
		response.getWriter().println(script);
		return;
	}
%>
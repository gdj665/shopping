<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.order.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	//유효성 검사
	if(session.getAttribute("loginId") == null){
		
		// null값이 있을 경우 로그인 페이지로 이동
		System.out.println("order null있음");
		
		String msg = "로그인이 필요합니다.";
		String redirectUrl = request.getContextPath() + "/customer/login.jsp";
		
		// alert 메세지 출력
		String script = 
				"<script>"+
					"alert('" + msg + "');"+
					"window.location.href='" + redirectUrl + "';"+
				"</script>";
		response.getWriter().println(script);
		return;
	}

	// 값 받아오기
	String id = (String)session.getAttribute("loginId");
	
	//OrderDao 선언
	OrderDao orderdao = new OrderDao();

	// 6) 주문내역 간략하게 받기
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	list2 = orderdao.finishorder(id);
	
	// 7) 받을 주소출력
	ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	list = orderdao.addressName(id);
	
	// 9) 주문자 정보 받아오기
	ArrayList<Customer> list3 = new ArrayList<>();
	list3 = orderdao.orderinfo(id);
	
	// 10) 주문정보가져오기
	ArrayList<HashMap<String,Object>> list4 = new ArrayList<>();
	list4 = orderdao.selordertable(id);
	
	// 23) 가장 최근 사용 주소가져오기
	ArrayList<HashMap<String,Object>> list5 = new ArrayList<>();
	
	
	// 24) 해당 아이디의 기본 회원 정보 주소 가져오기
	ArrayList<HashMap<String,Object>> list6 = new ArrayList<>();
	list6 = orderdao.addressRegister(id);
	
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>주문하기</title>
</head>

<body>
	<!-- 검색 최상단 호출 -->
    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<!-- nav 호출 -->
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>

    <!-- Shopping Cart Section Begin -->
    <section class="checkout-section spad">
        <div class="container">
            <form id="orderForm" action="<%=request.getContextPath()%>/order/orderAction.jsp" class="checkout-form" method="post">
                <div class="row">
                    <div class="col-lg-6">
                        <!-- 주문자 기본 정보 삽입 -->
                        <h4>주문자 정보</h4>
                        <div class="row">
                        	<!-- 주문자 이름, 이메일, 포인트량, 포인트 사용량 출력 -->
                        	<%
								for(Customer c : list3){
							%>
								<!-- 주문자 이름 -->
	                            <div class="col-lg-6">
	                                <label for="fir">주문자 이름</label>
	                                <input type="text" id="fir" value="<%=c.getCstmName() %>" readonly="readonly">
	                            </div>
	                            <!-- 주문자 이메일 -->
	                            <div class="col-lg-6">
	                                <label for="last">주문자 이메일</label>
	                                <input type="text" id="last" value="<%=c.getCstmEmail() %>" readonly="readonly">
	                            </div>
	                            <!-- 보유 포인트 -->
	                            <div class="col-lg-4">
	                                <label for="cun-name">보유포인트</label>
	                                <input type="text" id="cun-name" value="<%=c.getCstmPoint() %>" readonly="readonly">
	                            </div>
	                            <!-- 사용 포인트 -->
	                            <%
									for(HashMap<String,Object> m : list4){
								%>
		                            <div class="col-lg-4">
		                                <label for="cun-name">사용포인트</label>
		                                <input type="text" value="<%=(int)m.get("orderPointUse")%>" readonly="readonly">
		                            </div>
	                            <%	
									}
								%>
								<!-- 포인트사용 버튼 -->
	                            <div class="col-lg-4">
	                            	<label for="cun-name">&nbsp;</label>
	                            	<a href="#" id="pointLink" style="padding-left:40px; display: flex; align-items: center; text-decoration: none;" class="site-btn place-btn">포인트사용</a>
	                            </div>
                            <%
								}
                            %>
                            
                            <!-- 주소정보 // 7번메서드 사용 -->
						    <div class="col-lg-2" style="display: flex; align-items: center;">
						        <label for="street">주소</label>
						    </div>
						    <!-- 최근사용 주소 -->
						    <div class="col-lg-6" style="display: flex; align-items: center;">
						        <a href="#" id="addressBtn" class="btn btn-outline-dark btn-sm">최근 사용주소 보기</a>
						    </div>
						    <br><br>
							<%
								int addressNo = 0;
                           		if(request.getParameter("addressNo")==null){
                           			System.out.println("order.jsp-->addressNo없음");
									for(HashMap<String,Object> m2 : list6){
							%>
										<!-- 기본 회원가입 주소 -->
										<div class="col-lg-12">
											<input name="address" type="text" value="<%=m2.get("cstmAddress") %>"><br>
										</div>
							<%
									}
								} else if(request.getParameter("addressNo")!=null) {
									addressNo = Integer.parseInt(request.getParameter("addressNo"));
									System.out.println("order.jsp-->addressNo있음-->"+addressNo);
									list5 = orderdao.addressRecentlyOne(addressNo);
									for(HashMap<String,Object> m : list5){
							%>
										<!-- addressNo를 받고 주소 출력 -->
										<div class="col-lg-12">
											<input name="address" type="text" value="<%=m.get("address") %>"><br>
										</div>
							<%	
									}
								}
							%>
                        </div>
                    </div>
                    <!-- order.jsp 우측 메인부분 출력 -->
                    <div class="col-lg-6">
                        <div class="place-order">
                        	<!-- 제품 리스트 출력 -->
                            <h4>Your Order</h4>
                            <div class="order-total">
                                <ul class="order-table">
                                    <li>제품명<span>수량</span></li>
                                    <!-- 제품명과 수량 출력 -->
                                    <%
										for(HashMap<String,Object> m : list2){
									%>
	                                    <li class="fw-normal">
		                                    <%=(String)m.get("productName") %>
		                                    <span><%=(int)m.get("cartCnt") %></span>
		                                </li>
                                    <%
										}
									%>
										<li class="fw-normal"></li>
									<!-- 총가격, 포인트사용량, 최종가격 출력 -->
									<%
										for(HashMap<String,Object> m : list4){
									%>
                                 		<li class="fw-normal">Subtotal <span><%=(int)m.get("orderPrice")%></span></li>
                                 		<li class="fw-normal">Use Point<span><%=(int)m.get("orderPointUse") %></span></li>
	                                    <li class="total-price">Total <span><%=(int)m.get("totalPrice")%></span></li>
	                                    <input type="hidden" name="orderNo" value="<%=(int)m.get("orderNo")%>">
                                    <%	
										}
									%>
                                </ul>
                                <!--  결제하기 버튼 -->
                                <div class="order-btn">
                                    <button id="orderBtn" type="submit" class="site-btn place-btn">결제하기</button>
                                </div>
                            </div>
                        </div>
                    </div><!-- 메인 우측부분 종료 -->
                </div>
            </form>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
<script>
	// 주소 창 열기
	$('#addressBtn').click(function(){
		let id = '<%= id %>';
		let url = '<%=request.getContextPath()%>/order/selectAddress.jsp?id=' + id;
		open(url, '', 'width=500,height=500');
	});
	// 포인트 사용 창 열기
	$('#pointLink').click(function(){
		<% for(HashMap<String,Object> m : list4){ %>
			let url = '<%=request.getContextPath() %>/order/orderPoint.jsp?orderNo=<%=(int)m.get("orderNo")%>';
			open(url, '_blank', 'width=500,height=500');
		<% } %>
	});
	$('#orderBtn').click(function(){
		$('#orderForm').submit();
	});
</script>
</body>
</html>
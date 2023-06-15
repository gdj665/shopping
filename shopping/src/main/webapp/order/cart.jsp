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
	if(session.getAttribute("loginId") == null){
		
		// null값이 있을 경우 로그인 페이지로 이동
		System.out.println("cart null있음");
		
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

	// OrderDao사용 선언
	OrderDao orderdao = new OrderDao();
	
	// 1) OrderDao 장바구니 리스트 출력 메서드
	ArrayList<HashMap<String,Object>> list = orderdao.cartList(id);
	
	// 2) OrderDao 장바구니 각 항목의 총 합계의 최종합계를 구하는 메서드
	int row = orderdao.totalPrice(id);
	
	// 제품 카트 checked 분기설정
	int cnt = 0;
%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title></title>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Fashi | Template</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/themify-icons.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/elegant-icons.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/owl.carousel.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/nice-select.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/jquery-ui.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/slicknav.min.css" type="text/css">
	<link rel="stylesheet" href="<%=request.getContextPath() %>/template/css/style.css" type="text/css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<style>
		a {
			text-decoration: none;
			color: #000000;
		}
	</style>
</head>

<body>
    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>

    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                    	<form action="<%=request.getContextPath() %>/order/updateCartAction.jsp">
                        <table>
                            <thead>
	                            <tr>
									<th>선택</th>
									<th>이미지</th>
									<th class="p-name">상품명</th>
									<th>가격</th>
									<th>수량</th>
									<th>합계</th>
									<th><i class="ti-close"></i></th>
								</tr>
                            </thead>
                            <tbody>
                            	<!-- 장바구니 리스트 출력문 -->
								<%
									// 장바구니 리스트 출력
									for(HashMap<String,Object> m : list){
										int productNo = (int)m.get("productNo");
										int cartCnt = (int)m.get("cartCnt");
										String checked = (String)m.get("checked");
										
										
										// 3) 각 제품의 재고량을 구하는 메서드
										int tcnt = orderdao.totalstock(productNo);
								%>
                                <tr>
                                	<!-- 카트 테이블 기본키 넘기기 -->
                                	<!-- 장바구니 체크박스 -->
                                	<td>
										<input type="hidden" name="cartNo" value="<%=(int)m.get("cartNo")%>">
										<input name="checked<%=cnt%>" value="Y" class="form-check-input" type="checkbox" <%= (checked != null && checked.equals("Y")) ? "checked" : "" %>/>
									</td>
									<!-- 장바구니 사진삽입 -->
                                    <td class="cart-pic first-row">
                                    	<img style="width:100px; height:100px;" src="<%=request.getContextPath() + "/img/productImg/" + (String)m.get("productSaveFilename")%>">
                                    </td>
                                    <!-- 제품이름 -->
                                    <td class="cart-title first-row">
                                        <%=(String)m.get("productName") %>
                                    </td>
                                    <!-- 할인률 적용 후 가격 -->
                                    <td class="p-price first-row">
                                 	   <%=m.get("discountPrice")%>
                                    </td>
                                    <!-- 해당 제품의 재고량 안에서 수량 선택 가능 -->
                                    <td class="qua-col first-row">
	                                    <div class="pro-qty">
											<input name="cartCnt" id="cartQty" value="<%=cartCnt %>" type="text">
										</div>
									</td>
									<!-- 제품과 갯수를 고른 뒤 총 합을 출력 (장바구니 전체 출력 X) -->
                                    <td class="total-price first-row"><%=m.get("totalPrice") %></td>
                                    <td class="close-td first-row">
	                                    <a href="<%=request.getContextPath()%>/order/deleteCartAction.jsp?cartNo=<%=(int)m.get("cartNo")%>">
											<i class="ti-close"></i>
	                                    </a>
                                    </td>
                                </tr>
                                <%
									cnt++;
									}
								%>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="cart-buttons">
                                <a href="#" class="primary-btn continue-shop">Continue shopping</a>
                                <button type="submit" class="primary-btn up-cart">장바구니 정보 변경</button>
                            </div>
                            </form>
                        </div>
                        <div class="col-lg-4 offset-lg-4">
							<div class="proceed-checkout">
								<ul>
									<li class="cart-total">Total <span><%=row%>원</span></li>
								</ul>
									<a id="buyButton" href="#" class="proceed-btn" onclick="checkCart()">구매하기</a>
							</div><!-- proceed-checkout -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->

<!-- Js Plugins -->
<script src="<%=request.getContextPath() %>/template/js/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.countdown.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.nice-select.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.zoom.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.dd.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/jquery.slicknav.js"></script>
<script src="<%=request.getContextPath() %>/template/js/owl.carousel.min.js"></script>
<script src="<%=request.getContextPath() %>/template/js/main.js"></script>
<script>
	// 구매하기 버튼을 눌럿는대 장바구니에서 체크된 항목이 없으면 장바구니에 선택된 제품이 없다고 메세지 출력
	// 장바구니에 제품이 있을 경우 구매 페이지로 이동
	$('#buyButton').click(function(){
		// totalAmount에 장바구니 총 합산 금액 삽입
		let totalAmount = <%=row%>;
		// 토탈금액이 0원일 경우
		if (totalAmount === 0) {
		// 제품이 한개도 없다면 alert메세지로 하단의 문구 출력
			alert("장바구니에서 선택된 제품이 없습니다.");
		} else {
		// 제품이 있다면 cartAction.jsp 실행
			location.href = "<%=request.getContextPath()%>/order/cartAction.jsp?id=<%=id%>";
		}
	});
	$('#cartQty').change(function(){
		
	});
</script>
<script>
	// 제품 수량을 재고량 보다 많이 입력했을 때 재고량 만큼만 입력되게함
	<%
		for(HashMap<String,Object> m : list){
			int productNo = (int)m.get("productNo");
			int tcnt = orderdao.totalstock(productNo);
			
	%>
			$(document).ready(function() {
				$('#cartQty').on('input', function() {
					var maxValue = <%=tcnt%>;
					var currentValue = parseInt($(this).val());
					
					if (currentValue > maxValue) {
						$(this).val(maxValue);
					}
				});
			});
	<%
		}
	%>
</script>
</body>

</html>
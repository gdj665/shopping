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
		
		// null값이 있을 경우 홈으로 이동
		System.out.println("cart null있음");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
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
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="header-top">
            <div class="container">
                <div class="ht-left">
                    <div class="mail-service">
                        <i class=" fa fa-envelope"></i>
                        hello.colorlib@gmail.com
                    </div>
                    <div class="phone-service">
                        <i class=" fa fa-phone"></i>
                        +65 11.188.888
                    </div>
                </div>
                <div class="ht-right">
                    <a href="#" class="login-panel"><i class="fa fa-user"></i>Login</a>
                    <div class="lan-selector">
                        <select class="language_drop" name="countries" id="countries" style="width:300px;">
                            <option value='yt' data-image="img/flag-1.jpg" data-imagecss="flag yt"
                                data-title="English">English</option>
                            <option value='yu' data-image="img/flag-2.jpg" data-imagecss="flag yu"
                                data-title="Bangladesh">German </option>
                        </select>
                    </div>
                    <div class="top-social">
                        <a href="#"><i class="ti-facebook"></i></a>
                        <a href="#"><i class="ti-twitter-alt"></i></a>
                        <a href="#"><i class="ti-linkedin"></i></a>
                        <a href="#"><i class="ti-pinterest"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                        <div class="logo">
                            <a href="./index.html">
                                <img src="img/logo.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-7">
                        <div class="advanced-search">
                            <button type="button" class="category-btn">All Categories</button>
                            <form action="#" class="input-group">
                                <input type="text" placeholder="What do you need?">
                                <button type="button"><i class="ti-search"></i></button>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-3 text-right col-md-3">
                        <ul class="nav-right">
                            <li class="heart-icon"><a href="#">
                                    <i class="icon_heart_alt"></i>
                                    <span>1</span>
                                </a>
                            </li>
                            <li class="cart-icon"><a href="#">
                                    <i class="icon_bag_alt"></i>
                                    <span>3</span>
                                </a>
                                <div class="cart-hover">
                                    <div class="select-items">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class="si-pic"><img src="img/select-product-1.jpg" alt=""></td>
                                                    <td class="si-text">
                                                        <div class="product-selected">
                                                            <p>$60.00 x 1</p>
                                                            <h6>Kabino Bedside Table</h6>
                                                        </div>
                                                    </td>
                                                    <td class="si-close">
                                                        <i class="ti-close"></i>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="si-pic"><img src="img/select-product-2.jpg" alt=""></td>
                                                    <td class="si-text">
                                                        <div class="product-selected">
                                                            <p>$60.00 x 1</p>
                                                            <h6>Kabino Bedside Table</h6>
                                                        </div>
                                                    </td>
                                                    <td class="si-close">
                                                        <i class="ti-close"></i>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="select-total">
                                        <span>total:</span>
                                        <h5>$120.00</h5>
                                    </div>
                                    <div class="select-button">
                                        <a href="#" class="primary-btn view-card">VIEW CARD</a>
                                        <a href="#" class="primary-btn checkout-btn">CHECK OUT</a>
                                    </div>
                                </div>
                            </li>
                            <li class="cart-price">$150.00</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="nav-item">
            <div class="container">
                <div class="nav-depart">
                    <div class="depart-btn">
                        <i class="ti-menu"></i>
                        <span>All departments</span>
                        <ul class="depart-hover">
                            <li class="active"><a href="#">Womenâs Clothing</a></li>
                            <li><a href="#">Menâs Clothing</a></li>
                            <li><a href="#">Underwear</a></li>
                            <li><a href="#">Kid's Clothing</a></li>
                            <li><a href="#">Brand Fashion</a></li>
                            <li><a href="#">Accessories/Shoes</a></li>
                            <li><a href="#">Luxury Brands</a></li>
                            <li><a href="#">Brand Outdoor Apparel</a></li>
                        </ul>
                    </div>
                </div>
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="./index.html">Home</a></li>
                        <li><a href="./shop.html">Shop</a></li>
                        <li><a href="#">Collection</a>
                            <ul class="dropdown">
                                <li><a href="#">Men's</a></li>
                                <li><a href="#">Women's</a></li>
                                <li><a href="#">Kid's</a></li>
                            </ul>
                        </li>
                        <li><a href="./blog.html">Blog</a></li>
                        <li><a href="./contact.html">Contact</a></li>
                        <li><a href="#">Pages</a>
                            <ul class="dropdown">
                                <li><a href="./blog-details.html">Blog Details</a></li>
                                <li><a href="./shopping-cart.html">Shopping Cart</a></li>
                                <li><a href="./check-out.html">Checkout</a></li>
                                <li><a href="./faq.html">Faq</a></li>
                                <li><a href="./register.html">Register</a></li>
                                <li><a href="./login.html">Login</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    <!-- Header End -->

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="./home.html"><i class="fa fa-home"></i> Home</a>
                        <a href="./shop.html">Shop</a>
                        <span>Shopping Cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

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
                                    	<img src="<%=(String)m.get("productSaveFilename")%>">
                                    	<%=(String)m.get("productSaveFilename")%>
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
                                        <select name="cartCnt" class="form-select">
											<%
												for(int i = 1; i<=tcnt; i++){
											%>
												<!-- 제품 갯수를 변경하면 그 값을 넘김 -->
												<option <%= (i == cartCnt) ? "selected" : "" %> value=<%=i %>><%= i %></option>
											<%
												}
											%>
										</select>
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

    <!-- Partner Logo Section Begin -->
    <div class="partner-logo">
        <div class="container">
            <div class="logo-carousel owl-carousel">
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-1.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-2.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-3.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-4.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-5.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Partner Logo Section End -->

    <!-- Footer Section Begin -->
    <footer class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="footer-left">
                        <div class="footer-logo">
                            <a href="#"><img src="img/footer-logo.png" alt=""></a>
                        </div>
                        <ul>
                            <li>Address: 60-49 Road 11378 New York</li>
                            <li>Phone: +65 11.188.888</li>
                            <li>Email: hello.colorlib@gmail.com</li>
                        </ul>
                        <div class="footer-social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 offset-lg-1">
                    <div class="footer-widget">
                        <h5>Information</h5>
                        <ul>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Checkout</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Serivius</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="footer-widget">
                        <h5>My Account</h5>
                        <ul>
                            <li><a href="#">My Account</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Shopping Cart</a></li>
                            <li><a href="#">Shop</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="newslatter-item">
                        <h5>Join Our Newsletter Now</h5>
                        <p>Get E-mail updates about our latest shop and special offers.</p>
                        <form action="#" class="subscribe-form">
                            <input type="text" placeholder="Enter Your Mail">
                            <button type="button">Subscribe</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright-reserved">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="copyright-text">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;
							<script>document.write(new Date().getFullYear());
							</script> 
							All rights reserved | This template is made with 
							<i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </div>
                        <div class="payment-pic">
                            <img src="img/payment-method.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

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
</script>
</body>

</html>
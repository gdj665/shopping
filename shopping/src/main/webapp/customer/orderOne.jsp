<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.id.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.member.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginId") == null ){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	//세션아이디 변수에 저장
	String id = (String)(session.getAttribute("loginId"));
	
		
	//세션아이디 디버깅
	System.out.println(id+"<--orderMyPage id");	
	
	OrderListDao orderDao = new OrderListDao();
	
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	System.out.println(orderNo + "<-- orderMyPage orderList");
	
	ArrayList<HashMap<String, Object>> list = orderDao.orderOne(orderNo);
	System.out.println(list + "<-- orderMyPage orderList");
	
	
%>
<!DOCTYPE html>
<html lang="zxx">

<div id="preloder">
        <div class="loader"></div>
    </div>

    <div>
		<jsp:include page="/inc/search.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>

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
<!-- ---------------------------------------------------------주문내역----------------------------------------------------------------------------- -->
    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>상품이미지</th>
									<th>주문번호</th>
									<th>상품이름</th>
									<th>상품가격</th>
									<th>배송상태</th>
									<th>구매일</th>
                                </tr>
                            </thead>
                    <%
						for(HashMap<String, Object> m : list){
					%>
                            <tbody>
                                <tr>
                                    <td class="cart-title first-row">
                                        <img src="<%=request.getContextPath() + "/img/productImg/" + (String)(m.get("saveFile"))%>">
                                    </td>
                                    <td class="cart-pic first-row"><%=(Integer)(m.get("orderNo"))%></td>
                                    <td class="p-price first-row"><%=(String)(m.get("productName"))%></td>
                                    <td class="p-price first-row"><%=(Integer)(m.get("productPrice"))%></td>
                                    <td class="p-price first-row">
									<%
										switch((Integer)m.get("orderStatus")){
											case 0:
												out.print("결제 미완료");
												break;
											case 1:
												out.print("결제 완료");
												break;
											case 2:
												out.print("배송 중");
												break;
											case 3:
												out.print("배송 완료");
												break;
											case 4:
												out.print("구매 확정");
												break;
										}
									%>
									</td>
                                    <td class="total-price first-row"><%=(String)(m.get("createdate"))%></td>
                                </tr>
                                
                            </tbody>
							<%
								}
                 			%>
                        </table>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
<!-- ---------------------------------------------------------주문내역----------------------------------------------------------------------------- -->
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
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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
    <script src="<%=request.getContextPath()%>/template/js/jquery-3.3.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.countdown.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.nice-select.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.zoom.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.dd.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/jquery.slicknav.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath()%>/template/js/main.js"></script>
</body>

</html>
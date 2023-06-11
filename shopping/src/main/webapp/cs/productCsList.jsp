<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.cs.*" %>
<%@ page import = "vo.id.*" %>
<%@ page import = "vo.cs.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.order.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//한글 깨짐 방지
	request.setCharacterEncoding("utf-8");
	
	
	// 값 받아오기
	int productNo = 1;
	
	//OrderDao 선언
	CsDao csdao = new CsDao();

	// 1) 제품당 문의 리스트 불러오기
	ArrayList<Qa> list = new ArrayList<>();
	list = csdao.questionList(productNo);
	
	// 2) 답변 리스트 출력
	ArrayList<HashMap<String,Object>> list2 = new ArrayList<>();
	
%>
<!DOCTYPE html>
<html>

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
	a{
		text-decoration: none;
		color:#000000;
	}
	td {
		height:50px;
	}
	.vertical-center {
        display: flex;
        align-items: center;
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
                            <option value='yt' data-image="img/flag.jpg" data-imagecss="flag yt"
                                data-title="English">English</option>
                            <option value='yu' data-image="img/flag.jpg" data-imagecss="flag yu"
                                data-title="Bangladesh">Bangla</option>
                            <option value='yt' data-image="img/flag.jpg" data-imagecss="flag yt"
                                data-title="English">English</option>
                            <option value='yu' data-image="img/flag.jpg" data-imagecss="flag yu"
                                data-title="Bangladesh">Bangla</option>
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
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Home</a>
                        <span>FAQs</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Faq Section Begin -->
    <div class="faq-section spad">
        <div class="container">
            <div class="row">
            	<div class="col-lg-2">
            	</div>
                <div class="col-lg-8">
                    <!-- 제품문의 입력 테이블 (고객 사용 가능) -->
					<form action="<%=request.getContextPath() %>/cs/insertProductCsAction.jsp">
						<input type="hidden" name="productNo" value="<%=productNo %>">
						<table style="width:100%;">
							<tr>
								<th colspan="2">상품문의</th>
							</tr>
							<tr>
								<td style="width:700px;">
									<textarea rows="3" class="form-control" name="qContent" placeholder="문의 내용을 입력해주시기 바랍니다"></textarea>
								</td>
								<td>
									<button style="margin-top:50px; margin-right:30px; float:right;" class="btn btn-outline-dark" type="submit">작성</button>
								</td>
							</tr>
						</table>
						<br>
						<hr>
					</form>
					
					<%
						// 질문 리스트 출력
						for(Qa q : list){
							// 질문 번호 저장
							int qNo = q.getqNo();
							// 저장된 질문번호를 받아서 변수값에 넣기
							list2 = csdao.answerList(qNo);
					%>
							<!-- 질문리스트 출력 -->
							<table style="width:100%;">
								<tr>
									<th style="width:100px;"><sapn style="margin-left:10px; background-color: grey; color:white; font-size:10pt; padding:5px;">질문</sapn></sapn></th>
									<td>ID : <%=q.getId() %></td>
									<td style="float:right;" class="vertical-center">
										<%=q.getCreatedate()%>
										<a href="<%=request.getContextPath()%>/cs/deleteProductQuestionAction.jsp?qNo=<%=q.getqNo()%>&productNo=<%=productNo%>">&nbsp;X&nbsp;</a>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="3"><%=q.getqContent() %></td>
								</tr>
							</table>
					<%
						//질문번호와 answer 테이블에 있는 질문번호가 일치하면 답변 출력
						boolean answer = false;
						for(HashMap<String,Object> m : list2){
							int aqNo = (int)m.get("qNo");
							if (qNo == aqNo){
								answer = true;
					%>
							<table style="width:100%; background-color:#F6F6F6;">
								<tr>
									<td style="font-weight: bold; width:100px;">&nbsp;&nbsp;↳&nbsp; <span style="background-color:#1266FF; color:white; font-size: 10pt; padding:5px;">답변</span></td>
									<td style="font-weight: bold;">[관리자]</td>
									<td style="float:right;" class="vertical-center">
										<%=(String)m.get("createdate")%>
										<a href="<%=request.getContextPath()%>/cs/deleteProductAnswerAction.jsp?productNo=<%=productNo%>&aNo=<%=(int)m.get("aNo")%>">&nbsp;X&nbsp;</a>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2"><%=(String)m.get("aContent")%></td>
								</tr>
							</table>
							
					<%
								}// qNo==apNo 비교 if문
							}// list2 for 문
					%>
					<%		// 질문에 대한 답변이 없을 경우에만 테이블 출력
							if(answer != true){
					%>
								<form action="<%=request.getContextPath()%>/cs/productCsListAction.jsp">
									<table style="width:100%; background-color: #F6F6F6;">
										<tr>
											<th colspan="2"><label style="margin-left:10px; margin-top:10px;">&nbsp;&nbsp;↳&nbsp;답변작성필요</label></th>
										</tr>
										<tr>
											<td style="width:700px;">
												<textarea rows="3" style="margin-left:10px; margin-bottom:20px;" class="form-control" name="aContent" placeholder="답변을 입력해주시기 바랍니다"></textarea>
											</td>
											<td>
												<button style="margin-right:30px; margin-top:30px; float:right;" class="btn btn-outline-dark" type="submit">작성</button>
											</td>
										</tr>
									</table>
									<!-- 값 넘기기 -->
									<input type="hidden" name="qNo" value="<%=qNo %>">
									<input type="hidden" name="productNo" value="<%=productNo %>">
								</form>
					<%	
							}// 답변이 없을경우에는 입력창 출력하는 if문
						}// 질문 리스트 출력 for문
					%>
                </div><!-- col-lg-8 -->
                <div class="col-lg-2">
            	</div>
            </div>
        </div>
    </div>
    <!-- Faq Section End -->

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
</body>

</html>